//
//  PhotoViewerRouter.swift
//  tryTwo
//
//  Created by fivecoil on 27/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class PhotoViewerRouter {

    //MARK: - Public properties

    var view: ModuleTransitionable?

}


//MARK: - Extensions

extension PhotoViewerRouter: PhotoViewerRouterInput {

    func presentModule() {}
    
}
