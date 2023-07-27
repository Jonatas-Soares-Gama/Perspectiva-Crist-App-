//
//  blurEffectComponent.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 26/07/23.
//

import Foundation

import UIKit

class BlurredImageViewComponent: UIVisualEffectView {
    private let imageView = UIImageView()
    private let blurEffect: UIBlurEffect
    private let containerView = UIView()

    init(frame: CGRect, blurStyle: UIBlurEffect.Style) {
        blurEffect = UIBlurEffect(style: blurStyle)
        super.init(effect: nil)

        setupSubviews(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews(frame: CGRect) {
        // Configure the image view
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = frame

        // Add the image view and blurred effect view to the container view
        containerView.addSubview(imageView)
        containerView.addSubview(self)

        // Set container view's frame to the same as the component's frame
        containerView.frame = frame

        // Apply blur effect to the component
        self.effect = blurEffect

        // Add the container view as the subview
        self.contentView.addSubview(containerView)
    }

    func setImage(withURL url: URL) {
        imageView.sd_setImage(with: url)
    }
}
