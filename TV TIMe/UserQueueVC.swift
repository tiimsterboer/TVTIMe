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
    var userQueue : [TVShow] = []
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
    
    override func viewDidLoad() {
        super .viewDidLoad()
        //userQueue.append(showsList[0])
        userQueueTV.delegate = self
        userQueueTV.dataSource = self
        self.userQueueTV.rowHeight = 100
    }
    
}
