//
//  ViewController.swift
//  DemoAPI2
//
//  Created by Tran Ngoc Nam on 5/30/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var temp_c: UILabel!
    @IBOutlet weak var date_epoch: UILabel!
    @IBOutlet weak var maxtemp_c: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: Notification.Name.init("update"), object: nil)
        DataService.shared.getDataWeatherFromAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updateData() {
        guard let data = DataService.shared.weather else { return }
        name.text = data.name
        country.text = data.country
        temp_c.text = "\(data.temp_c)"
        let forecast = data.forecastDay[1]
        date_epoch.text = getDateTime(date_epoch: forecast.date_epoch)
        maxtemp_c.text = "\(forecast.maxtemp_c)"
        text.text = forecast.text
        getImage()
    }
    
    func getDateTime(date_epoch: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: date_epoch)
        let formater = DateFormatter()
        formater.dateFormat = "EEEE, MMMM, dd, yyyy HH:mm:ss a"
        let getDate = formater.string(from: date as Date)
        return String(describing: getDate)
    }
    
    func getImage() {
        DataService.shared.download(with: "https://robohash.org/123.png") { image in
            self.icon.image = image
        }
    }
}

