//
//  Use.swift
//  tryTwo
//
//  Created by fivecoil on 01/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

enum Use: String {
    case searchResultUpdate
    case popularResultUpdate = "movie/popular"
    case nowPlayingResultUpdate = "movie/now_playing"
    case topRatedResultUpdate = "movie/top_rated"
}

