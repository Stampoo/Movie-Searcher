//
//  Cast.swift
//  tryTwo
//
//  Created by fivecoil on 03/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct CastList: Codable {
    let cast: [Cast]
}

struct Cast: Codable {
    let castId: Int
    let character: String
    let creditId: String
    let id: Int
    let name: String
    let profilePath: String?
}






