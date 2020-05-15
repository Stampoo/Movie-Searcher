//
//  ViewController.swift
//  tryTwo
//
//  Created by fivecoil on 29/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class MainModuleViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Constants

    private enum Constants {
        static let movieCellIdentifire = "mainCell"
        static let moviesTableViewCellNib = "MainTableViewCell"
        static let screenSize = UIScreen.main.bounds
        static let defaultNavigationTitle = "Popular"
        static let popularNavigationTitle = "Popular"
        static let nowPlayingNaviationTitle = "Now playing"
        static let topRatedNavigationTitle = "Top Rated"
        static let minCharInSearch = 2
    }


    //MARK: - Properties

    var output: MainViewOutput?
    let activityView = CustomActivityIndicator(frame: Constants.screenSize, complitionHandler: nil)


    //MARK: - Private Properties

    private let refreshOrb = UIRefreshControl()
    private let searchController: UISearchController = {
        let bar  = UISearchController(searchResultsController: nil)
        bar.searchBar.barStyle = .default
        bar.searchBar.sizeToFit()
        return bar
    }()
    private let moviesTable: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var isSearch = false {
        willSet {
            if newValue {
                displayedMoviesInTable = searchMovies
                DispatchQueue.main.async {
                    self.moviesTable.reloadData()
                }
            } else {
                displayedMoviesInTable = popularMovies
                DispatchQueue.main.async {
                    self.moviesTable.reloadData()
                }
            }
        }
    }
    private var displayedMoviesInTable = [Result]() {
        didSet {
            moviesTable.reloadData()
        }
    }
    private var searchMovies = [Result]()
    private var popularMovies = [Result]() {
        didSet {
            moviesTable.reloadData()
        }
    }
    private var nowPlayingMovies = [Result]()
    private var topRatedMovies = [Result]()


    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.startActivity(view: self.view)

        output?.viewLoaded()
        configureSearchBar()
        configureMoviesTable()
        configureFeedSegment()

        navigationItem.title = Constants.defaultNavigationTitle
        refreshOrb.addTarget(self, action: #selector(refreshTablePullTop), for: .valueChanged)
    }


    //MARK: - Private methods

    @objc private func refreshTablePullTop() {
        moviesTable.reloadData()
        refreshOrb.endRefreshing()
    }

    private func configureMoviesTable() {
        let nib = UINib(nibName: Constants.moviesTableViewCellNib, bundle: nil)

        moviesTable.register(nib, forCellReuseIdentifier: Constants.movieCellIdentifire)
        moviesTable.dataSource = self
        moviesTable.delegate = self
        moviesTable.separatorStyle = .none
        moviesTable.backgroundColor = .white
        moviesTable.addSubview(refreshOrb)
        self.view.addSubview(moviesTable)
        moviesTableConstraints()
    }

    private func moviesTableConstraints() {
        NSLayoutConstraint.activate([
            moviesTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            moviesTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            moviesTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            moviesTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureSearchBar() {
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }

    private func configureFeedSegment() {
        let titlesForSegment =  [
            Constants.popularNavigationTitle,
            Constants.nowPlayingNaviationTitle,
            Constants.topRatedNavigationTitle
        ]
        let segment = CustomSegmentView(frame: .init(x: 0,
                                                     y: 0,
                                                     width: view.frame.width,
                                                     height: 50), buttonTitles: titlesForSegment, handler: nil)
        segment.delegate = self
        segment.backgroundColor = .clear
        navigationItem.titleView = segment
    }

    private func switchFeed(by index: Int) {
        switch index {
        case 0:
            displayedMoviesInTable = popularMovies
            navigationItem.title = Constants.popularNavigationTitle
        case 1:
            displayedMoviesInTable = nowPlayingMovies
            navigationItem.title = Constants.nowPlayingNaviationTitle
        case 2:
            displayedMoviesInTable = topRatedMovies
            navigationItem.title = Constants.topRatedNavigationTitle
        default:
            break
        }
        moviesTable.reloadData()
    }

}


//MARK: - Extensions

extension MainModuleViewController: MainViewInput {
    
    func setupInitialState(_ data: [Result]) {
        popularMovies = data
        activityView.stopActiviy()
    }
    
    func configure(with list: [Result], use: Category) {
        switch use {
        case .popularMovies:
            displayedMoviesInTable = list
            moviesTable.reloadData()
        case .searchResultsMovies:
            displayedMoviesInTable = list
            moviesTable.reloadData()
        case .nowPlayingMovies:
            nowPlayingMovies = list
        case .topRatedMovies:
            topRatedMovies = list
        }
    }
    
}

extension MainModuleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMoviesInTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellIdentifire,
                                                       for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(displayedMoviesInTable[indexPath.row])
        return cell
    }
    
}

extension MainModuleViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text,
            text.count > Constants.minCharInSearch {
            self.output?.send(key: text)
            self.output?.reloadView()
            self.isSearch = true
        }
    }

}

extension MainModuleViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        displayedMoviesInTable = popularMovies
        DispatchQueue.main.async {
            self.moviesTable.reloadData()
        }
    }
    
}

extension MainModuleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.present(with: displayedMoviesInTable[indexPath.row].id)
    }
    
}

extension MainModuleViewController: CustomSegmentViewDelegate {

    func changeByIndex(index: Int) {
        switch index {
        case 0:
            displayedMoviesInTable = popularMovies
            navigationItem.title = Constants.popularNavigationTitle
        case 1:
            displayedMoviesInTable = nowPlayingMovies
            navigationItem.title = Constants.nowPlayingNaviationTitle
        case 2:
            displayedMoviesInTable = topRatedMovies
            navigationItem.title = Constants.topRatedNavigationTitle
        default:
            break
        }
        moviesTable.reloadData()
    }


}
