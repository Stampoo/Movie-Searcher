//
//  ErrorCases.swift
//  filmInfo
//
//  Created by fivecoil on 22/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

enum ErrorCases: Error {
    case noConnection
    case slowConnection
    case errorParcing
    case badLink
    case errorInResponce
}
