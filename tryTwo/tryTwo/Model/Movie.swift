//
//  Film.swift
//  tryTwo
//
//  Created by fivecoil on 29/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let backdropPath: String?
    let homepage: String?
    let id: Int?
    let originalTitle: String?
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let genres: [Genres?]
}

struct Genres: Codable {
    let id: Int
    let name: String
}
