//
//  Parent.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 21/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation

struct Parent: Codable {
    let title, locationType: String
    let woeid: Int
    let lattLong: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}
