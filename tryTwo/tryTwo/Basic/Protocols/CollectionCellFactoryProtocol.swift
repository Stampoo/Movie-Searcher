//
//  CollectionCellFactory.swift
//  tryTwo
//
//  Created by fivecoil on 27/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

enum CollectionTypes {
    case actorCell
    case movieCell
}

protocol CollectionCellFactoryProtocol: class {

    func createCell(cellType: CollectionTypes,
                    indexPath: IndexPath,
                    collection: UICollectionView,
                    identifire: String) -> UICollectionViewCell

}

