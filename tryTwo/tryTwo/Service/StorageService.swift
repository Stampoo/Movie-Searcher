//
//  StorageService.swift
//  tryTwo
//
//  Created by fivecoil on 06/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class StorageService {
    
    //MARK: - Constants

    enum Constants {
        static let key = "favoriteStorage"
    }


    //MARK: - Properties

    let listFromStorage = UserDefaults.standard.array(forKey: Constants.key)


    //MARK: - Private properties

    private let storage = UserDefaults.standard


    //MARK: - Methods

    func saveMovieInStorage(_ data: Movie) {
        guard let actualData = listFromStorage as? [Data] else {
            return
        }
        if !actualData.contains(encodeMovieFromModel(data)) {
            var currentList = decodeMovieFromData()
            currentList.append(data)
            saveToStorage(list: currentList)
        }
    }
    
    func deleteMovieFromStorage(_ data: Movie) {
        var encodeData: [Data] = {
            var encodeData = [Data]()
            for film in decodeMovieFromData() {
                guard  let filmData = try? JSONEncoder().encode(film) else {
                    continue
                }
                encodeData.append(filmData)
            }
            return encodeData
        }()
        if let index = encodeData.firstIndex(of: encodeMovieFromModel(data)) {
            encodeData.remove(at: index)
            saveToStorage(list: decodeMovieFromData(encodeData))
        }
    }
    
    func encodeMovieFromModel(_ movie: Movie) -> Data {
        guard let encodeMovie = try? JSONEncoder().encode(movie) else {
            return Data()
        }
        return encodeMovie
    }
    
    func saveToStorage(list: [Movie]) {
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
    
    func decodeMovieFromData(_ data: [Data] = [Data]()) -> [Movie] {
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

