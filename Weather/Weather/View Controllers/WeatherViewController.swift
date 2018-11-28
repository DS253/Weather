//
//  WeatherViewController.swift
//  Weather
//
//  Created by Daniel Stewart on 11/28/18.
//  Copyright © 2018 Daniel Stewart. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, CityUpdateDelegate {

    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "43daae7d4063aedd48701a1934ccfc46"
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func updateCity(city: String) {
        let parameter : [String : String] = ["q" : city, "appid" : APP_ID]
    }
}
