//
//  ForecastDay.swift
//  DemoAPI2
//
//  Created by Tran Ngoc Nam on 5/30/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit

class ForecastDay {
    var date_epoch: TimeInterval
    var maxtemp_c: Double
    var mintemp_c: Double
    var text: String
    var icon: String
    
    init?(dictionary: JSON) {
        guard let date_epoch = dictionary["date_epoch"] as? TimeInterval else { return nil }
        guard let day = dictionary["day"] as? JSON else { return nil }
        guard let maxtemp_c = day["maxtemp_c"] as? Double else { return nil }
        guard let mintemp_c = day["mintemp_c"] as? Double else { return nil }
        guard let condition = day["condition"] as? JSON else { return nil }
        guard let text = condition["text"] as? String else { return nil }
        guard let icon = condition["icon"] as? String else { return nil }
        
        self.date_epoch = date_epoch
        self.maxtemp_c = maxtemp_c
        self.mintemp_c = mintemp_c
        self.text = text
        self.icon = "http:" + icon
    }
}

