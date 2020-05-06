//
//  StorageService.swift
//  tryTwo
//
//  Created by fivecoil on 06/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class StorageService {
    
    private let storage = UserDefaults.standard
    private let key = "favoriteStorage"
    
    func saveMovie(_ data: Movie) {
        var currentList = decodeData()
        currentList.append(data)
        save(list: currentList)
    }
    
    func save(list: [Movie]) {
        let encodeData: [Data] = {
            var encodeData = [Data]()
            for film in list {
                guard  let filmData = try? JSONEncoder().encode(film) else {
                    continue
                }
                encodeData.append(filmData)
            }
            return encodeData
        }()
        storage.setValue(encodeData, forKey: key)
    }
    
    func decodeData() -> [Movie] {
        var decodableData = [Movie]()
        guard let currentData = storage.array(forKey: key) as? [Data] else {
            return [Movie]()
        }
        for filmData in currentData {
            guard let film = try? JSONDecoder().decode(Movie.self, from: filmData) else {
                continue
            }
            decodableData.append(film)
        }
        return decodableData
    }
}

