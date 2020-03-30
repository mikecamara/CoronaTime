//
//  Country.swift
//  Landmarks
//
//  Created by Mike Camara on 27/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import CoreLocation

public class Country: Codable, Identifiable {
    public let country: String
    public let countryInfo: CountryInfo
    public let cases: Int
    public let todayCases: Int
    public let deaths: Int
    public let todayDeaths: Int
    public let recovered: Int
    public let active: Int
    public let critical: Int
    public let updated: Int

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case countryInfo = "countryInfo"
        case cases = "cases"
        case todayCases = "todayCases"
        case deaths = "deaths"
        case todayDeaths = "todayDeaths"
        case recovered = "recovered"
        case active = "active"
        case critical = "critical"
        case updated = "updated"
    }

    public init(
        country: String
        , countryInfo: CountryInfo
        , cases: Int, todayCases: Int, deaths: Int, todayDeaths: Int, recovered: Int, active: Int , critical: Int, updated: Int
    ) {
        self.country = country
        self.countryInfo = countryInfo
        self.cases = cases
        self.todayCases = todayCases
        self.deaths = deaths
        self.todayDeaths = todayDeaths
        self.recovered = recovered
        self.active = active
        self.critical = critical
        self.updated = updated
    }
}

public typealias Countries = [Country]
