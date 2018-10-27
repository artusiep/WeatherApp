//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 23/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation
import UIKit


public struct CityForecast: Equatable {
    public static func == (lhs: CityForecast, rhs: CityForecast) -> Bool {
        return lhs.woeid == rhs.woeid
    }
    
    var woeid: Int
    var forecast: Forecast?
}

var woeidsToFetchData = [2487956, 44418, 523920]
var woeidsWithForecast: [Int] = []

var cityForecasts = [CityForecast]()
var myIndex = 0

class TableViewController: UITableViewController {
    private let viewModel = ViewModel()
    @IBOutlet weak var signature: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecastFromApi()
    }
    
    func getForecastFromApi() {
        for whoeid in woeidsToFetchData {
            viewModel.getResults(woeid: whoeid, completion: { forecast in
                let cityForecast = CityForecast(woeid: whoeid, forecast: forecast)
                woeidsWithForecast.append(whoeid)
                woeidsToFetchData = woeidsToFetchData.filter { element in
                    return !woeidsWithForecast.contains(element)
                }
                cityForecasts.append(cityForecast)
                self.tableView.reloadData()
            })
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityForecasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentWeather = cityForecasts[indexPath.row].forecast?.consolidatedWeather.first
        cell.textLabel?.text = cityForecasts[indexPath.row].forecast?.title
        cell.imageView?.image = UIImage(named: (currentWeather?.weatherStateAbbr)!)
        cell.detailTextLabel?.text = String(Double(round((currentWeather?.theTemp)! * 100) / 100)) + " ℃"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        myIndex = indexPath.row
        performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
}

