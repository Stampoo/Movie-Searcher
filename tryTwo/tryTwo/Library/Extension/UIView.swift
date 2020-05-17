//
//  ViewController.swift
//  filmInfo
//
//  Created by fivecoil on 22/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

//this extension not done
extension UIViewController {
    func loading(_ loading:() -> Bool) {
        
    }
    func createShadow() {
    }
}


//MARK: - for crate shadow to UIView and inheritors

extension UIView {

    func createShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .init(width: 0.5, height: 4.0)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }

    func createBloom(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.9
        self.layer.shadowOffset = .zero
    }

}

extension UIView {

    func addBlurAndVibrancy(on view: UIView) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredView = UIVisualEffectView(effect: blurEffect)
        blurredView.frame = self.bounds
        self.addSubview(blurredView)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.frame = blurredView.bounds
        vibrancyView.contentView.addSubview(view)
        blurredView.contentView.addSubview(vibrancyView)
    }

    func addBlur() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredView = UIVisualEffectView(effect: blurEffect)
        blurredView.alpha = 0.98
        blurredView.frame = self.bounds
        self.addSubview(blurredView)
    }

}

