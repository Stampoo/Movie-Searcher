//
//  FavoriteViewController.swift
//  tryTwo
//
//  Created by fivecoil on 06/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Constants
    private enum Constants {
        static let favoriteCellIdentifire = "favoriteCell"
        static let favoriteCellNib = "FavoriteTableViewCell"
        static let favoriteStorage = "favoriteStorage"
    }
    
    //MARK: - Properties
    var presenter: FavoriteViewOutput?
    
    //MARK: - Private properties
    //element for empty state
    private let emptyView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        return view
    }()
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.frame = .init(x: 0,
                            y: ScreenSize().height * 0.5,
                            width: ScreenSize().width,
                            height: ScreenSize().height * 0.1)
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    private let tableView: UITableView = {
        let table = UITableView(frame: UIScreen.main.bounds)
        let nib = UINib(nibName: Constants.favoriteCellNib, bundle: nil)
        table.register(nib, forCellReuseIdentifier: Constants.favoriteCellIdentifire)
        return table
    }()
    private var dataInStorage = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        //empty state configuration
        emptyView.addSubview(emptyLabel)
        emptyLabel.text = "Nothing here yet..."
    }
    
    //MARK: - Internal methods
    //check empty states for this instance and out
    func checkEmptyState() {
        switch dataInStorage.isEmpty {
        case true:
            view.addSubview(emptyView)
        case false:
            emptyView.removeFromSuperview()
        }
        presenter?.reload()
    }

}

//MARK: - Extensions
extension FavoriteViewController: FavoriteViewInput {
    
    func configure(_ actualData: [Movie]) {
        dataInStorage = actualData
        tableView.reloadData()
    }
    
    func setupInitialState() {
        dataInStorage = StorageService().decodeData()
    }
    
    
}

//configure table, cell (DataSource)
extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoriteCellIdentifire, for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(dataInStorage[indexPath.row])
        return cell
    }
}

//tableView Delegate (Delete method, static row height)
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.16964285714285715
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataInStorage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageService().save(list: dataInStorage)
            checkEmptyState()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = dataInStorage[indexPath.row].id else {
            return
        }
        presenter?.present(with: id)
    }
    
}
