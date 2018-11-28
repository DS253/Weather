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
    let weatherModel = WeatherModel()
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
        
    }
    func updateCity(city: String) {
        let parameter : [String : String] = ["q" : city, "appid" : APP_ID]
    }
}
