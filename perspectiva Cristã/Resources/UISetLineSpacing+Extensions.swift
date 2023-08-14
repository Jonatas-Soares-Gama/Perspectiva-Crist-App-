//
//  UILabel+Extensions.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 04/08/23.
//

import Foundation
import UIKit


extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat) {
        guard let labelText = text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))

        attributedText = attributedString
    }
}
