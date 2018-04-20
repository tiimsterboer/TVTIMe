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
    var detailList : [TVShow] = []
    var name : String = ""
    
    @IBOutlet weak var simShowsTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomTableViewCell
        
        myCell.cellName.text = simShows[indexPath.row].name
        do {
            let data = try Data(contentsOf: simShows[indexPath.row].imageURL!)
            myCell.cellImage.image = UIImage(data: data)
        }
        catch let err {
            print("error : \(err.localizedDescription)")
        }
        return myCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you chose a show \(indexPath.row)")
        detailList.append(simShows[indexPath.row])
        self.performSegue(withIdentifier: "backToDetail", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.simShowsTable.rowHeight = 100
        simShowsTable.delegate = self
        simShowsTable.dataSource = self
        nameLabel.text = "Here are shows similar to \(name)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToDetail" {
            
            guard let DetailViewVC = segue.destination as? DetailViewVC else {return}
            DetailViewVC.showDetail = self.detailList
            //DetailViewVC.tvShows = self.tvShows
            //DetailViewVC.genreGroups = self.genreGroups
            //DetailViewVC.userQueue = self.userQueue
        }
    }
    
    
}
