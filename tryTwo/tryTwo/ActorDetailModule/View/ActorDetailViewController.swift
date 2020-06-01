//
//  ActorDetailViewController.swift
//  tryTwo
//
//  Created by fivecoil on 22/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class ActorDetailViewController: UIViewController, ModuleTransitionable {

    //MARK: - Constants

    private enum Constants {
        static let nameLabelFontSize: CGFloat = 31
        static let photoLabelFontSize: CGFloat = 17
        static let photoLabelText = "Photo with "
    }


    //MARK: - IBOutlets

    @IBOutlet var actorName: UILabel!
    @IBOutlet var actorBiography: UILabel!
    @IBOutlet var knowForTitle: UILabel!
    @IBOutlet var knowForCollectionView: UICollectionView!
    @IBOutlet var actorPhoto: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var seeFilmographyButton: UIButton!


    //MARK: - Public properties

    var output: ActorDetailViewOutput?


    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        configureUI()
    }


    //MARK: - Private methods

    private func configureUI() {
        actorName.font = .boldSystemFont(ofSize: Constants.nameLabelFontSize)
        photoLabel.font = .boldSystemFont(ofSize: Constants.photoLabelFontSize)
        actorBiography.numberOfLines = 0
    }

}


//MARK: - Extensions

extension ActorDetailViewController: ActorDetailViewInput {

    func configure(with actor: Actor) {
        let link = LinkBuilder()
        actorName.text = actor.name
        actorBiography.text = actor.biography
        actorPhoto.loadImage(link.pathPoster(path: actor.profilePath, size: .w500))
        photoLabel.text = Constants.photoLabelText + actor.name + ":"
    }

    func setupInitialState() {
    }
}

extension ActorDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    
}
