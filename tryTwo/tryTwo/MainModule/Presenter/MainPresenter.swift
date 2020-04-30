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
    
    //MARK: - lifeCycle
    func viewLoaded() {
        loadData()
    }
    
    func reload() { }
    
    //load data from network
    func loadData() {
        let loading = GetData()
        loading.request(link: link.popular(page: 1), onComplete: { [weak self] (movieList) in
            guard let self = self else {
                return
            }
            self.view?.configure(with: movieList)
            print(movieList)
        }) { stuck in
            //TODO - create error case
        }
    }
    
}
