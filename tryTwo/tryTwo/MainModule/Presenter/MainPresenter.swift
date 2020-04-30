//
//  MainPresenter.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class MainPresenter: MainViewOutput {
    
    //MARK:- Properties
    var view: MainViewInput?
    var router: RouterInput?
    
    //MARK: - Private properties
    private let link = LinkBuilder()
    private let loading = GetData()
    private var keyWords = ""
    
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
            print(self.link.query(target: .movie, keyWords: key))
            print(movieList)
            self.view?.configure(with: movieList, use: .searchResultUpdate)
        }) { (stuck) in
            //TODO: - create error case
        }
    }
    
}
