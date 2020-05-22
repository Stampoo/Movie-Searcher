//
//  ActorDetailModuleProtocols.swift
//  tryTwo
//
//  Created by fivecoil on 22/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol ActorDetailViewInput: class {

    func configure(with actor: Actor)

    func setupInitialState()

}

protocol ActorDetailViewOutput: class {

    func viewLoaded()

    func reloadView()

}

protocol ActorDetailRouterInput: class {

    func pushModule(with moduleOutput: ModuleOutput)

}

