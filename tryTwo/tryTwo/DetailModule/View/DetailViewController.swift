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
        static let castCellNib: String = "CastTableViewCell"
        static let alsoIdentifire: String = "alsoCell"
        static let alsoCellNib: String = "AlsoSeeTableViewCell"
        static let constructDetailList: Int = 6
        static let rowHeightAlsoAndCast: CGFloat = 200.0
    }
    
    //MARK: - Properties
    var presenter: DetailViewOutput?
    
    //MARK: - Private Properties
    @IBOutlet private weak var tableView: UITableView!
    private var movie: Movie?
    var cast: [Cast]?
    private var also: [Result]?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewLoaded()
    }
    
    //MARK: - Internal methods
    func presentModule(with id: Int) {
        presenter?.present(with: id)
        print("lol")
    }
    
    //MARK: - Private methods
    //configure cell from nib
    private func configureTableView() {
        let nib = UINib(nibName: Constants.posterCellNib, bundle: nil)
        let nibTitle = UINib(nibName: Constants.titleCellNib, bundle: nil)
        let nibCast = UINib(nibName: Constants.castCellNib, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.posterIdentifire)
        tableView.register(nibTitle, forCellReuseIdentifier: Constants.titleIdentifire)
        tableView.register(nibCast, forCellReuseIdentifier: Constants.castIdentifire)
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
            //TODO: - create default case
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
            cell.configurePoster(movie)
            return cell
        case 1:
            guard let cell = castCell(identifire: Constants.titleIdentifire) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(film: movie)
            return cell
        case 2:
            let cell = castCell(identifire: Constants.castIdentifire)
            cell.textLabel?.font = .boldSystemFont(ofSize: 27)
            cell.textLabel?.text = "Cast"
            return cell
        case 3:
            guard let cell = castCell(identifire: Constants.castIdentifire) as? CastTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(cast)
            cell.transferSelf(self)
            return cell
        case 4:
            let cell = castCell(identifire: Constants.castIdentifire)
            cell.textLabel?.font = .boldSystemFont(ofSize: 27)
            cell.textLabel?.text = "Also see"
            return cell
        case 5:
            guard let cell = castCell(identifire: Constants.castIdentifire) as? CastTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(also)
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
