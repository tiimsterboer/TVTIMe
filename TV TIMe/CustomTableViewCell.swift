//
//  CustomTableViewCell.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 4/15/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellView2: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellsearchImg: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellSearchName: UILabel!
    
    @IBOutlet weak var cellView3: UIView!
    @IBOutlet weak var queueImg: UIImageView!
    
    @IBOutlet weak var queueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
