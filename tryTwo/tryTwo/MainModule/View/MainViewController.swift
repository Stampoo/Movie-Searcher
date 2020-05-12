//
//  ViewController.swift
//  tryTwo
//
//  Created by fivecoil on 29/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Constants
    private enum Constants {
        static let cellIdentifire = "mainCell"
        static let MainTableViewCellNib = "MainTableViewCell"
    }
    
    //MARK: - Properties
    var output: MainViewOutput?
    let activityView = CustomActivityIndicator(frame: UIScreen.main.bounds, complitionHandler: nil)
    
    //MARK: - Private Properties
    private let refresh = UIRefreshControl()
    private let searchController: UISearchController = {
        let bar  = UISearchController(searchResultsController: nil)
        bar.searchBar.barStyle = .default
        bar.searchBar.sizeToFit()
        return bar
    }()
    private let mainTable: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var isSearch = false {
        willSet {
            if newValue {
                displayData = searchData
                DispatchQueue.main.async {
                    self.mainTable.reloadData()
                }
            } else {
                displayData = popular
                DispatchQueue.main.async {
                    self.mainTable.reloadData()
                }
            }
        }
    }
    private var displayData = [Result]() {
        didSet {
            mainTable.reloadData()
        }
    }
    private var searchData = [Result]()
    private var popular = [Result]() {
        didSet {
            mainTable.reloadData()
        }
    }
    private var nowPlaying = [Result]()
    private var topRated = [Result]()
    private let link = LinkBuilder()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearch()
        createMainTable()
        activityView.startActivity(view: self.view)
        output?.viewLoaded()
        refresh.addTarget(self, action: #selector(reloadTable), for: .valueChanged)
        navigationItem.title = "Popular"
        createSegment()
    }
    
    //refresh handler
    @objc private func reloadTable() {
        mainTable.reloadData()
        refresh.endRefreshing()
    }
    
    //configure mainTable
    private func createMainTable() {
        let nib = UINib(nibName: Constants.MainTableViewCellNib, bundle: nil)

        mainTable.register(nib, forCellReuseIdentifier: Constants.cellIdentifire)
        mainTable.dataSource = self
        mainTable.delegate = self
        mainTable.separatorStyle = .none
        mainTable.backgroundColor = .white
        mainTable.addSubview(refresh)

        self.view.addSubview(mainTable)
        //constraint
        NSLayoutConstraint.activate([
                   mainTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
                   mainTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                   mainTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                   mainTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
               ])
    }
    
    //configureSearch
    private func configureSearch() {
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }

    //Custom segment control
    private func createSegment() {
        let segment = CustomSegmentView(frame: .init(x: 0,
                                                     y: 0,
                                                     width: view.frame.width,
                                                     height: 50), buttonTitles: ["Popular", "Now playing", "Top rated"], handler: nil)
        segment.delegate = self
        segment.backgroundColor = .clear
        navigationItem.titleView = segment
    }

    //switch feed state
    private func switchFeed(by index: Int) {
        switch index {
        case 0:
            displayData = popular
            navigationItem.title = "Popular"
        case 1:
            displayData = nowPlaying
            navigationItem.title = "Now Playing"
        case 2:
            displayData = topRated
            navigationItem.title = "Top rated"
        default:
            break
        }
        mainTable.reloadData()
    }

}



//MARK: - Extensions
extension MainViewController: MainViewInput {
    
    func setupInitialState(_ data: [Result]) {
        popular = data
        activityView.stopActiviy()
    }
    
    func configure(with list: [Result], use: Use) {
        switch use {
        case .popularResultUpdate:
            displayData = list
            mainTable.reloadData()
        case .searchResultUpdate:
            displayData = list
            mainTable.reloadData()
        case .nowPlayingResultUpdate:
            nowPlaying = list
        case .topRatedResultUpdate:
            topRated = list
        }
    }
    
}

//MainTableDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifire, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.configureCell(displayData[indexPath.row])
        return cell
    }
    
}

//SearchExtension
extension MainViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 2 {
            self.output?.send(key: text)
            self.output?.reload()
            self.isSearch = true
        }
    }

}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        displayData = popular
        DispatchQueue.main.async {
            self.mainTable.reloadData()
        }
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.present(with: displayData[indexPath.row].id)
    }
    
}

extension MainViewController: CustomSegmentViewDelegate {

    func changeByIndex(index: Int) {
        switch index {
        case 0:
            displayData = popular
            navigationItem.title = "Popular"
        case 1:
            displayData = nowPlaying
            navigationItem.title = "Now Playing"
        case 2:
            displayData = topRated
            navigationItem.title = "Top rated"
        default:
            break
        }
        mainTable.reloadData()
    }


}
