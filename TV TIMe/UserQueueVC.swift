//
//  UserQueueVC.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 4/19/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import Foundation
import UIKit

class UserQueueVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tvShows: [TVShow] = []
    var userQueue: [TVShow] = []
    //var showsList: [TVShow] = []
    var detailList: [TVShow] = []
    var genreGroups: [String: [TVShow]] = [:]
    
    @IBOutlet weak var userQueueTV : UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userQueue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomTableViewCell
        
        myCell.queueName.text = userQueue[indexPath.row].name
        do {
            let data = try Data(contentsOf: userQueue[indexPath.row].imageURL!)
            myCell.queueImg.image = UIImage(data: data)
        }
        catch let err {
            print("error : \(err.localizedDescription)")
        }
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you chose a show \(indexPath.row)")
        detailList = []
        detailList.append(userQueue[indexPath.row])
        self.performSegue(withIdentifier: "queueToDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        userQueue.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        NSKeyedArchiver.archiveRootObject(userQueue, toFile: TVShow.ArchiveURL2.path)
    }
    /*func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = userQueue[sourceIndexPath.row]
        userQueue.remove(at: sourceIndexPath.row)
        userQueue.insert(item, at: destinationIndexPath.row)
        userQueueTV.reloadData()
    }*/
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        //userQueue.append(showsList[0])
        userQueueTV.delegate = self
        userQueueTV.dataSource = self
        userQueueTV.rowHeight = 100
        //userQueueTV.setEditing(true, animated: true)
        userQueueTV.backgroundColor = UIColor.darkGray
        userQueueTV.backgroundView  = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "queueToDetail" {
            
            guard let DetailViewVC = segue.destination as? DetailViewVC else {return}
            DetailViewVC.showDetail = self.detailList
            DetailViewVC.tvShows = self.tvShows
            DetailViewVC.genreGroups = self.genreGroups
            DetailViewVC.userQueue = self.userQueue
            //DetailViewVC.searchList = self.showsList
        }
    }
    
 }

