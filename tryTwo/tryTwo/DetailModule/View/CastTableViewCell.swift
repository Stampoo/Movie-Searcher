//
//  CastTableViewCell.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CastTableViewCell: UITableViewCell {
    
    //MARK: - Private Properties
    @IBOutlet private weak var castCollectionView: UICollectionView!
    private let collectionCellIdentifire = "castCollectionCell"
    

    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Methods
    func configure(_with: String) {
        //TODO: - data to ui
    }
    
    //MARK: - Private Methods
    private func configureUI() {
        //TODO: - create UI
        castCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellIdentifire)
    }
    
}

extension CastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifire, for: indexPath)
        return cell
    }
    
}
