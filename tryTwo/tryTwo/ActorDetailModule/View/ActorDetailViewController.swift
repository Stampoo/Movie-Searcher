//
//  ActorDetailViewController.swift
//  tryTwo
//
//  Created by fivecoil on 22/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class ActorDetailViewController: UIViewController, ModuleTransitionable {

    //MARK: - IBOutlets

    @IBOutlet var actorName: UILabel!
    @IBOutlet var actorRole: UILabel!
    @IBOutlet var actorBiography: UILabel!
    @IBOutlet var actorBirthdate: UILabel!
    @IBOutlet var knowForTitle: UILabel!
    @IBOutlet var knowForCollectionView: UICollectionView!
    @IBOutlet var actorPhoto: UIImageView!


    //MARK: - Public properties

    var output: ActorDetailViewOutput?


    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}


//MARK: - Extensions

extension ActorDetailViewController: ActorDetailViewInput {

    func configure(with actor: Actor) {
        let link = LinkBuilder()
        actorName.text = actor.name
        actorRole.text = "ROLE"
        actorBiography.text = actor.biography
        actorBirthdate.text = actor.birthday
        actorPhoto.loadImage(link.pathPoster(path: actor.profilePath, size: .w500))
    }

    func setupInitialState() {}

}
