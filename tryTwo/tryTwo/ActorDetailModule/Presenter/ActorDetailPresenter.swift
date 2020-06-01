//
//  ActorDetailPresenter.swift
//  tryTwo
//
//  Created by fivecoil on 22/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class ActorDetailPresenter: ActorDetailViewOutput {

    //MARK: - Public properties

    weak var view: ActorDetailViewInput?
    var router: ActorDetailRouterInput?
    weak var moduleOutput: ModuleOutput?

    //MARK: - Private properties

    private var actorID: Int?
    private let service = GettingInformation()
    private let link = LinkBuilder()


    //MARK: - Public methods

    func viewLoaded() {
        moduleOutput?.moduleEdited(complitionHandler: { id in
            self.actorID = id
        })
        guard let id = actorID else {
            return
        }
        loadActorDetail(by: id)
    }

    func reloadView() {}


    //MARK: - Private methods

    private func loadActorDetail(by id: Int) {
        print(link.pathToActor(id: "\(id)"))
        service.requestActor(link: link.pathToActor(id: "\(id)"), completionHandler: { actor in
            self.view?.configure(with: actor)
        }) { error in
            //TODO: - Defination error cases
        }
    }

    private func loadActorImages(by id: Int) {
        service.requestActorImages(link: link.pathToImagesActor(id: "\(id)"), completionHandler: { actorImages in
            //TODO: - create transfer method
        }) { error in
            //TODO: - Defination error cases
        }
    }

}


//MARK: - Extensions

extension ActorDetailPresenter: ModuleOutput {

    func moduleEdited(complitionHandler: (Int) -> Void) {
        guard let id = actorID else {
            return
        }
        complitionHandler(id)
    }

}
