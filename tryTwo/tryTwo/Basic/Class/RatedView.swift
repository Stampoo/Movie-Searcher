//
//  RatedView.swift
//  tryTwo
//
//  Created by fivecoil on 25/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class RatedView: UIView {

    //MARK: - Constants

    private enum Constants {
        static let screenHeight = UIScreen.main.bounds.height
        static let screenWidth = UIScreen.main.bounds.width
        static let horizontalSpaceAtBounds = Constants.screenWidth * 0.31
        static let verticalSpaceAtBounds = Constants.screenHeight * 0.44565

    }


    //MARK: - Private properties

    private var starView: StarView!


    //MARK: - Initializers

    convenience init(frame: CGRect, starCount: Int) {
        self.init(frame: frame)
        self.starView = StarView(frame: CGRect(x: 100, y: 100, width: 300, height: 50), starCount: starCount)
        starView.configureStar()
    }


    //MARK: - Lifecycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }


    //MARK: - Private methods

    private func startViewConstraint() {
        self.addBlurAndVibrancy(on: starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(starView)
        NSLayoutConstraint.activate([
            starView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.verticalSpaceAtBounds),
            starView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.verticalSpaceAtBounds),
            starView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.horizontalSpaceAtBounds),
            starView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.horizontalSpaceAtBounds)
        ])
        print(starView.frame)
    }

    private func configureView() {
        self.backgroundColor = .clear
    }

    private func updateView() {
        startViewConstraint()
        configureView()
    }
}
