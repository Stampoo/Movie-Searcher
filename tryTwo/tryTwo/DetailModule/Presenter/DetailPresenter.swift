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
    var previousModule: ModuleOutput?
    
    //MARK: - Private Properties
    private var id: Int?
    
    //MARK: - Private methods
    private func loadData() {
        guard let id = id else {
            return
        }
        let link = LinkBuilder()
        let service = GetData()
        service.request(link: link.movie(id: id), complition: { [weak self] (movie) in
            guard let self = self else {
                return
            }
            self.view?.configure(with: movie)
        }) { (stuck) in
            //TODO: - create stuck action
        }
    }
    
    
}

//MARK: - Extensions
extension DetailPresenter: DetailViewOutput {
    
    func viewLoaded() {
        previousModule?.moduleEdited(complition: { (id) in
            print(id)
            self.id = id
        })
        loadData()
    }
    
    func reload() {
        print("reload view")
    }
    
}

