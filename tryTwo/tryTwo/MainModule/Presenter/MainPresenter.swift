//
//  MainPresenter.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class MainPresenter: MainViewOutput {
    
    //MARK:- PropertiesT
    var view: MainViewInput?
    var router: RouterInput?
    
    //MARK: - Private properties
    private let link = LinkBuilder()
    private let loading = GetData()
    private var keyWords = ""
    private var id: Int?
    
    //MARK: - lifeCycle
    func viewLoaded() {
        loadPopularData()
    }
    
    func reload() {
        loadSearchResult(keyWords)
    }
    
    func send(key word: String) {
        keyWords = word
    }
    
    func present(with data: Int) {
        id = data
        print(id)
        router?.showModule(self)
    }
    
    //load data from network
    func loadPopularData() {
        loading.request(link: link.popular(page: 1), onComplete: { [weak self] (movieList) in
            guard let self = self else {
                return
            }
            self.view?.configure(with: movieList, use: .popularResultUpdate)
        }) { stuck in
            //TODO - create error case
        }
    }
    
    //Load search result
    func loadSearchResult(_ key: String) {
        loading.searchRequest(link: link.query(target: .movie, keyWords: key), onComplete: { [weak self] (movieList) in
            guard let self = self else {
                return
            }
            self.view?.configure(with: movieList, use: .searchResultUpdate)
        }) { (stuck) in
            //TODO: - create error case
        }
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
