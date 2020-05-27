//
//  AlternativeDetailViewController.swift
//  tryTwo
//
//  Created by fivecoil on 17/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class AlternativeDetailViewController: UIViewController, ModuleTransitionable {

    //MARK: - Constants

    private enum Constants {
        static let castTitleText = "Cast:"
        static let alsoTitleText = "Also see:"
        static let posterRoundingAngle: CGFloat = 15
        static let titleLabelFontSize: CGFloat = 33
        static let castCollectionCellIdentifire = "castCollectionCell"
        static let castCollectionCellNibName = "CastCollectionViewCell"
        static let cellWidth: CGFloat = 140
        static let cellHeight: CGFloat = 210
        static let deepGreen = UIColor(displayP3Red: 17 / 255,
                                       green: 70 / 255,
                                       blue: 69 / 255,
                                       alpha: 1)
    }


    //MARK: - IBOutlets
    
    @IBOutlet private weak var blurredPosterImageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var shadowForPoster: UIView!
    @IBOutlet private weak var titleMovieLabel: UILabel!
    @IBOutlet private weak var aboutMovieLabel: UILabel!
    @IBOutlet private weak var castLabel: UILabel!
    @IBOutlet private weak var castCollectionView: UICollectionView!
    @IBOutlet private weak var alsoSeeLabel: UILabel!
    @IBOutlet private weak var alsoSeeCollectionView: UICollectionView!


    //MARK: - Public properties
    
    var output: AlternativeDetailViewOutput?


    //MARK : - Private properties

    private var castsInMovie = [Cast]()
    private var alsoMovies = [Result]()
    private var movieId = 0
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        configureBackGroundPoster()
        confiurePoster()
        configureFields()
        configureCastCollectionView()
        configurePhotoViewer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBar(animated)
    }


    //MARK: - Private methods

    private func configureBackGroundPoster() {
        blurredPosterImageView.addBlur()
    }

    private func confiurePoster() {
        shadowForPoster.addLightShadow()
        shadowForPoster.layer.masksToBounds = false
        shadowForPoster.layer.cornerRadius = Constants.posterRoundingAngle
        posterImageView.layer.cornerRadius = Constants.posterRoundingAngle
        posterImageView.clipsToBounds = true
    }

    private func configureFields() {
        aboutMovieLabel.numberOfLines = 0
        aboutMovieLabel.textColor = .white
        titleMovieLabel.numberOfLines = 0
        titleMovieLabel.font = .boldSystemFont(ofSize: Constants.titleLabelFontSize)
        titleMovieLabel.textColor = .white
    }

    private func configureCastCollectionView() {
        let collectionCellNib = UINib(nibName: Constants.castCollectionCellNibName, bundle: nil)
        castCollectionView.register(collectionCellNib,
                                    forCellWithReuseIdentifier: Constants.castCollectionCellIdentifire)
        alsoSeeCollectionView.register(collectionCellNib,
                                       forCellWithReuseIdentifier: Constants.castCollectionCellIdentifire)
        castCollectionView.dataSource = self
        alsoSeeCollectionView.dataSource = self
        castCollectionView.delegate = self
        alsoSeeCollectionView.delegate = self
        castCollectionView.backgroundColor = .clear
        alsoSeeCollectionView.backgroundColor = .clear
    }

    private func configurePhotoViewer() {
        let tapToRunViewer = UITapGestureRecognizer(target: self, action: #selector(runMoviePhotoViewer))
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(tapToRunViewer)
    }

    @objc private func runMoviePhotoViewer() {
        output?.showModule(with: movieId, type: .photo)
    }

}


//MARK: - Extensions

extension AlternativeDetailViewController: AlternativeDetailViewInput {
    
    func configure(with movie: Movie) {
        let link = LinkBuilder()
        blurredPosterImageView.loadImage(link.pathPoster(path: movie.posterPath, size: .original))
        posterImageView.loadImage(link.pathPoster(path: movie.posterPath, size: .original))
        titleMovieLabel.text = movie.title
        aboutMovieLabel.text = movie.overview
        castLabel.text = Constants.castTitleText
        alsoSeeLabel.text = Constants.castTitleText
    }

    func configure(with casts: [Cast]) {
        self.castsInMovie = casts
        castCollectionView.reloadData()
    }

    func setupInitialState() {}

    func configure(with movies: [Result]) {
        self.alsoMovies = movies
        alsoSeeCollectionView.reloadData()
    }
    
}

extension AlternativeDetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == alsoSeeCollectionView ? alsoMovies.count : castsInMovie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        func createCastCollectionViewCell() -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.castCollectionCellIdentifire,
                                                                for: indexPath) as? CastCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }
            let actor = castsInMovie[indexPath.row]
            cell.configureCell(with: actor)
            return cell
        }

        func createAlsoCollectionViewCell() -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.castCollectionCellIdentifire,
                                                                for: indexPath) as? CastCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }
            let movie = alsoMovies[indexPath.row]
            cell.configureCell(with: movie)
            return cell
        }

        return collectionView == alsoSeeCollectionView ? createAlsoCollectionViewCell() : createCastCollectionViewCell()
    }

}

extension AlternativeDetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        switch collectionView {
        case alsoSeeCollectionView:
            selectedCell(index: index, type: .movie)
        case castCollectionView:
            selectedCell(index: index, type: .actor)
        default:
            break
        }
    }

    private func selectedCell(index: Int, type: DetailType) {
        let selectedMovieId = type == .movie ? alsoMovies[index].id : castsInMovie[index].id
        output?.showModule(with: selectedMovieId, type: type)
    }

}

