//
//  Historical.swift
//  Landmarks
//
//  Created by Mike Camara on 29/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public class Historical: Codable, Identifiable {
    public let country: String?
    public let province: String?
    public let timeline: Timeline?
   
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case province = "province"
        case timeline = "timeline"
    }

    public init(country: String, province: String, timeline: Timeline) {
        self.country = country
        self.province = province
        self.timeline = timeline
    }
}


public typealias Historicals = [Historical]
