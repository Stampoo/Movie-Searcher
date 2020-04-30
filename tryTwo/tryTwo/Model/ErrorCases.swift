//
//  ErrorCases.swift
//  filmInfo
//
//  Created by fivecoil on 22/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

//Error cases
enum StuckMoment: Error {
    case noConnection
    case slowConnection
    case errorParcing
    case badLink
    case errorResponce
}
