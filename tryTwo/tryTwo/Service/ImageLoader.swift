//
//  ImageLoader.swift
//  tryTwo
//
//  Created by fivecoil on 20/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class ImageLoader {

    //MARK: - Typealias

    typealias ErrorCloser = (ErrorCases) -> Void
    typealias ImageDataCloser = (Data) -> Void


    //MARK: - Private properties

    private var linkToImage: String
    private let cache = URLCache.shared
    private var request: URLRequest?
    

    //MARK: - Initializers

    init(linkToImage: String) {
        self.linkToImage = linkToImage
        if let url = URL(string: linkToImage) {
            request = URLRequest(url: url)
        }
    }


    //MARK: - Public methods

    func loadImage(at imageView: UIImageView, activityView: CustomActivityIndicator, errorHandler: ErrorCloser) {
        guard let request = request else {
            return errorHandler(.errorInResponce)
        }
        if let imageData = cache.cachedResponse(for: request)?.data {
            DispatchQueue.main.async {
                imageView.image = UIImage(data: imageData)
                activityView.stopActiviy()
            }
        } else {
            loadImageToCache(completionHandler: { imageData in
                imageView.image = UIImage(data: imageData)
                activityView.stopActiviy()
            })
        }
    }


    //MARK: - Private methods

    private func loadImageToCache(completionHandler: @escaping ImageDataCloser) {
        guard let request = request else {
            return
        }
        URLSession.shared.dataTask(with: request) { (data, responce, _) in
            guard let data = data, let responce = responce else {
                return
            }
            let cacheResponce = CachedURLResponse(response: responce, data: data)
            self.cache.storeCachedResponse(cacheResponce, for: request)
            DispatchQueue.main.async {
                completionHandler(data)
            }
        }.resume()
    }

}
