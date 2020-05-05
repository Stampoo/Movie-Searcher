//
//  CastTableViewCell.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CastTableViewCell: UITableViewCell {
    
    //MARK: - TypeAlias
    typealias IdCloser = (_ id: Int) -> Void
    
    //MARK: - Constants
    enum Constants {
        static let collectionCellIdentifire = "castCollectionCell"
        static let collectionCellNib = "CastCollectionViewCell"
    }
    
    //MARK: - Properties
    var pushDetail: IdCloser?
    
    //MARK: - Private Properties
    @IBOutlet private weak var castCollectionView: UICollectionView!
    private var displayArray: Any? {
        didSet {
            DispatchQueue.main.async {
                self.castCollectionView.reloadData()
            }
        }
    }
    

    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        
    }
    
    //MARK: - Methods
    func configure(_ with: Any){
        switch with {
        case is [Cast]:
            self.displayArray = with as? [Cast]
        case is [Result]:
            self.displayArray = with as? [Result]
        default:
            break
        }
    }
    
    //MARK: - Private Methods
    private func configureUI() {
        //TODO: - create UI
        let castCollectionNib = UINib(nibName: Constants.collectionCellNib, bundle: nil)
        castCollectionView.register(castCollectionNib, forCellWithReuseIdentifier: Constants.collectionCellIdentifire)
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
    
}

//MARK: - Extensions
extension CastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch displayArray {
        case is [Cast]:
            guard let display = displayArray as? [Cast] else {
                return 0
            }
            return display.count
        case is [Result]:
            guard let display = displayArray as? [Result] else {
                return 0
            }
            return display.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellIdentifire, for: indexPath) as? CastCollectionViewCell else {
            return UICollectionViewCell()
        }
        switch displayArray {
        case is [Cast]:
            guard let display = displayArray as? [Cast] else {
                return UICollectionViewCell()
            }
            cell.configureCell(with: display[indexPath.row])
            return cell
        case is [Result]:
            guard let display = displayArray as? [Result] else {
                return UICollectionViewCell()
            }
            cell.configureCell(with: display[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

//Did select
extension CastTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = displayArray as? [Result] {
            pushDetail?(data[indexPath.row].id)
            print(pushDetail)
        }
    }
}

