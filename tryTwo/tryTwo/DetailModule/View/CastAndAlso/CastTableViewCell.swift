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

   private enum Constants {
        static let collectionCellIdentifire = "castCollectionCell"
        static let collectionCellNib = "CastCollectionViewCell"
    }


    //MARK: IBOutlets

    @IBOutlet private weak var castCollectionView: UICollectionView!


    //MARK: - Properties

    var pushDetailView: IdCloser?

    
    //MARK: - Private Properties

    private var displayedCasts: Any? {
        didSet {
            DispatchQueue.main.async {
                self.castCollectionView.reloadData()
            }
        }
    }
    

    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }


    //MARK: - Internal methods

    func configureDisplayedCasts(_ with: Any){
        switch with {
        case is [Cast]:
            self.displayedCasts = with as? [Cast]
        case is [Result]:
            self.displayedCasts = with as? [Result]
        default:
            break
        }
    }


    //MARK: - Private Methods

    private func configureCollectionView() {
        let castCollectionNib = UINib(nibName: Constants.collectionCellNib, bundle: nil)
        castCollectionView.register(castCollectionNib, forCellWithReuseIdentifier: Constants.collectionCellIdentifire)
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
    
}


//MARK: - Extensions

extension CastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch displayedCasts {
        case is [Cast]:
            guard let display = displayedCasts as? [Cast] else {
                return 0
            }
            return display.count
        case is [Result]:
            guard let display = displayedCasts as? [Result] else {
                return 0
            }
            return display.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellIdentifire,
                                                            for: indexPath) as? CastCollectionViewCell else {
            return UICollectionViewCell()
        }
        switch displayedCasts {
        case is [Cast]:
            guard let display = displayedCasts as? [Cast] else {
                return UICollectionViewCell()
            }
            cell.configureCell(with: display[indexPath.row])
            return cell
        case is [Result]:
            guard let display = displayedCasts as? [Result] else {
                return UICollectionViewCell()
            }
            cell.configureCell(with: display[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension CastTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = displayedCasts as? [Result] {
            pushDetailView?(data[indexPath.row].id)
        }
    }

}

