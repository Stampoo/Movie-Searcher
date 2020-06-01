//
//  CustomOperators.swift
//  tryTwo
//
//  Created by fivecoil on 28/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

infix operator ~

func ~<T>(leftOperand: T?, rightOperand: (T) -> Void) {
    guard let leftOperand = leftOperand else {
        return
    }
    rightOperand(leftOperand)
}
