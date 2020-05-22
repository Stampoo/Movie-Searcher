//
//  Actor.swift
//  tryTwo
//
//  Created by fivecoil on 22/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct Actor: Codable {
    let birthday: String
    let id: Int
    let name: String
    let biography: String
    let placeOfBirth: String?
    let profilePath: String
}
