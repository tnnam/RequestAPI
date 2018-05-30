//
//  Weather.swift
//  DemoAPI2
//
//  Created by Tran Ngoc Nam on 5/30/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit

class Weather {
    var name: String
    var country: String
    var temp_c: Double
    var forecastDay: [ForecastDay] = []
    
    init?(dictionary: JSON) {
        guard let location = dictionary["location"] as? JSON else { return nil }
        guard let name = location["name"] as? String else { return nil }
        guard let country = location["country"] as? String else { return nil }
        guard let current = dictionary["current"] as? JSON else  { return nil }
        guard let temp_c = current["temp_c"] as? Double else { return nil }
        guard let forecast = dictionary["forecast"] as? JSON else { return nil }
        guard let forecastday = forecast["forecastday"] as? [JSON] else { return nil }
        for objectForecast in forecastday {
            guard let dataForecast = ForecastDay(dictionary: objectForecast) else { return nil }
            self.forecastDay.append(dataForecast)
        }
        self.name = name
        self.country = country
        self.temp_c = temp_c
    }
}
