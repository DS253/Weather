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
    
    var delegate : CityUpdateDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        
        let cityName = changeCityTextField.text!
        
        delegate?.updateCity(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
