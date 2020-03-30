//
//  CountryInfo.swift
//  Landmarks
//
//  Created by Mike Camara on 27/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public class CountryInfo: Codable, Identifiable {
//    public let _id: Int
    public let lat: Double?
    public let long: Double?
    public let flag: String?
    public let iso3: String?
    public let iso2: String?
   

    enum CodingKeys: String, CodingKey {
//        case _id = "cases"
        case lat = "lat"
        case long = "long"
        case flag = "flag"
        case iso3 = "iso3"
        case iso2 = "iso2"
    }

    public init(
//        _id: Int,
        lat: Double, long: Double,
        flag: String
        ,
         iso3: String,
        iso2: String
//
    ) {
//        self._id = _id
        self.lat = lat
        self.long = long
        self.flag = flag
        self.iso3 = iso3
        self.iso2 = iso2
    }
}
