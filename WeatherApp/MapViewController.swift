//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 30/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var weatherMap: MKMapView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var backButton: UIButton!
    private var locationManager: CLLocationManager!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let (latt, long) = getLatLon(cityForecasts[myIndex].forecast?.lattLong)
        cityName.text = cityForecasts[myIndex].forecast?.title
        displayMapOnLocation(latt: latt, long: long)
        markCity(latt: latt, long: long)
    }
    
    func markCity(latt: Double, long: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latt, longitude: long)
        weatherMap.addAnnotation(annotation)
    }
    
    func displayMapOnLocation(latt: Double, long: Double) {
        let center = CLLocationCoordinate2D(latitude: latt, longitude: long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.weatherMap.setRegion(region, animated: true)
    }
    
    func getLatLon(_ coordString: String?) -> (Double, Double) {
        let coordArr = coordString?.replacingOccurrences(of: " ", with: "").components(separatedBy: ",")
        let latt = Double(coordArr![0])
        let long = Double(coordArr![1])
        return (latt!, long!)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
