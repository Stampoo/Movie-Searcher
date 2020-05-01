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
           static let titleIdentifire: String = "titleCell"
           static let posterCellNib: String = "PosterTableViewCell"
           static let titleCellNib: String = "TitleTableViewCell"
           static let constructDetailList: Int = 2
       }
    
    //MARK: - Properties
    var presenter: DetailViewOutput?
    
    //MARK: - Private Properties
    @IBOutlet private weak var tableView: UITableView!
    private var movie: Movie?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewLoaded()
    }
    
    //MARK: - Private methods
    //configure cell from nib
    private func configureTableView() {
        let nib = UINib(nibName: Constants.posterCellNib, bundle: nil)
        let nibTitle = UINib(nibName: Constants.titleCellNib, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.posterIdentifire)
        tableView.register(nibTitle, forCellReuseIdentifier: Constants.titleIdentifire)
        tableView.dataSource = self
    }
    
}

//MARK: - Extensions
extension DetailViewController: DetailViewInput {
    func setupInitialState() {
        print("setup")
    }
    
    func configure(with target: Movie) {
        self.movie = target
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
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.posterIdentifire, for: indexPath) as? PosterTableViewCell else {
                return UITableViewCell()
            }
            cell.configurePoster(movie)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.titleIdentifire, for: indexPath) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            configure(with: movie)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
