//
//  MovieList.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let voteAverage: Double
    let title: String?
    let releaseDate: String?
    let backdropPath: String?
    let overview: String?
    let posterPath: String?
}
