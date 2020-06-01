//
//  ActorImages.swift
//  tryTwo
//
//  Created by fivecoil on 25/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct ActorImages: Codable {
    let id: Int
    let profiles: [Profiles]
}

struct Profiles: Codable {
    let filePath: String
    let height: Int
    let width: Int
}
