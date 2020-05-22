//
//  LinkConstructor.swift
//  filmInfo
//
//  Created by fivecoil on 23/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

//MARK: - simple link constructor

struct LinkBuilder {

    //MARK: - Private properties

    private let key = "?api_key=7104ec0d95ea0fd2f075baec48f313ba"
    private let baseUrl = "https://api.themoviedb.org/3/"
    private let imageBaseUrl = "https://image.tmdb.org/t/p/"
    private let language = "&language=en-US"
    private let popularity = "movie/popular"
    private let nowPlaying = "movie/now_playing"
    private let topRated = "movie/top_rated"
    private let pagePrefix = "&page="
    private let searchPrefix = "&query="
    private let moviePrefix = "movie/"
    private let castPrefix = "/credits"
    private let actorPrefix = "/person"
    private let recommendationPrefix = "/recommendations"


    //MARK: - Public methods

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
        return imageBaseUrl + size.rawValue + path
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

    func pathToActor(id: String) -> String {
        return baseUrl + actorPrefix + id + key + language
    }
    
}
