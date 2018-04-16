//
//  SimShowsVC.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 4/15/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import Foundation
import UIKit

class SimShowsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var simShows : [TVShow] = []
    var name : String = ""
    
    @IBOutlet weak var simShowsTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        myCell.textLabel?.text = simShows[indexPath.row].name
        return myCell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simShowsTable.delegate = self
        simShowsTable.dataSource = self
        nameLabel.text = "Here are shows similar to \(name)"
    }
    
    
}
