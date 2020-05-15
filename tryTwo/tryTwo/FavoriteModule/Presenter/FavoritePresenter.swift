//
//  FavoritePresenter.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class FavoritePresenter: FavoriteViewOutput {
    
    //MARK: - Properties
    weak var view: FavoriteViewInput?
    var router: RouterInput?
    
    //MARK: - Private Properties
    private var id: Int?
    
    //MARK: - Methods
    func viewLoaded() {
        view?.setupInitialState()
    }
    
    func reload() {
        let service = StorageService()
        let actualList = service.decodeMovieFromData()
        view?.configure(actualList)
    }
    
    func present(with id: Int) {
        self.id = id
        router?.showModule(self)
    }
    
    
}

extension FavoritePresenter: ModuleOutput {
    
    func moduleEdited(complitionHandler: (Int) -> Void) {
        guard let id = id else {
            return
        }
        complitionHandler(id)
    }
    
    
}
