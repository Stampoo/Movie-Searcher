//
//  VoteStar.swift
//  tryTwo
//
//  Created by fivecoil on 25/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class Star: UIView {

    //MARK: - Constants

    private enum Constants {
        static let emptyStarImage = UIImage(named: "emptyStar")
        static let votedStarImage = UIImage(named: "voteStar")
    }


    //MARK: - Public properties


    //MARK: - Private properties

    private var starCount = 0
    private var stars = [UIButton]()


    //MARK: - Initializers

    convenience init(frame: CGRect, starCount: Int) {
        self.init(frame: frame)
        self.starCount = starCount
    }


    //MARK: - Lifecycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }


    //MARK: - Public methods


    //MARK: - Private methods

    private func configureStack() {
        let stack = UIStackView(arrangedSubviews: stars)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor),
            stack.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }

    private func configureStar() {
        stars.removeAll()
        for index in 0...starCount - 1 {
            let star = UIButton()
            star.setImage(Constants.emptyStarImage, for: .normal)
            star.isUserInteractionEnabled = true
            star.addTarget(self, action: #selector(touchAtStar(target:)), for: .touchUpInside)
            star.isUserInteractionEnabled = true
            stars.insert(star, at: index)
        }
    }

    @objc private func touchAtStar(target: UIButton) {
        resetVote()
        let currentIndex = stars.filter { $0 == target }
        for i in stars {
            print(i == target)
        }
    }

    private func resetVote() {
        stars.map { $0.setImage(Constants.emptyStarImage, for: .normal) }
    }

    private func updateView() {
        configureStack()
        configureStar()
    }

}

