//
//  DetailViewController.swift
//  tryTwo
//
//  Created by fivecoil on 01/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Constants

    private enum Constants {
        static let posterCellPositionInTable = 0
        static let posterCellIdentifire: String = "detailCell"
        static let posterCellNib: String = "PosterTableViewCell"

        static let titleCellPositionInTable = 1
        static let titleCellIdentifire: String = "titleCell"
        static let titleCellNib: String = "TitleTableViewCell"

        static let castTitleCellPositionInTable = 2
        static let castTitleIdentifire: String = "castTitleCell"

        static let castCellPositionInTable = 3
        static let castCellIdentifire: String = "castCell"
        static let castCellNib: String = "CastTableViewCell"

        static let alsoTitleCellPositionInTable = 4
        static let alsoTitleIdentifire: String = "alsoTitleCell"

        static let alsoCellPositionInTable = 5
        static let alsoIdentifire: String = "alsoCell"
        static let alsoCellNib: String = "AlsoSeeTableViewCell"

        static let numberOfCellsInTable: Int = 6
        static let rowHeightCastCell: CGFloat = 200.0
        static let screenSize = UIScreen.main.bounds
        static let estimateHeight: CGFloat = 50
        static let titleCellsFontSize: CGFloat = 27
    }


    //MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!


    //MARK: - Properties

    var output: DetailViewOutput?
    let activityView = CustomActivityIndicator(frame: Constants.screenSize, complitionHandler: nil)


    //MARK: - Private Properties

    private var movie: Movie?
    private var movieCasts: [Cast]?
    private var alsoList: [Result]?

    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        output?.viewLoaded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        hideNavigationBar(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        showNavigationBar(animated)
    }


    //MARK: - Private methods

    private func configureTableView() {
        let nib = UINib(nibName: Constants.posterCellNib, bundle: nil)
        let nibTitle = UINib(nibName: Constants.titleCellNib, bundle: nil)
        let nibCast = UINib(nibName: Constants.castCellNib, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.posterCellIdentifire)
        tableView.register(nibTitle, forCellReuseIdentifier: Constants.titleCellIdentifire)
        tableView.register(nibCast, forCellReuseIdentifier: Constants.castCellIdentifire)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.castTitleIdentifire)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.alsoTitleIdentifire)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = Constants.estimateHeight
    }
    
}


//MARK: - Extensions

extension DetailViewController: DetailViewInput {
    
    func setupInitialState() {
        tableView.reloadData()
    }

    //TODO: - refactor this method
    func configure(with information: Any) {
        switch information {
        case is Movie:
            self.movie = information as? Movie
        case is [Cast]:
            self.movieCasts = information as? [Cast]
        case is [Result]:
            self.alsoList = information as? [Result]
        default:
            break
        }
    }
    
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfCellsInTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movie else {
            return UITableViewCell()
        }
        func createCellWith(identifire: String) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
            return cell
        }
        switch indexPath.row {
        case Constants.posterCellPositionInTable:
            guard let cell = createCellWith(identifire: Constants.posterCellIdentifire) as? PosterTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(with: movie)
            cell.saveToStorage = { [weak self] movie in
                self?.output?.reloadViewAfter(action: .save, target: movie)
            }
            cell.deleteFromStorage = { [weak self] movie in
                self?.output?.reloadViewAfter(action: .del, target: movie)
            }
            if let booleanValue = output?.isMovieInStorage(movie) {
                cell.initialButtonState(when: booleanValue)
            }
            return cell
        case Constants.titleCellPositionInTable:
            guard let cell = createCellWith(identifire: Constants.titleCellIdentifire) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(with: movie)
            return cell
        case Constants.castTitleCellPositionInTable:
            let cell = createCellWith(identifire: Constants.castTitleIdentifire)
            cell.textLabel?.font = .boldSystemFont(ofSize: Constants.titleCellsFontSize)
            cell.textLabel?.text = "Cast"
            return cell
        case Constants.castCellPositionInTable:
            guard let cell = createCellWith(identifire: Constants.castCellIdentifire) as? CastTableViewCell else {
                return UITableViewCell()
            }
            cell.configureDisplayedCasts(movieCasts)
            return cell
        case Constants.alsoTitleCellPositionInTable:
            let cell = createCellWith(identifire: Constants.alsoTitleIdentifire)
            cell.textLabel?.font = .boldSystemFont(ofSize: Constants.titleCellsFontSize)
            cell.textLabel?.text = "Also see"
            return cell
        case Constants.alsoCellPositionInTable:
            guard let cell = createCellWith(identifire: Constants.castCellIdentifire) as? CastTableViewCell else {
                return UITableViewCell()
            }
            cell.configureDisplayedCasts(alsoList)
            cell.pushDetailView = { [weak self] id in
                self?.output?.presentModule(with: id)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 || indexPath.row == 5 {
            return Constants.rowHeightCastCell
        }
        return UITableView.automaticDimension
    }
    
}
