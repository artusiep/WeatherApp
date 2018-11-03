//
//  ViewController.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 21/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = ViewModel()

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var maxTempTextField: UITextField!
    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var windVelTextField: UITextField!
    @IBOutlet weak var windDirTextField: UITextField!
    @IBOutlet weak var rainfallTextField: UITextField!
    @IBOutlet weak var pressureTextField: UITextField!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var cityNavItem: UINavigationItem!
    @IBOutlet weak var nextBtn: UIButton!
    let currentDate = Date()
    var date = Date()
    let dateFormatterPrint = DateFormatter()
    var woeid = 0
    let calendar = Calendar.current
    var weatherData: [ConsolidatedWeather] = []
    var dayIterator = 0
    let rainingStates = ["sn", "sl", "h", "t", "hr", "lr", "s"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bootstrap()
        
        
        statusImageView.contentMode = .scaleAspectFit
    }
    
    private func bootstrap() {
        prevBtn.isEnabled = false
        nextBtn.isEnabled = true
        date = currentDate
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        self.woeid = cityForecasts[myIndex].woeid
        self.weatherData = (cityForecasts[myIndex].forecast?.consolidatedWeather)!
        cityTextField.text = cityForecasts[myIndex].forecast?.title
        cityNavItem.title = cityForecasts[myIndex].forecast?.title
        cityNavItem.backBarButtonItem?.title = "Back"
        self.changeDate(day: 0)
    }

    private func changeDate(day: Int) {
        
        date = calendar.date(byAdding: .day, value: day, to: self.date)!
        dayIterator = dayIterator + day
        if(dayIterator < 0) {
            dayIterator = 0
        }
        if(dayIterator > weatherData.endIndex - 1) {
            dayIterator = weatherData.endIndex - 1
        }
        
        prevBtn.isEnabled = dayIterator > 0 ? true : false
        nextBtn.isEnabled = (dayIterator < weatherData.endIndex - 1) ? true : false
        

        dateLabel.text = dateFormatterPrint.string(from: date)
        updateForecast()
        
    }

    private func updateForecast() {
        statusImageView.image = UIImage(named: weatherData[dayIterator].weatherStateAbbr)
        statusLabel.text = weatherData[dayIterator].weatherStateName
        maxTempTextField.text = String(round2(value: weatherData[dayIterator].maxTemp)) + " ℃"
        minTempTextField.text = String(round2(value: weatherData[dayIterator].minTemp)) + " ℃"
        windVelTextField.text = String(round2(value: weatherData[dayIterator].windSpeed)) + " m/s"
        windDirTextField.text = weatherData[dayIterator].windDirectionCompass
        rainfallTextField.text = rainingStates.contains(weatherData[dayIterator].weatherStateAbbr) ? "Raining" : "No rain"
        pressureTextField.text = String(round2(value: weatherData[dayIterator].airPressure)) + " psi"
        
    }
    
    private func round2(value: Double) -> Double {
        return Double(round(value * 100) / 100)
    }
    
    @IBAction func nextDate(_ sender: Any) {
        changeDate(day: 1)
    }
    
    @IBAction func prevDate(_ sender: Any) {
        changeDate(day: -1)
    }
    
    @IBAction func displayMapButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController")
        
        self.present(controller, animated: true, completion: nil)
    }
}

