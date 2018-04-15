//
//  DetailViewVC.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 3/16/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import Foundation
import UIKit

class DetailViewVC: UIViewController {
    
    var showDetail : [TVShow] = []
    var tvShows : [TVShow] = []
    var genreGroups: [String: [TVShow]] = [:]
    
    @IBOutlet weak var resultsLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var showImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let showSumm = showDetail[0].summary.removeTags(txt: showDetail[0].summary)
        detailLabel.text = showSumm
        nameLbl.text = showDetail[0].name
        //genresLbl.text = showDetail[0].genres
        do {
            let data = try Data(contentsOf: showDetail[0].imageURL!)
            self.showImg.image = UIImage(data: data)
        }
        catch let err {
                print("error : \(err.localizedDescription)")
        }
        //print(tvShows.count)
        print(testDict)
        for key in genreGroups.keys {
            print("\(key) : \(genreGroups[key]!.count)")
        }
        
    }
    
    @IBAction func findSimShows(_ sender: Any) {
        //var topMatches = Dictionary<String, Double>()
        var sim = [0.0, 0.0, 0.0]
        var tS = ["", "", ""]
        var rands : [Int] = []
        
        if genreGroups[showDetail[0].genres[0]]!.count > 200 {
            rands =  CosSim.makeList(forLowerBound: 0, andUpperBound: genreGroups[showDetail[0].genres[0]]!.count, andNumNumbers: 200)
            
        }
        print(rands)
        if showDetail[0].genres.count > 0 {
            print(true)
            print(showDetail[0].genres.count)
        }
        
        //Keep This Portion and update it!
        
        for x in rands {
            let cos = CosSim.cosSim(wordBag: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[showDetail[0].genres[0]]![x].summary).wordBag, freq1: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[showDetail[0].genres[0]]![x].summary).freq1, freq2: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[showDetail[0].genres[0]]![x].summary).freq2)
            if cos > sim[0] {
                sim[2] = sim[1]
                tS[2] = tS[1]
                sim[1] = sim[0]
                tS[1] = tS[0]
                sim[0] = cos
                tS[0] = genreGroups[showDetail[0].genres[0]]![x].name
            }
            else if cos > sim[1] {
                sim[2] = sim[1]
                tS[2] = tS[1]
                sim[1] = cos
                tS[1] = genreGroups[showDetail[0].genres[0]]![x].name
            }
            else if cos > sim[2] {
                sim[2] = cos
                tS[2] = genreGroups[showDetail[0].genres[0]]![x].name
        }
    }
        
        print(sim)
        print(tS)
            
}
    


}
