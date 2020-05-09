//
//  LinkConstructor.swift
//  filmInfo
//
//  Created by fivecoil on 23/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

//MARK: - for simple link constructor
struct LinkBuilder {
    
    private let key: String = "?api_key=7104ec0d95ea0fd2f075baec48f313ba"
    private let mainPath: String = "https://api.themoviedb.org/3/"
    private let baseUrl: String = "https://image.tmdb.org/t/p/"
    private let lng: String = "&language=en-US"
    private let popularity: String = "movie/popular"
    private let page: String = "&page="
    private let movie: String = "movie/"
    private let cast: String = "/credits"
    private let recommendation: String = "/recommendations"
    
    //return link at popular films
    func popular(page: Int) -> String {
        return self.mainPath + self.popularity + self.key + self.lng + self.page + "\(page)"
    }
    
    //return link to film at depend id
    func movie(id: Int) -> String {
        return self.mainPath + self.movie + "\(id)" + self.key + self.lng
    }
    
    //return link to poster
    func posterPath(path: String?, size: PosterSize) -> String {
        guard let path = path else { return ""}
        return self.baseUrl + size.rawValue + path
    }
    
    func cast(_ id: String) -> String {
        return mainPath + movie + id + cast + key
    }
    
    func query(target: QuerySearch, keyWords: String) -> String {
        let modifyKeyWords = keyWords.split(separator: " ")
        var finalKeyWords = String()
        for word in modifyKeyWords {
            if modifyKeyWords.firstIndex(of: word) == 0 {
                finalKeyWords += word
            } else {
                finalKeyWords += "+\(word)"
            }
        }
        return self.mainPath + target.rawValue + self.key + "&query=\(finalKeyWords)"
    }
    
    func seeAlso(_ id: String) -> String {
        return mainPath + movie + id + recommendation + key + lng + page + "\(1)"
    }
    
}

//MARK: - for poster path build
//TODO: - add new size constant
enum PosterSize: String {
    case w500 = "/w500"
}

enum QuerySearch: String {
    case actor = "search/actor"
    case movie = "search/movie"
    case series = "search/series"
}
