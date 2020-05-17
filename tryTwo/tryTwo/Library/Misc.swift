//
//  CurrentScreenSize.swift
//  filmInfo
//
//  Created by fivecoil on 23/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit


//MARK:- Temp structs

struct ScreenSize {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.width
}

struct ColorVote {
    func calculateColor(_ vote: Double) -> UIColor {
        switch vote {
        case 0..<4:
            return .red
        case 4..<6.5:
            return .init(red: 249/255, green: 204/255, blue: 51/255, alpha: 1)
        case 6.5...10:
            return .init(red: 102/255, green: 204/255, blue: 51/255, alpha: 1)
        default:
            break
        }
        return .black
    }
}

enum StorageActions {
    case del
    case save
}

enum ActivityAction {
    case show
    case dismiss
}

enum PosterSize: String {
    case w500 = "/w500"
    case w780 = "/w780"
    case w1000 = "/w1280"
    case w1920 = "/w1920"
    case original = "/original"
}

enum SearchCategory: String {
    case actor = "search/actor"
    case movie = "search/movie"
    case series = "search/series"
}
//https://api.themoviedb.org/3/movie/{movie_id}/images?api_key=<<api_key>>&language=en-US
