//
//  MainPresenter.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class MainModulePresenter: MainViewOutput {

    //MARK: - Typealias

    typealias EmptyCloser = () -> Void


    //MARK: - Constants

    enum Constants {
        static let searchDelay = 1.0
    }

    
    //MARK:- Public properties

    weak var view: MainViewInput?
    var router: MainRouterInput?


    //MARK: - Private properties

    private let link = LinkBuilder()
    private let Service = GettingInformation()
    private var keyWords = ""
    private var id: Int?

    
    //MARK: - lifeCycle

    func viewLoaded() {
        loadInformationFrom(source: .popularMovies)
        loadInformationFrom(source: .nowPlayingMovies)
        loadInformationFrom(source: .topRatedMovies)
    }


    //MARK: - Public methods

    func reloadView() {
        delay(delayInSeconds: Constants.searchDelay) {
            self.loadSearchResultBy(self.keyWords)
        }
    }
    
    func send(key word: String) {
        keyWords = word
    }
    
    func present(with data: Int) {
        id = data
        router?.showModule(self)
    }

    func popModule(animation: Bool) {
        router?.popModule(animation: animation)
    }


    //MARK: - Private methods

    private func loadInformationFrom(source: Category) {
        Service.requestMovieList(link: link.pathMovies(pageNumber: 1, type: source), completionHandler: { movieList in
            self.view?.configure(with: movieList, use: source)
            if source == .popularMovies {
                self.view?.setupInitialState(movieList)
            }
        }) { stuck in
            //TODO: - Defination error case
        }
    }

    private func loadSearchResultBy(_ key: String) {
        Service.requestSearch(link: link.pathToSearchResults(category: .movie, keyWords: key), complitionHandler: { movieList in
            self.view?.configure(with: movieList, use: .searchResultsMovies)
        }) { stuck in
            //TODO: - Defination error case
        }
    }

    private func delay(delayInSeconds: Double, completionHandler: @escaping EmptyCloser) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds, execute: completionHandler)
    }
    
}


//MARK: - Extensions

extension MainModulePresenter: ModuleOutput {
    
    func moduleEdited(complitionHandler: (Int) -> Void) {
        guard let id = id else {
            return
        }
        complitionHandler(id)
    }
    
}
