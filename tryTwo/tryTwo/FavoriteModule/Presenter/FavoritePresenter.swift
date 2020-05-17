//
//  FavoritePresenter.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class FavoritePresenter: FavoriteViewOutput {
    
    //MARK: - Public properties

    weak var view: FavoriteViewInput?
    var router: FavoriteRouterInput?

    
    //MARK: - Private Properties

    private var id: Int?


    //MARK: - Public methods

    func viewLoaded() {
        view?.setupInitialState()
    }
    
    func reloadView() {
        let service = StorageService()
        let moviesInStorage = service.decodeMovieFromData()
        view?.configure(with: moviesInStorage)
    }
    
    func present(with id: Int) {
        self.id = id
        router?.showModule(self)
    }
    
    
}


//MARK: - Extensions

extension FavoritePresenter: ModuleOutput {
    
    func moduleEdited(complitionHandler: (Int) -> Void) {
        guard let id = id else {
            return
        }
        complitionHandler(id)
    }

}
