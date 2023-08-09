import AVFoundation
import UIKit
import SDWebImage
import MediaPlayer

class RadioViewModel {
    
    private var audioPlayer: AVPlayer?
    private var audioSession = AVAudioSession.sharedInstance()
    private let screen: RadioScreen?
    private var service = Service()
    private var timer: Timer?
    private var isPaused: Bool = false
    
    init(screen: RadioScreen?) {
        self.screen = screen
    }
    
    func populateViewModel() {
        setupButtonActions()
    }
    
    private func setupButtonActions() {
        screen?.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        screen?.pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
    }
    
    @objc private func playButtonTapped() {
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
            if remainingTime > 0 && self.isPaused {
                remainingTime -= 1
                print("Tempo restante: \(remainingTime)")
            } else {
                self.timer?.invalidate()  // Interrompe o timer atual
                if self.isPaused {
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
            if remainingTime > 0 && self.isPaused {
                remainingTime -= 1
                print("Tempo restante (próxima reprodução): \(remainingTime)")
            } else if remainingTime == 0 || self.isPaused {
                self.timer?.invalidate()  // Interrompe o timer atual
                if self.isPaused {
                    self.service.requestApi { station in
                        self.updateViewAfterPlay(data: station)
                        self.airplayradio(data: station)
                        self.startNextTimer(tempoEstipulado: TimeInterval(station.nowPlaying?.duration ?? 0) + 6)
                    }
                }
            }
        }
    }
    
    @objc private func pauseButtonTapped() {
        self.isPaused = true
        self.timer?.invalidate()
            pauseMusic()
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
            self.pauseMusic()
    }
    
    private func playMusic(data: List) {
        self.updateViewAfterPlay(data: data)
        self.setupAudioPlayer(data: data)
    }
    
    func setupAudioPlayer(data: List) {
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
        guard let imgURL = URL(string: data.nowPlaying?.song?.art ?? "") else { return }
        self.screen?.radioImage.sd_setImage(with: imgURL) { (image, _, _, _) in
            image?.getColors { colors in
                if let colors = colors {
                    self.modifyViewsAfterPlay(data: data, colors: colors)
                }
            }
        }
    }
    
    func modifyViewsAfterPlay(data: List, colors: UIImageColors) {
        self.screen?.playButton.isHidden = true
        self.screen?.pauseButton.isHidden = false
        self.screen?.artistPlayLabel.isHidden = false
        self.screen?.titlePlayLabel.isHidden = false
        self.screen?.titlePlayLabel.text = data.nowPlaying?.song?.title
        self.screen?.artistPlayLabel.text = data.nowPlaying?.song?.artist
        self.screen?.backgroundView.backgroundColor = colors.background
        self.screen?.radioImage.layer.shadowColor = colors.detail.cgColor
        self.screen?.titlePlayLabel.textColor = colors.primary
        self.screen?.artistPlayLabel.textColor = colors.detail
        self.screen?.titleLabel.textColor = colors.detail
        self.screen?.subTitleLabel.textColor = colors.primary
        self.screen?.liveImage.tintColor = colors.detail
        self.screen?.pauseButton.tintColor = colors.detail
    }
    
    private func pauseMusic() {
        DispatchQueue.main.async {
            self.audioPlayer?.pause()
            self.modifyViewsAfterPause()
        }
    }
    
    func modifyViewsAfterPause() {
        self.screen?.pauseButton.isHidden = true
        self.screen?.playButton.isHidden = false
        self.screen?.radioImage.image = UIImage(named: "radioAzul2")
        self.screen?.artistPlayLabel.isHidden = true
        self.screen?.titlePlayLabel.isHidden = true
        self.screen?.backgroundView.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        self.screen?.titleLabel.textColor = .white
        self.screen?.subTitleLabel.textColor = .red
        self.screen?.liveImage.tintColor = .red
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
}
