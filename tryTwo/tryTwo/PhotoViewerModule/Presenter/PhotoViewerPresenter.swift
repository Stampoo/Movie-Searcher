//
//  PhotoViewerPresenter.swift
//  tryTwo
//
//  Created by fivecoil on 27/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class PhotoViewerPresenter: PhotoViewerOutput {

    //MARK: - Public properties

    weak var view: PhotoViewerInput?
    var router: PhotoViewerRouterInput?
    var moduleOutput: ModuleOutput?


    //MARK: - Public methods

    func viewLoaded() {}

    func reloadView() {}

}


//MARK: - Extensions
