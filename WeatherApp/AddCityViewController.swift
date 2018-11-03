//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 26/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddCityViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource  {
    private let viewModel = ViewModel()

    private var cities: Cities = []
    @IBOutlet weak var addCityTextField: UITextField!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    var locManager = CLLocationManager()
    var geoCoder = CLGeocoder()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: locValue) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.currentLocationLabel.text = "You are in: \(city), \(country)"
        }
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    @IBAction func findButtonAccion(_ sender: Any) {
        print(addCityTextField.text!)
        let cityQuery = addCityTextField.text ?? ""
        viewModel.getCities(query: cityQuery, completion: { [weak self] response in
            self?.cities = response
            self?.tableView.reloadData()
        })
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
