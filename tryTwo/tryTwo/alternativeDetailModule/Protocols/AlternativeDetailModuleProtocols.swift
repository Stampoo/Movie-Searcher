//
//  AlternativeDetailModuleProtocols.swift
//  tryTwo
//
//  Created by fivecoil on 17/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol AlternativeDetailViewInput: class {

    func configure(with movie: Movie)

    func setupInitialState()

}

protocol AlternativeDetailViewOutput: class {

    func viewLoaded()

    func reloadView()

    func showModule()

}

protocol AlternativeDetailRouterInput: class {

    func showModule()

}
