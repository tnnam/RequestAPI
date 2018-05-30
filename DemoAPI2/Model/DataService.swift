//
//  DataService.swift
//  DemoAPI2
//
//  Created by Tran Ngoc Nam on 5/30/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit

typealias JSON = Dictionary<AnyHashable, Any>

class DataService {
    
    static let shared: DataService = DataService()
    
    var weather: Weather?
    
    func getDataWeatherFromAPI() {
        let urlString = "https://api.apixu.com/v1/forecast.json?key=fc0bcf76aecc432ca4c21120182905&q=Hanoi&days=7&lang=vi"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        DispatchQueue.global().async {
            let weatherTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let dataWeather = data else { return }
                do {
                    guard let result = try JSONSerialization.jsonObject(with: dataWeather, options: .mutableContainers) as? JSON else { return }
                    self.weather = Weather(dictionary: result)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name.init("update"), object: nil)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
            weatherTask.resume()
        }
    }
    
    func download(with urlString: String, complete: @escaping(UIImage?)->Void) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        complete(image)
                    }
                }
            }
        } else {
            complete(nil)
        }
    }
    
}
