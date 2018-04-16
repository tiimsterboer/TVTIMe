//
//  SearchResultsVC.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 3/14/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit

class SearchResultsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tvShows: [TVShow] = []
    var showsList: [TVShow] = []
    var detailList: [TVShow] = []
    var genreGroups: [String: [TVShow]] = [:]
    var name = ""
    @IBOutlet weak var showsTableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let protoCell = tableView.dequeueReusableCell(withIdentifier: "protoCell") as! CustomTableViewCell
        protoCell.cellSearchName.text = showsList[indexPath.row].name
        do {
            let data = try Data(contentsOf: showsList[indexPath.row].imageURL!)
            protoCell.cellsearchImg.image = UIImage(data: data)
        }
        catch let err {
            print("error : \(err.localizedDescription)")
        }
        return protoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you chose a show \(indexPath.row)")
        detailList.append(showsList[indexPath.row])
        self.performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        showsTableView.delegate = self
        showsTableView.dataSource = self
        self.showsTableView.rowHeight = 100
        
        for show in showsList {
            print("\(show.name) \(show.genres)" )
            
        }
        print("this is from the 2nd page")
        print(showsList.count)
        print(tvShows.count)
        nameLabel.text = "Shows that match \(name)"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
           
            guard let DetailViewVC = segue.destination as? DetailViewVC else {return}
            DetailViewVC.showDetail = self.detailList
            DetailViewVC.tvShows = self.tvShows
            DetailViewVC.genreGroups = self.genreGroups
        }
    }
    @IBAction func didUnwindFromDetailViewVC (_ sender: UIStoryboardSegue) {
        detailList = []
    
    }
}
