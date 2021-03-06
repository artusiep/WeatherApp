//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 21/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation
import UIKit

public class ViewModel {
    func getResults(woeid: Int, completion: @escaping (Forecast) -> ()) {
        guard let url = URL(string: "https://www.metaweather.com/api/location/\(String(woeid))/") else {
            assertionFailure("URL init failed")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let forecast = try decoder.decode(Forecast.self, from: data)
                DispatchQueue.main.async {
                    completion(forecast)
                }
                
            } catch let error {
                print("Error: ", error)
            }
            }.resume()
    }
    
    func getCities(query: String, completion: @escaping (Cities) -> ()) {
        let urlString = "https://www.metaweather.com/api/location/search/?query=\(query.lowercased())"
        guard let url = URL(string: urlString) else {
            assertionFailure("URL init failed")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cities = try decoder.decode(Cities.self, from: data)
                DispatchQueue.main.async {
                    completion(cities)
                }
                
            } catch let error {
                print("Error: ", error)
            }
            }.resume()
    }
    
    func getClosestCities(coorQuery: String, completion: @escaping (Cities) -> ()) {
        let urlString = "https://www.metaweather.com/api/location/search/?lattlong=\(coorQuery)"
        guard let url = URL(string: urlString) else {
            assertionFailure("URL init failed")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cities = try decoder.decode(Cities.self, from: data)
                DispatchQueue.main.async {
                    completion(cities)
                }
                
            } catch let error {
                print("Error: ", error)
            }
            }.resume()
    }
}
