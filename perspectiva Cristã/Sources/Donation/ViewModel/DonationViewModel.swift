//
//  DonationViewModel.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 11/07/23.
//

import Foundation
import UIKit


class DonationViewModel {
    
    var screen = DonationScreen()
    
    init(screen: DonationScreen) {
        self.screen = screen
    }
    
    func copyGesture() {
        screen.keyPixContainer.addTarget(self, action: #selector(viewTapped), for: .touchDown)
    }
    
    @objc func viewTapped() {
        clickedEfect()
        screen.copyPastePixAlert.isHidden = false
        if let textToCopy = screen.copyPastePix.text {
            UIPasteboard.general.string = textToCopy
            print("Texto copiado: \(textToCopy)")
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear], animations: {
                self.screen.copyPastePixAlert.frame = CGRect(
                    x: self.screen.copyPastePixAlert.frame.origin.x,
                    y: 65,
                    width: self.screen.copyPastePixAlert.frame.size.width,
                    height: self.screen.copyPastePixAlert.frame.size.height)
            }, completion: nil)
        }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.screen.copyPastePixAlert.frame = CGRect(
                    x: self.screen.copyPastePixAlert.frame.origin.x,
                    y: -50,
                    width: self.screen.copyPastePixAlert.frame.size.width,
                    height: self.screen.copyPastePixAlert.frame.size.height)
            }, completion: nil)
        }
        
    }
    
    func clickedEfect() {
        UIView.animate(withDuration: 0.1, animations: {
            self.screen.keyPixContainer.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            // Restaurar a escala original após a animação
            UIView.animate(withDuration: 0.1) {
                self.screen.keyPixContainer.transform = .identity
            }
        }
    }
}
