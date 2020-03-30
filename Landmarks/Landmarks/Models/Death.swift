//
//  Death.swift
//  Landmarks
//
//  Created by Mike Camara on 29/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public class Death: Codable, Identifiable {
//    public let day: String?
    public let day: [Date: Int]?
    enum CodingKeys: String, CodingKey {
//        case day = "day"
        case day = "day"
    }
    public init(
//         day: String,
        day: [Date: Int]) {
//        self.day = day
        self.day = day
    }
}
