//
//  CastTableViewCell.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CastTableViewCell: UITableViewCell {
    
    //MARK: - Constants
    enum Constants {
        static let collectionCellIdentifire = "castCollectionCell"
        static let collectionCellNib = "CastCollectionViewCell"
    }
    
    //MARK: - Private Properties
    @IBOutlet private weak var castCollectionView: UICollectionView!
    private var castArray = [Cast]()
    

    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        
    }
    
    //MARK: - Methods
    func configure(_ with: [Cast]?){
        guard let castArray = with else {
            return
        }
        self.castArray = castArray
    }
    
    //MARK: - Private Methods
    private func configureUI() {
        //TODO: - create UI
        let castCollectionNib = UINib(nibName: Constants.collectionCellNib, bundle: nil)
        castCollectionView.register(castCollectionNib, forCellWithReuseIdentifier: Constants.collectionCellIdentifire)
        castCollectionView.dataSource = self
    }
    
}

extension CastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellIdentifire, for: indexPath) as? CastCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: castArray[indexPath.row])
        return cell
    }
    
}
