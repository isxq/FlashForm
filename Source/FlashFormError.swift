//
//  FlashFormError.swift
//  FlashForm
//
//  Created by ios on 2018/10/25.
//  Copyright © 2018 ios. All rights reserved.
//

import Foundation

enum FlashFormError : Error {
    case isNil(String)
    case checkFailed(String)
}
