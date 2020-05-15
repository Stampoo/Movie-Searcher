//
//  DetailPresenter.swift
//  tryTwo
//
//  Created by fivecoil on 01/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class DetailPresenter {

    //MARK: - Properties

    weak var view: DetailViewInput?
    var router: DetailRouterInput?
    var outputModule: ModuleOutput?


    //MARK: - Private Properties

    private var id: Int?


    //MARK: - Private methods

    private func loadInformation() {
        guard let id = id else {
            return
        }
        let link = LinkBuilder()
        let service = GettingInformation()
        service.requestMovie(link: link.pathMovie(id: id), completionHandler: { movie in
            self.view?.configure(with: movie)
            self.view?.setupInitialState()
        }) { error in
            //TODO: - Defination error case
        }
        service.requestCast(link: link.pathToCastMovie("\(id)"), completionHandler: { castMovie in
            self.view?.configure(with: castMovie)
            self.view?.setupInitialState()
        }) { stuck in
            //TODO: - Defination error case
        }
        service.requestMovieList(link: link.pathToSeeAlsoMovie(id: "\(id)", pageNumber: 1), completionHandler: { alsoMovie in
            self.view?.configure(with: alsoMovie)
            self.view?.setupInitialState()
        }) { stuck in
            //TODO: - Defination error case
        }
    }
    
}


//MARK: - Extensions

extension DetailPresenter: DetailViewOutput {
    
    func presentModule(with data: Int) {
        id = data
        router?.showModule(self)
    }
    
    func viewLoaded() {
        outputModule?.moduleEdited(complitionHandler: { (id) in
            self.id = id
        })
        loadInformation()
    }
    
    func reloadViewAfter(action: StorageActions, target: Movie) {
        let service = StorageService()
        switch action {
        case .del:
            service.deleteMovieFromStorage(target)
        case .save:
            service.saveMovieInStorage(target)
        }
    }

    func isMovieInStorage(_ movie: Movie) -> Bool {
        let service = StorageService()
        let movie = service.encodeMovieFromModel(movie)
        guard let currentListMoviesInStorage = service.listFromStorage as? [Data] else {
            return false
        }
        if currentListMoviesInStorage.contains(movie) {
            return true
        } else {
            return false
        }
    }
    
    func popModule(animation: Bool) {
        router?.popModule(animation: true)
    }
    
}

extension DetailPresenter: ModuleOutput {

    func moduleEdited(complitionHandler: (Int) -> Void) {
        guard let id = id else {
                return
            }
            complitionHandler(id)
    }
    
}


