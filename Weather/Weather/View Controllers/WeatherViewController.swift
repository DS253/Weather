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
    
    // Retrieve network weather data
    func getWeatherData(url: String, parameters : [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Network Issues"
            }
        }
    }
    
    // Parse network weather data
    func updateWeatherData(json : JSON) {
        if let weatherData = json["main"]["temp"].double {
            weatherModel.temperature = Int(weatherData - 273.15)
            weatherModel.city = json["name"].stringValue
            weatherModel.condition = json["weather"][0]["id"].intValue
            weatherModel.weatherIconName = weatherModel.updateWeatherImage(condition: weatherModel.condition)
            updateUIWithWeatherData()
        }
        else {
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    // Update the UI with the appropriate Weather data
    func updateUIWithWeatherData() {
        cityLabel.text = weatherModel.city
        temperatureLabel.text = "\(weatherModel.temperature)" + "°"
        weatherImage.image = UIImage(named: weatherModel.weatherIconName)
    }
    
    // MARK: - CLLoationManager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to retrieve location data: \(error)")
        cityLabel.text = "Location Unavailable"
    }
    
    // Delegate method to update a city's weather data
    func updateCity(city: String) {
        let parameter : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: parameter)
    }
    
    // Segue method sets CityVC delegate to this VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateCity" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
}
