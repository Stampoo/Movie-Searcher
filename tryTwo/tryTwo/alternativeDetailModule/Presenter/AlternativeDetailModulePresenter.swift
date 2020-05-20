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


    //MARK: - Public methods

    func viewLoaded() {
        outputModule?.moduleEdited(complitionHandler: { id in
            self.movieId = id
        })
        loadMovie()
    }

    func reloadView() {}

    func showModule() {}


    //MARK: - Private Properties

    private func loadMovie() {
        guard let id = movieId else {
            return
        }
        let service = GettingInformation()
        let link = LinkBuilder()
        service.requestMovie(link: link.pathMovie(id: id), completionHandler: { movie in
            self.view?.configure(with: movie)
        }) { error in
            //TODO: - Create error handler
        }
    }

}

