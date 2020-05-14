//
//  MainPresenter.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class MainPresenter: MainViewOutput {

    //MARK: - Typealias

    typealias EmptyCloser = () -> Void


    //MARK: - Constants

    enum Constants {
        static let searchDelay = 1.0
    }

    
    //MARK:- Properties

    var view: MainViewInput?
    var router: RouterInput?


    //MARK: - Private properties

    private let link = LinkBuilder()
    private let loading = GetData()
    private var keyWords = ""
    private var id: Int?

    
    //MARK: - lifeCycle

    func viewLoaded() {
        loadDataFromNetwork(source: .popularResultUpdate)
        loadDataFromNetwork(source: .nowPlayingResultUpdate)
        loadDataFromNetwork(source: .topRatedResultUpdate)
    }


    //MARK: - Methods

    func reload() {
        delay(delay: Constants.searchDelay) {
            self.loadSearchResult(self.keyWords)
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
        router?.popModule(animation: true)
    }


    //MARK: - Private methods
    //load data depends at source
    private func loadDataFromNetwork(source: Use) {
        loading.request(link: link.feed(page: 1, type: source), onComplete: { [weak self] (movieList) in
            guard let self = self else {
                return
            }
            self.view?.configure(with: movieList, use: source)
            if source == .popularResultUpdate {
                self.view?.setupInitialState(movieList)
            }
        }) { stuck in
        }
    }
    
    //Load search result
    private func loadSearchResult(_ key: String) {
        loading.searchRequest(link: link.query(target: .movie, keyWords: key), onComplete: { [weak self] (movieList) in
            guard let self = self else {
                return
            }
            self.view?.configure(with: movieList, use: .searchResultUpdate)
        }) { (stuck) in
        }
    }

    private func delay(delay: Double, completionHandler: @escaping EmptyCloser) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: completionHandler)
    }
    
}

extension MainPresenter: ModuleOutput {
    
    func moduleEdited(complition: (_ data: Int) -> Void) {
        guard let id = id else {
            return
        }
        complition(id)
    }
    
}
