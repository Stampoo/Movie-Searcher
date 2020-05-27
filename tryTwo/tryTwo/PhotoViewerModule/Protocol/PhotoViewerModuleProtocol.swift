//
//  PhotoViewerModuleProtocol.swift
//  tryTwo
//
//  Created by fivecoil on 27/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol PhotoViewerInput: class {

    func configurate()

    func setupInitialState()

}

protocol PhotoViewerOutput: class {

    func viewLoaded()

    func reloadView()

}

protocol PhotoViewerRouterInput: class {

    func presentModule()

}
