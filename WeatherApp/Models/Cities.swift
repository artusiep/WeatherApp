//
//  Cities.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 26/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation

typealias Cities = [City]

struct City: Codable {
    let title: String
    let locationType: LocationType
    let woeid: Int
    let lattLong: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}

enum LocationType: String, Codable {
    case city = "City"
    case regionStateProvince = "Region / State / Province"
}
