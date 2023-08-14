//
//  UISeparetedString+Extensions.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 14/08/23.
//

import Foundation
import UIKit

extension UILabel {
    func setFormattedText(_ text: String) {
        let separators = [" - ", "#", "|"]
        var separatedString = text
        
        for separator in separators {
            let components = separatedString.components(separatedBy: separator)
            if let firstComponent = components.first {
                separatedString = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        self.text = separatedString
    }
}
