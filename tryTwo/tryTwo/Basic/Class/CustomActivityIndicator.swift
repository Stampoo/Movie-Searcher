//
//  CustomActivityIndicator.swift
//  tryTwo
//
//  Created by fivecoil on 11/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CustomActivityIndicator: UIView {

    //MARK: Private properties

    private var indicator = UIActivityIndicatorView(style: .whiteLarge)


    //MARK: - Initializers

    convenience init(frame: CGRect, complitionHandler: (() -> Void)?) {
        self.init(frame: frame)
        self.configureIndicator()
    }


    //MARK: - Public methods
    
    func startActivity(view: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            view.addSubview(self)
            self.indicator.startAnimating()
        })
    }

    func stopActiviy() {
        UIView.animate(withDuration: 0.1, animations: {
            self.removeFromSuperview()
        })
    }


    //MARK: - Private methods

    private func configureIndicator() {
        self.addBlurAndVibrancy(on: indicator)
        indicator.center = self.center
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        indicator.color = .black
    }
    
}
