//
//  CustomCollectionView.swift
//  tryTwo
//
//  Created by fivecoil on 09/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

class CustomSegmentView: UIView {

    //MARK: - Typealias

    typealias IdCloser = (Int) -> Void


    //MARK: Public properties

    weak var delegate: CustomSegmentViewDelegate?


    //MARK: - Private properties

    private var titles: [String]!
    private var titleColor: UIColor = .lightGray
    private var chooseTitleColor: UIColor = .black
    private lazy var buttons: [UIButton] = {
        var buttons = [UIButton]()
        for title in titles {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 17)
            button.addTarget(self, action: #selector(action(target:)), for: .touchUpInside)
            button.setTitleColor(self.titleColor, for: .normal)
            buttons.append(button)
        }
        return buttons
    }()
    private var handler: IdCloser?
    private var chooseView = UIView()
    private var chooseColor: UIColor = .red
    var defaultIndex: Int = 0 {
        willSet {
            setDefault(index: newValue)
        }
    }


    //MARK: - Initializers

    convenience init(frame: CGRect, buttonTitles: [String], handler: IdCloser?) {
        self.init(frame: frame)
        self.titles = buttonTitles
        self.handler = handler
    }


    //MARK: - lifeCycles

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }


    //MARK: - Public methods

    func setTitles(buttonTitles: [String]) {
        self.titles = buttonTitles
        updateView()
    }

    func setDefault(index: Int) {
        configurateChoosePosition(index: index)
        let choosePosition = frame.width / CGFloat(titles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.3, animations: {
            
        }) { (_) in
            self.chooseView.frame.origin.x = choosePosition
            self.buttons[index].setTitleColor(self.chooseTitleColor, for: .normal)
        }
    }


    //MARK: - Private Methods

    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
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

    private func configureSegmentView() {
        let segmentWidth = frame.width / CGFloat(self.titles.count * 2)
        chooseView.frame = .init(x: 0, y: self.frame.height, width: segmentWidth, height: 3)
        chooseView.frame.origin.x += chooseView.frame.width / 2
        chooseView.layer.cornerRadius = chooseView.frame.height / 2
        chooseView.backgroundColor = chooseColor
        addSubview(chooseView)
    }

    private func createButtons() {
        buttons = [UIButton]()
        buttons.removeAll()
        let _ = self.subviews.map {$0.removeFromSuperview()}
        for title in titles {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 17)
            button.addTarget(self, action: #selector(action(target:)), for: .touchUpInside)
            button.setTitleColor(self.titleColor, for: .normal)
            buttons.append(button)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.buttons[self.defaultIndex].titleLabel?.font = .boldSystemFont(ofSize: 21)
        })
        buttons[defaultIndex].setTitleColor(chooseTitleColor, for: .normal)
    }

    @objc private func action(target: UIButton) {
        for (index, button) in buttons.enumerated() {
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 17)
            if target == button {
                delegate?.changeByIndex(index: index)
                handler?(index)
                configurateChoosePosition(index: index)
            }
        }
    }

    private func configurateChoosePosition(index: Int) {
        let choosePosition = frame.width / CGFloat(titles.count * 2) * CGFloat(index) + chooseView.frame.width * (CGFloat(index) + 0.5)
        UIView.animate(withDuration: 0.2, animations: {
            self.chooseView.frame.origin.x = choosePosition
        }) {_ in
            self.buttons[index].setTitleColor(self.chooseTitleColor, for: .normal)
            self.buttons[index].titleLabel?.font = .boldSystemFont(ofSize: 21)
        }
    }

    private func updateView() {
        createButtons()
        configureSegmentView()
        configureStackView()
    }

}
