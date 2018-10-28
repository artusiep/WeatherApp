//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 26/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation
import UIKit

class AddCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let viewModel = ViewModel()

    private var cities: Cities = []
    @IBOutlet weak var addCityTextField: UITextField!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func findButtonAccion(_ sender: Any) {
        print(addCityTextField.text!)
        let cityQuery = addCityTextField.text ?? ""
        viewModel.getCities(query: cityQuery, completion: { [weak self] response in
            self?.cities = response
            self?.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QueryCell", for: indexPath)
        let city = cities[indexPath.row].title
        cell.textLabel?.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        let chosenCityWhoeid = cities[indexPath.row].woeid
        if(!woeidsWithForecast.contains(chosenCityWhoeid)) {
            woeidsToFetchData.append(cities[indexPath.row].woeid)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
