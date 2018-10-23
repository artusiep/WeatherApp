//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Artur Siepietowski on 23/10/2018.
//  Copyright © 2018 Artur Siepietowski. All rights reserved.
//

import Foundation
import UIKit


class TableViewController: UITableViewController {
    private let viewModel = ViewModel()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        performSegue(withIdentifier: "MamaMacka", sender: nil)
    }
}

