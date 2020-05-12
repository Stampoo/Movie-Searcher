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
        static let posterIdentifire: String = "detailCell"
        static let posterCellNib: String = "PosterTableViewCell"
        static let titleIdentifire: String = "titleCell"
        static let titleCellNib: String = "TitleTableViewCell"
        static let castIdentifire: String = "castCell"
        static let castTitleIdentifire: String = "castTitleCell"
        static let castCellNib: String = "CastTableViewCell"
        static let alsoIdentifire: String = "alsoCell"
        static let alsoTitleIdentifire: String = "alsoTitleCell"
        static let alsoCellNib: String = "AlsoSeeTableViewCell"
        static let constructDetailList: Int = 6
        static let rowHeightAlsoAndCast: CGFloat = 200.0
    }
    
    //MARK: - Properties
    var presenter: DetailViewOutput?
    let activityView = CustomActivityIndicator(frame: UIScreen.main.bounds, complitionHandler: nil)
    
    //MARK: - Private Properties
    @IBOutlet private weak var tableView: UITableView!
    private var movie: Movie?
    private var cast: [Cast]?
    private var also: [Result]?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewLoaded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        hideNavigationBar(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        showNavigationBar(animated)
    }
    
    //MARK: - Internal methods
    
    //MARK: - Private methods
    //configure cell from nib
    private func configureTableView() {
        let nib = UINib(nibName: Constants.posterCellNib, bundle: nil)
        let nibTitle = UINib(nibName: Constants.titleCellNib, bundle: nil)
        let nibCast = UINib(nibName: Constants.castCellNib, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.posterIdentifire)
        tableView.register(nibTitle, forCellReuseIdentifier: Constants.titleIdentifire)
        tableView.register(nibCast, forCellReuseIdentifier: Constants.castIdentifire)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.castTitleIdentifire)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.alsoTitleIdentifire)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
    }
    
}

//MARK: - Extensions
extension DetailViewController: DetailViewInput {
    
    func setupInitialState() {
        tableView.reloadData()
    }
    
    func configure(with target: Any) {
        switch target {
        case is Movie:
            self.movie = target as? Movie
        case is [Cast]:
            self.cast = target as? [Cast]
        case is [Result]:
            self.also = target as? [Result]
        default:
            break
        }
    }
    
}

//dataSource
extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.constructDetailList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movie else {
            return UITableViewCell()
        }
        func castCell(identifire: String) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
            return cell
        }
        switch indexPath.row {
        case 0:
            guard let cell = castCell(identifire: Constants.posterIdentifire) as? PosterTableViewCell else {
                return UITableViewCell()
            }
            cell.transition = {
                self.presenter?.popModule(animation: true)
            }
            cell.configurePoster(movie)
            cell.saveToStorage = { [weak self] movie in
                self?.presenter?.reload(action: .save, target: movie)
            }
            cell.deleteFromStorage = { [weak self] movie in
                self?.presenter?.reload(action: .del, target: movie)
            }
            if let booleanValue = presenter?.checkState(when: movie) {
                cell.buttonInitial(when: booleanValue)
            }
            return cell
        case 1:
            guard let cell = castCell(identifire: Constants.titleIdentifire) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(film: movie)
            return cell
        case 2:
            let cell = castCell(identifire: Constants.castTitleIdentifire)
            cell.textLabel?.font = .boldSystemFont(ofSize: 27)
            cell.textLabel?.text = "Cast"
            return cell
        case 3:
            guard let cell = castCell(identifire: Constants.castIdentifire) as? CastTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(cast)
            return cell
        case 4:
            let cell = castCell(identifire: Constants.alsoTitleIdentifire)
            cell.textLabel?.font = .boldSystemFont(ofSize: 27)
            cell.textLabel?.text = "Also see"
            return cell
        case 5:
            guard let cell = castCell(identifire: Constants.castIdentifire) as? CastTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(also)
            cell.pushDetail = { [weak self] id in
                self?.presenter?.present(with: id)
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
            return Constants.rowHeightAlsoAndCast
        }
        return UITableView.automaticDimension
    }
    
}
