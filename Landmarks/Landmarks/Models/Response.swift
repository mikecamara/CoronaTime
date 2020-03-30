//
//  Response.swift
//  Landmarks
//
//  Created by Mike Camara on 27/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct Response: Codable {
   var results: [Countries]
//    var cases: Int
//    var country: String
//    var flag: String
}

struct Result: Codable {
    var cases: Int
    var country: String
    var flag: String
}
