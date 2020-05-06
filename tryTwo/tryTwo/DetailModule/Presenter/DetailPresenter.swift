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
    private func loadData() {
        guard let id = id else {
            return
        }
        let link = LinkBuilder()
        let service = GetData()
        service.request(link: link.movie(id: id), complition: {(movie) in
            self.view?.configure(with: movie)
            self.view?.setupInitialState()
        }) { (stuck) in
            //TODO: - create stuck action
        }
        service.castRequest(link: link.cast("\(id)"), onComplete: { (cast) in
            self.view?.configure(with: cast)
            self.view?.setupInitialState()
        }) { (stuck) in
            //TODO: - create stuck
        }
        service.request(link: link.seeAlso("\(id)"), onComplete: { (also) in
            self.view?.configure(with: also)
            self.view?.setupInitialState()
        }) { (stuck) in
            //TODO: - create stuck
        }
    }
    
    
}

//MARK: - Extensions
extension DetailPresenter: DetailViewOutput {
    
    func present(with data: Int) {
        id = data
        router?.showModule(self)
    }
    
    func viewLoaded() {
        outputModule?.moduleEdited(complition: { (id) in
            self.id = id
        })
        loadData()
    }
    
    func reload() {
    }
    
}

extension DetailPresenter: ModuleOutput {
    func moduleEdited(complition: (Int) -> Void) {
        guard let id = id else {
                return
            }
            complition(id)
    }
    
}

