//
//  Day.swift
//  Landmarks
//
//  Created by Mike Camara on 29/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public class Timeline: Codable, Identifiable {

    public let cases: [String: Int?]?
    public let deaths: [String: Int?]?
   

    enum CodingKeys: String, CodingKey {
        case cases = "cases"
        case deaths = "deaths"
    }

    public init(
        cases: [String: Int], deaths: [String: Int]) {
        self.cases = cases
        self.deaths = deaths
    }
}

