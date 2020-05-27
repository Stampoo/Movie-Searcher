//
//  CollectionCellFactory.swift
//  tryTwo
//
//  Created by fivecoil on 27/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CollectionCellFactory: CollectionCellFactoryProtocol {

    func createCell(cellType: CollectionTypes, indexPath: IndexPath, collection: UICollectionView, identifire: String) -> UICollectionViewCell {
        switch cellType {
        case .actorCell:
            guard let cell = collection.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as? CastCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        default:
        return UICollectionViewCell()
        }
    }

}
