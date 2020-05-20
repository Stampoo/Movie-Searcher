//
//  UIImageView.swift
//  filmInfo
//
//  Created by fivecoil on 22/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

//MARK: - load data from server and set this data to imageView instance

extension UIImageView {

    //MARK: - Public methods
    
    func loadImage(_ path: String?) {
        guard let urlPath = path else {
            setupShieldImage()
            return
        }
        let imageLoader = ImageLoader(linkToImage: urlPath)
        imageLoader.loadImage(at: self, errorHandler: {_ in
            setupShieldImage()
        })
        self.contentMode = .scaleAspectFill
    }


    //MARK: - Private methods

    private func setupShieldImage() {
        let shieldImage = UIImage(named: "posterNotFound")
        self.image = shieldImage
    }

}
