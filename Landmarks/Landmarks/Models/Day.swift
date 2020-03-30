//
//  Day.swift
//  Landmarks
//
//  Created by Mike Camara on 29/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
public class Day: Codable, Identifiable {
//    public let day: String?
     public var innerDay: [String: Int]?
//    public let amount: Int?
    enum CodingKeys: String, CodingKey {
//        case day = "day"
        case innerDay = "innerDay"
    }
    public init(
//         day: String,
        innerDay: [String: Int]) {
//        self.day = day
        self.innerDay = innerDay
    }
}
