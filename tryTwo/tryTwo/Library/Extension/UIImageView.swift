//
//  UIImageView.swift
//  filmInfo
//
//  Created by fivecoil on 22/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

//MARK: - load data from server and set this data to imgaeView instance
extension UIImageView {
    
    func loadImage(_ path: String?) {
        self.contentMode = .scaleAspectFill
        guard let path = path else {
            
            self.image = UIImage(named: "posterNotFound")
            return
        }
        guard let url = URL(string: path) else {
            self.image = UIImage(named: "posterNotFound")
            return
        }
        do {
            let cache = URLCache.shared
            let request = URLRequest(url: url)
            if let imageData = cache.cachedResponse(for: request)?.data {
                self.image = UIImage(data: imageData)
            } else {
                URLSession.shared.dataTask(with: request) {(data, response, _) in
                    let queue = DispatchQueue.global(qos: .utility)
                    queue.async {
                        guard let data = data, let responce = response else {
                            return
                        }
                        let casheResponce = CachedURLResponse(response: responce, data: data)
                        cache.storeCachedResponse(casheResponce, for: request)
                        DispatchQueue.main.async {
                            self.image = UIImage(data: data)
                        }
                    }
                    
                }.resume()
            }
        }
    }
    
}


