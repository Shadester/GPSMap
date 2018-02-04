//
//  Location.swift
//  GPSMap
//
//  Created by Erik Lindberg on 2018-02-03.
//  Copyright © 2018 Erik Lindberg. All rights reserved.
//

import Foundation

struct Location: Codable {
    let timeStamp: Date
    let latitude: Double
    let longitude: Double
}
