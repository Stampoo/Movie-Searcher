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
            print(self.isSearch)
            if newValue == false {
                DispatchQueue.main.async {
                    self.displayData = self.popular
                    self.mainTable.reloadData()
                }
            }
        }
    }
    private var displayData = [Result]()
    private var searchData = [Result]()
    private var popular = [Result]() {
        didSet {
            DispatchQueue.main.async {
                self.displayData = self.popular
                self.mainTable.reloadData()
            }
        }
    }
    private let link = LinkBuilder()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        createMainTable()
        output?.viewLoaded()
        refresh.addTarget(self, action: #selector(reloadTable), for: .valueChanged)
        
        
    }
    //refresh handler
    @objc private func reloadTable() {
        mainTable.reloadData()
        refresh.endRefreshing()
    }
    
    private func createMainTable() {
        let nib = UINib(nibName: Constants.MainTableViewCellNib, bundle: nil)
        mainTable.register(nib, forCellReuseIdentifier: Constants.cellIdentifire)
        self.view.addSubview(mainTable)
        NSLayoutConstraint.activate([
            mainTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        mainTable.dataSource = self
        mainTable.separatorStyle = .none
        mainTable.backgroundColor = .white
        mainTable.addSubview(refresh)
    }
    
}



//MARK: - Extensions
extension MainViewController: MainViewInput {
    func setupInitialState() {
        print("")
    }
    
    func configure(with list: [Result]) {
        popular = list
        mainTable.reloadData()
    }
    
    
}

//MainTableDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(displayData.count)
        return displayData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifire, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.configureCell(displayData[indexPath.row])
        return cell
    }
    
}