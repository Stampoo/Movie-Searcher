//
//  PhotoViewerConfigurator.swift
//  tryTwo
//
//  Created by fivecoil on 27/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class PhotoViewerModuleConfigurator {

    func configurateModule(moduleOutput: ModuleOutput) -> UIViewController {
        let view = PhotoViewerViewController()
        let presenter = PhotoViewerPresenter()
        let router = PhotoViewerRouter()

        view.output = presenter
        presenter.view = view
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        router.view = view

        return view
    }

}
