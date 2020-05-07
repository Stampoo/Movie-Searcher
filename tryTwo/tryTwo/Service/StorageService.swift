//
//  StorageService.swift
//  tryTwo
//
//  Created by fivecoil on 06/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

//Storage
final class StorageService {
    
    //MARK: - Constants
    enum Constants {
        static let key = "favoriteStorage"
    }
    
    //MARK: - Properties
    let dataFromStorage = UserDefaults.standard.array(forKey: Constants.key)
    
    //MARK: - Private properties
    private let storage = UserDefaults.standard
    
    func saveMovie(_ data: Movie) {
        var currentList = decodeData()
        currentList.append(data)
        save(list: currentList)
    }
    
    func deleteMovie(_ data: Movie) {
        var encodeData: [Data] = {
            var encodeData = [Data]()
            for film in decodeData() {
                guard  let filmData = try? JSONEncoder().encode(film) else {
                    continue
                }
                encodeData.append(filmData)
            }
            return encodeData
        }()
        if let index = encodeData.firstIndex(of: encodeMovie(data)) {
            encodeData.remove(at: index)
            save(list: decodeData(encodeData))
        }
    }
    
    func encodeMovie(_ movie: Movie) -> Data {
        guard let encodeMovie = try? JSONEncoder().encode(movie) else {
            return Data()
        }
        return encodeMovie
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
        storage.setValue(encodeData, forKey: Constants.key)
    }
    
    func decodeData(_ data: [Data] = [Data]()) -> [Movie] {
        var dataToDecode = [Data]()
        switch data.isEmpty {
        case true:
            guard let fromStorage = storage.array(forKey: Constants.key) as? [Data] else {
                break
            }
            dataToDecode = fromStorage
        case false:
            dataToDecode = data
        }
        var decodableData = [Movie]()
        for filmData in dataToDecode {
            guard let film = try? JSONDecoder().decode(Movie.self, from: filmData) else {
                continue
            }
            decodableData.append(film)
        }
        return decodableData
    }
}

