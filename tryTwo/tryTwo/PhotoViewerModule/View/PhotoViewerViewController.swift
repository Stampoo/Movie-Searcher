//
//  PhotoViewerViewController.swift
//  tryTwo
//
//  Created by fivecoil on 27/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class PhotoViewerViewController: UIViewController, ModuleTransitionable {

    //MARK: - IBOutlets

    @IBOutlet weak var photoCollectionView: UICollectionView!


    //MARK: - Public properties

    var output: PhotoViewerOutput?

}


//MARK: - Extensions

extension PhotoViewerViewController: PhotoViewerInput {

    func configurate() {}

    func setupInitialState() {}

}
