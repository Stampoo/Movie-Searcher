//
//  FavoriteViewController.swift
//  tryTwo
//
//  Created by fivecoil on 06/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Constants

    private enum Constants {
        static let favoriteCellIdentifire = "favoriteCell"
        static let favoriteCellNib = "FavoriteTableViewCell"
        static let favoriteStorage = "favoriteStorage"
        static let screenSize = UIScreen.main.bounds
        static let middleScreenAtY = Constants.screenSize.height / 2
        static let emptyLabelHeight = Constants.screenSize.height * 0.1
        static let emptyLabelFontSize: CGFloat = 25
        static let emptyLabelText = "Nothing here yet..."
        static let heightRowInTable = Constants.screenSize.height * 0.16964285714285715
    }


    //MARK: - Public properties

    var output: FavoriteViewOutput?


    //MARK: - Private properties

    private let emptyView: UIView = {
        let view = UIView(frame: Constants.screenSize)
        view.backgroundColor = .white
        return view
    }()
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.frame = .init(x: 0,
                            y: Constants.middleScreenAtY,
                            width: Constants.screenSize.width,
                            height: Constants.emptyLabelHeight)
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.emptyLabelFontSize)
        return label
    }()
    private let tableView: UITableView = {
        let table = UITableView(frame: Constants.screenSize)
        let nib = UINib(nibName: Constants.favoriteCellNib, bundle: nil)
        table.register(nib, forCellReuseIdentifier: Constants.favoriteCellIdentifire)
        return table
    }()
    private var moviesInStorage = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        emptyView.addSubview(emptyLabel)
        emptyLabel.text = Constants.emptyLabelText
    }

    
    //MARK: - Public methods

    func checkMoviesInStorage() {
        switch moviesInStorage.isEmpty {
        case true:
            view.addSubview(emptyView)
        case false:
            emptyView.removeFromSuperview()
        }
        output?.reloadView()
    }

}


//MARK: - Extensions

extension FavoriteViewController: FavoriteViewInput {
    
    func configure(with moviesInStorage: [Movie]) {
        self.moviesInStorage = moviesInStorage
        tableView.reloadData()
    }
    
    func setupInitialState() {
        moviesInStorage = StorageService().decodeMovieFromData()
    }

}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesInStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoriteCellIdentifire,
                                                       for: indexPath) as? FavoriteTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.configureCell(with: moviesInStorage[indexPath.row])
        return cell
    }

}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightRowInTable
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            moviesInStorage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageService().saveToStorage(list: moviesInStorage)
            checkMoviesInStorage()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = moviesInStorage[indexPath.row].id else {
            return
        }
        output?.present(with: id)
    }
    
}
