//
//  PlacesTableViewController.swift
//  Memorable Places
//
//  Created by 李宝明 on 16/8/24.
//  Copyright © 2016年 李宝明. All rights reserved.
//

import UIKit

var places = [Dictionary<String,String>()]
var activePlaces = -1

class PlacesTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    
    }

    override func viewDidAppear(_ animated: Bool) {
        if places.count == 1 && places[0].count == 0 {
            
            places.remove(at: 0)
            places.append(["name":"Taj Mahal","lat":"27.1","lon":"78.04"])
            
            
        }
        
        activePlaces = -1
        
        table.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")

        if let name = places[indexPath.row]["name"] {
            cell.textLabel?.text = name

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMap", sender: nil)
        activePlaces = indexPath.row
    }
    


}
