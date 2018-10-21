//
//  ViewController.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 21/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


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
    @IBOutlet weak var nextBtn: UIButton!
    var date = Date()
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        bootstrap()
    }
    
    func bootstrap() {
        dateLabel.text = date.description
    }

    
    func changeDate(day: Int) {
        date = calendar.date(byAdding: .day, value: day, to: date)!
    }
    
    
    

    @IBAction func nextDate(_ sender: Any) {
        changeDate(day: 1)
        dateLabel.text = date.description
    }
    
    @IBAction func prevDate(_ sender: Any) {
        changeDate(day: -1)
        dateLabel.text = date.description
    }
}

