//
//  World.swift
//  Landmarks
//
//  Created by Mike Camara on 30/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public class World: Codable, Identifiable {
    public let updated:  Int
    public let cases: Int
    public let todayCases: Int
    public let deaths: Int
    public let todayDeaths: Int
    public let recovered: Int
    public let active: Int
    public let critical: Int
    public let casesPerOneMillion: Int
    public let deathsPerOneMillion: Int
    public let tests: Int
    public let testsPerOneMillion: Double
    public let affectedCountries: Int

    enum CodingKeys: String, CodingKey {
        case updated = "updated"
        case cases = "cases"
        case todayCases = "todayCases"
        case deaths = "deaths"
        case todayDeaths = "todayDeaths"
        case recovered = "recovered"
        case active = "active"
        case critical = "critical"
        case casesPerOneMillion = "casesPerOneMillion"
        case deathsPerOneMillion = "deathsPerOneMillion"
        case tests = "tests"
        case testsPerOneMillion = "testsPerOneMillion"
        case affectedCountries = "affectedCountries"
    }

    public init(updated: Int, cases: Int, todayCases: Int, deaths: Int, todayDeaths: Int, recovered: Int, active:Int, critical: Int, casesPerOneMillion: Int, deathsPerOneMillion: Int, tests: Int, testsPerOneMillion: Double, affectedCountries: Int ) {
        self.updated = updated
        self.cases = cases
        self.todayCases = todayCases
        self.deaths = deaths
        self.todayDeaths = todayDeaths
        self.recovered = recovered
        self.active = active
        self.critical = critical
        self.casesPerOneMillion = casesPerOneMillion
        self.deathsPerOneMillion = deathsPerOneMillion
        self.tests = tests
        self.testsPerOneMillion = testsPerOneMillion
        self.affectedCountries = affectedCountries
    }
}

public typealias WorldData = World
