import AVFoundation
import UIKit
import SDWebImage
import MediaPlayer

class RadioViewModel {
    
    private var audioPlayer: AVPlayer?
    private var audioSession = AVAudioSession.sharedInstance()
    private let screenView: RadioScreen?
    private var service = Service()
    private var timer: Timer?
    private var isPaused: Bool = false
    
    init(screenView: RadioScreen) {
        self.screenView = screenView
    }
    
    func actionPlayButton() {
        screenView?.playButton.addTarget(self, action: #selector(getApiPlay), for: .touchUpInside)
    }
    
    func actionPauseButton() {
        screenView?.pauseButton.addTarget(self, action: #selector(getApiPause), for: .touchUpInside)
    }
    
    @objc private func getApiPlay() {
        self.isPaused = false
        self.service.requestApi { station in
            self.airplayradio(data: station)
            self.playMusic(data: station)
            self.startTimer(tempoEstipulado: TimeInterval(station.nowPlaying?.remaining ?? 0) + 6)
        }
    }
    
    func startTimer(tempoEstipulado: TimeInterval) {
        var remainingTime = tempoEstipulado
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 && !self.isPaused {
                remainingTime -= 1
                print("Tempo restante: \(remainingTime)")
            } else {
                self.timer?.invalidate()  // Interrompe o timer atual
                if !self.isPaused {
                    self.service.requestApi { station in
                        self.updateViewAfterPlay(data: station)
                        self.airplayradio(data: station)
                        self.startNextTimer(tempoEstipulado: TimeInterval(station.nowPlaying?.duration ?? 0) + 6)
                    }
                }
            }
        }
    }
    
    func startNextTimer(tempoEstipulado: TimeInterval) {
        var remainingTime = tempoEstipulado
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 && !self.isPaused {
                remainingTime -= 1
                print("Tempo restante (próxima reprodução): \(remainingTime)")
            } else if remainingTime == 0 || !self.isPaused {
                self.timer?.invalidate()  // Interrompe o timer atual
                if !self.isPaused {
                    self.service.requestApi { station in
                        self.updateViewAfterPlay(data: station)
                        self.airplayradio(data: station)
                        self.startNextTimer(tempoEstipulado: TimeInterval(station.nowPlaying?.duration ?? 0) + 6)
                    }
                }
            }
        }
    }
    
    @objc private func getApiPause() {
        self.isPaused = true
        self.timer?.invalidate()
        self.service.requestApi { station in
            self.pauseMusic(data: station)
        }
    }
    
    private func airplayradio(data: List) {
        let _ = MPRemoteCommandCenter.shared()
        self.configureRemoteCommandCenter()
        
        var nowPlayingInfo: [String: Any] = [
            MPMediaItemPropertyTitle: data.nowPlaying?.song?.title ?? "",
            MPMediaItemPropertyArtist: data.nowPlaying?.song?.artist ?? "",
            MPNowPlayingInfoPropertyPlaybackRate: 1,
        ]
        
        if let artURLString = data.nowPlaying?.song?.art, let artURL = URL(string: artURLString) {
            SDWebImageDownloader.shared.downloadImage(with: artURL) { (image, _, _, _) in
                if let artworkImage = image {
                    nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: artworkImage.size, requestHandler: { _ -> UIImage in
                        return artworkImage
                    })
                    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
                }
            }
        }
    }
    
    private func configureRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget { [weak self] event in
            self?.handlePlayCommand()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] event in
            self?.handlePauseCommand()
            return .success
        }
    }
    
    private func handlePlayCommand() {
        self.isPaused = false
        self.service.requestApi { station in
            self.airplayradio(data: station)
            self.playMusic(data: station)
            self.startTimer(tempoEstipulado: TimeInterval(station.nowPlaying?.remaining ?? 0) + 6)
        }
    }
    
    private func handlePauseCommand() {
        self.isPaused = true
        self.timer?.invalidate()
        self.service.requestApi { station in
            self.pauseMusic(data: station)
        }
    }
    
    private func playMusic(data: List) {
        self.updateViewAfterPlay(data: data)
        guard let musicURL = URL(string: data.station?.listenURL ?? "") else { return }
        self.audioPlayer = AVPlayer(url: musicURL)
        self.audioPlayer?.play()
        self.audioSession = AVAudioSession.sharedInstance()
        do {
            try self.audioSession.setCategory(.playback, mode: .default, options: [])
            try self.audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Erro ao configurar a sessão de áudio: \(error.localizedDescription)")
        }
    }
    
    private func updateViewAfterPlay(data: List) {
        self.screenView?.playButton.isHidden = true
        self.screenView?.pauseButton.isHidden = false
        self.screenView?.artistPlayLabel.isHidden = false
        self.screenView?.titlePlayLabel.isHidden = false
        self.screenView?.titlePlayLabel.text = data.nowPlaying?.song?.title
        self.screenView?.artistPlayLabel.text = data.nowPlaying?.song?.artist
        guard let imgURL = URL(string: data.nowPlaying?.song?.art ?? "") else { return }
        self.screenView?.radioImage.sd_setImage(with: imgURL) { (image, _, _, _) in
            image?.getColors { colors in
                self.screenView?.backgroundView.backgroundColor = colors?.background
                self.screenView?.radioImage.layer.shadowColor = colors?.detail.cgColor
                self.screenView?.titlePlayLabel.textColor = colors?.primary
                self.screenView?.artistPlayLabel.textColor = colors?.detail
                self.screenView?.titleLabel.textColor = colors?.detail
                self.screenView?.subTitleLabel.textColor = colors?.primary
                self.screenView?.liveImage.tintColor = colors?.detail
                self.screenView?.pauseButton.tintColor = colors?.detail
            }
        }
    }
    
    private func pauseMusic(data: List) {
        DispatchQueue.main.async {
            self.audioPlayer?.pause()
            self.screenView?.pauseButton.isHidden = true
            self.screenView?.playButton.isHidden = false
            self.screenView?.radioImage.image = UIImage(named: "radioAzul2")
            self.screenView?.artistPlayLabel.isHidden = true
            self.screenView?.titlePlayLabel.isHidden = true
            self.screenView?.backgroundView.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
            self.screenView?.titleLabel.textColor = .white
            self.screenView?.subTitleLabel.textColor = .red
            self.screenView?.liveImage.tintColor = .red
        }
    }
}
