//
//  ChangeCityViewController.swift
//  Weather
//
//  Created by Daniel Stewart on 11/28/18.
//  Copyright © 2018 Daniel Stewart. All rights reserved.
//

import UIKit

protocol CityUpdateDelegate {
    func updateCity(city: String)
}

class ChangeCityViewController: UIViewController {

    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: Any) {
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
    }
}
