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
    private let baseUrl: String = "https://api.themoviedb.org/3/"
    private let imageBaseUrl: String = "https://image.tmdb.org/t/p/"
    private let language: String = "&language=en-US"
    private let popularity: String = "movie/popular"
    private let nowPlaying: String = "movie/now_playing"
    private let topRated: String = "movie/top_rated"
    private let pagePrefix: String = "&page="
    private let searchPrefix: String = "&query="
    private let moviePrefix: String = "movie/"
    private let castPrefix: String = "/credits"
    private let recommendationPrefix: String = "/recommendations"

    func pathMovies(pageNumber: Int, type: Category) -> String {
        return baseUrl + type.rawValue + key + language + pagePrefix + "\(pageNumber)"
    }

    func pathMovie(id: Int) -> String {
        return baseUrl + moviePrefix + "\(id)" + key + language
    }

    func pathPoster(path: String?, size: PosterSize) -> String {
        guard let path = path else {
            return ""
        }
        return baseUrl + size.rawValue + path
    }
    
    func pathToCastMovie(_ id: String) -> String {
        return baseUrl + moviePrefix + id + castPrefix + key
    }
    
    func pathToSearchResults(category: SearchCategory, keyWords: String) -> String {
        let separatedKeyWords = keyWords.split(separator: " ")
        var editedKeyWords = String()
        for word in separatedKeyWords {
            if separatedKeyWords.firstIndex(of: word) == 0 {
                editedKeyWords += word
            } else {
                editedKeyWords += "+\(word)"
            }
        }
        return baseUrl + category.rawValue + key + searchPrefix + editedKeyWords
    }
    
    func pathToSeeAlsoMovie(id: String, pageNumber: Int) -> String {
        return baseUrl + moviePrefix + id + recommendationPrefix + key + language + pagePrefix + "\(pageNumber)"
    }
    
}
