//
//  DetailRouter.swift
//  tryTwo
//
//  Created by fivecoil on 01/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class DetailRouter {
    
    //MARK: - Properties
    var view: ModuleTransitionable?
    
    //MARK: - Private Properties
    
}

//MARK: - Extensions
extension DetailRouter: DetailRouterInput {
    
    func showModule() {
        print("show module")
    }

}
