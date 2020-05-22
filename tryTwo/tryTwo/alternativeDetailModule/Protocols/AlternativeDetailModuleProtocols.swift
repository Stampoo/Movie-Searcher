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

    func configure(with cast: [Cast])

    func configure(with movies: [Result])

    func setupInitialState()

}

protocol AlternativeDetailViewOutput: class {

    func viewLoaded()

    func reloadView()

    func showModule(with id: Int, type: DetailType)

}

protocol AlternativeDetailRouterInput: class {

    func pushModule(with moduleOutput: ModuleOutput)

    func pushActorModule(with moduleOutput: ModuleOutput)

}
