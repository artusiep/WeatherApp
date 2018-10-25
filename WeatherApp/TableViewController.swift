//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 23/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation
import UIKit


public struct CityForecast {
    var woeid: Int
    var forecast: Forecast?
}

let knownWhoeids = [2487956, 44418, 523920]

var cityForecasts = [CityForecast]()
var myIndex = 0

class TableViewController: UITableViewController {
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        for whoeid in knownWhoeids {
            viewModel.getResults(woeid: whoeid, completion: { forecast in
                let cityForecast = CityForecast(woeid: whoeid, forecast: forecast)
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
        cell.textLabel?.text = cityForecasts[indexPath.row].forecast?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        myIndex = indexPath.row
        performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
}

