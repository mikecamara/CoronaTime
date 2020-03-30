//
//  World.swift
//  Landmarks
//
//  Created by Mike Camara on 30/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public class World: Codable, Identifiable {
    public let cases: Int
    public let deaths: Int
    public let recovered: Int
    public let updated: Int
    public let active: Int

    enum CodingKeys: String, CodingKey {
        case cases = "cases"
        case deaths = "deaths"
        case recovered = "recovered"
        case updated = "updated"
        case active = "active"
    }

    public init(cases: Int, deaths: Int, recovered: Int, updated: Int, active:Int ) {
        self.cases = cases
        self.deaths = deaths
        self.recovered = recovered
        self.updated = updated
        self.active = active
    }
}

public typealias WorldData = World
