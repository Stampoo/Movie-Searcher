//
//  VoteStar.swift
//  tryTwo
//
//  Created by fivecoil on 25/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class StarView: UIView {

    //MARK: - Constants

    private enum Constants {
        static let emptyStarImage = UIImage(named: "emptyStar")
        static let votedStarImage = UIImage(named: "voteStar")
    }


    //MARK: - Public properties


    //MARK: - Private properties

    private var starCount = 0
    private var stars = [UIButton]()
    private let cardView = UIView()


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

    func configureStar() {
        stars.removeAll()
        for index in 0...starCount - 1 {
            let star = UIButton()
            star.setImage(Constants.emptyStarImage, for: .normal)
            star.addBloom(color: .yellow)
            star.addTarget(self, action: #selector(touchAtStar(target:)), for: .touchUpInside)
            stars.insert(star, at: index)
        }
    }


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

    private func configureCard() {
        cardView.layer.cornerRadius = cardView.frame.height / 2
        cardView.backgroundColor = .white
        cardView.createShadow()
        self.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardView.rightAnchor.constraint(equalTo: self.rightAnchor),
            cardView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }

    @objc private func touchAtStar(target: UIButton) {
        resetVote()
        guard let currentIndex = stars.firstIndex(of: target) else {
            return
        }
        for (index, star) in stars.enumerated() {
            if currentIndex >= index {
                star.setImage(Constants.votedStarImage, for: .normal)
                jumpStar(star: star)
            }
        }
    }

    private func resetVote() {
        stars.map { $0.setImage(Constants.emptyStarImage, for: .normal) }
    }

    private func updateView() {
        configureStack()
    }

    private func jumpStar(star: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            star.transform = CGAffineTransform(translationX: 0, y: -10)
        }, completion: {_ in
            star.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }

}

