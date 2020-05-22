//
//  AlternativeDetailModulePresenter.swift
//  tryTwo
//
//  Created by fivecoil on 17/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class AlternativeDetailModulePresenter: AlternativeDetailViewOutput {

    //MARK: - Public properties

    weak var view: AlternativeDetailViewInput?
    var router: AlternativeDetailRouterInput?
    weak var outputModule: ModuleOutput?


    //MARK: - Private properties

    private var movieId: Int?
    private let service = GettingInformation()
    private let link = LinkBuilder()


    //MARK: - Public methods

    func viewLoaded() {
        outputModule?.moduleEdited(complitionHandler: { id in
            self.movieId = id
        })
        loadMovie()
        loadCastMovieBy(id: movieId)
        loadAlsoSeeMoviesBy(id: movieId)
    }

    func reloadView() {}

    func showModule(with id: Int, type: DetailType) {
        movieId = id
        switch type {
        case .movie:
            router?.pushModule(with: self)
        case .actor:
            router?.pushActorModule(with: self)
        }
    }


    //MARK: - Private Properties

    private func loadMovie() {
        guard let id = movieId else {
            return
        }
        service.requestMovie(link: link.pathMovie(id: id), completionHandler: { movie in
            self.view?.configure(with: movie)
        }) { error in
            //TODO: - Create error handler
        }
    }

    private func loadCastMovieBy(id: Int?) {
        guard let id = movieId else {
            return
        }
        service.requestCast(link: link.pathToCastMovie("\(id)"), completionHandler: { cast in
            self.view?.configure(with: cast)
        }) { error in
            //TODO: - Create error handler
        }
    }

    private func loadAlsoSeeMoviesBy(id: Int?) {
        guard let id = movieId else {
            return
        }
        service.requestMovieList(link: link.pathToSeeAlsoMovie(id: "\(id)", pageNumber: 1), completionHandler: { movies in
            self.view?.configure(with: movies)
        }) { error in
            //TODO: - Create error handler
        }
    }

}


//MARK: - Extensions

extension AlternativeDetailModulePresenter: ModuleOutput {

    func moduleEdited(complitionHandler: (Int) -> Void) {
        guard let id = movieId else {
            return
        }
        complitionHandler(id)
    }

}

