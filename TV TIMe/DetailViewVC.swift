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
    var tS :[TVShow] = []
    var genTxt = " "
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var showImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let showSumm = showDetail[0].summary.removeTags(txt: showDetail[0].summary)
        detailLabel.text = showSumm
        nameLbl.text = showDetail[0].name
        
        do {
            let data = try Data(contentsOf: showDetail[0].imageURL!)
            self.showImg.image = UIImage(data: data)
        }
        catch let err {
                print("error : \(err.localizedDescription)")
        }
        //print(tvShows.count)
        print(testDict)
        for gen in showDetail[0].genres {
            genTxt += "- \(gen) - "
        }
        genresLbl.text = genTxt
        
        for key in genreGroups.keys {
            print("\(key) : \(genreGroups[key]!.count)")
        }
        
    }
    
    @IBAction func findSimShows(_ sender: Any) {
        //var topMatches = Dictionary<String, Double>()
        var sim = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        var rands : [Int] = []
        tS = [showDetail[0], showDetail [0], showDetail[0],showDetail[0], showDetail [0], showDetail[0],showDetail[0], showDetail [0], showDetail[0], showDetail[0]]
        
        
        if showDetail[0].genres == [] {
            rands =  CosSim.makeList(forLowerBound: 0, andUpperBound: (genreGroups[""]?.count)!, andNumNumbers: 200)
            
            for x in rands {
                let cos = CosSim.cosSim(wordBag: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).wordBag, freq1: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).freq1, freq2: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).freq2)
                if cos > sim[0] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = sim[7]
                    tS[8] = tS[7]
                    sim[7] = sim[6]
                    tS[7] = tS[6]
                    sim[6] = sim[5]
                    tS[6] = tS[5]
                    sim[5] = sim[4]
                    tS[5] = tS[4]
                    sim[4] = sim[3]
                    tS[4] = tS[3]
                    sim[3] = sim[2]
                    tS[3] = tS[2]
                    sim[2] = sim[1]
                    tS[2] = tS[1]
                    sim[1] = sim[0]
                    tS[1] = tS[0]
                    sim[0] = cos
                    tS[0] = tvShows[x]
                }
                else if cos > sim[1] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = sim[7]
                    tS[8] = tS[7]
                    sim[7] = sim[6]
                    tS[7] = tS[6]
                    sim[6] = sim[5]
                    tS[6] = tS[5]
                    sim[5] = sim[4]
                    tS[5] = tS[4]
                    sim[4] = sim[3]
                    tS[4] = tS[3]
                    sim[3] = sim[2]
                    tS[3] = tS[2]
                    sim[2] = sim[1]
                    tS[2] = tS[1]
                    sim[1] = cos
                    tS[1] = tvShows[x]
                }
                else if cos > sim[2] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = sim[7]
                    tS[8] = tS[7]
                    sim[7] = sim[6]
                    tS[7] = tS[6]
                    sim[6] = sim[5]
                    tS[6] = tS[5]
                    sim[5] = sim[4]
                    tS[5] = tS[4]
                    sim[4] = sim[3]
                    tS[4] = tS[3]
                    sim[3] = sim[2]
                    tS[3] = tS[2]
                    sim[2] = cos
                    tS[2] = tvShows[x]
                }
                else if cos > sim[3] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = sim[7]
                    tS[8] = tS[7]
                    sim[7] = sim[6]
                    tS[7] = tS[6]
                    sim[6] = sim[5]
                    tS[6] = tS[5]
                    sim[5] = sim[4]
                    tS[5] = tS[4]
                    sim[4] = sim[3]
                    tS[4] = tS[3]
                    sim[3] = cos
                    tS[3] = tvShows[x]
                }
                else if cos > sim[4] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = sim[7]
                    tS[8] = tS[7]
                    sim[7] = sim[6]
                    tS[7] = tS[6]
                    sim[6] = sim[5]
                    tS[6] = tS[5]
                    sim[5] = sim[4]
                    tS[5] = tS[4]
                    sim[4] = cos
                    tS[4] = tvShows[x]
                }
                else if cos > sim[5] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = sim[7]
                    tS[8] = tS[7]
                    sim[7] = sim[6]
                    tS[7] = tS[6]
                    sim[6] = sim[5]
                    tS[6] = tS[5]
                    sim[5] = cos
                    tS[5] = tvShows[x]
                }
                else if cos > sim[6] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = sim[7]
                    tS[8] = tS[7]
                    sim[7] = sim[6]
                    tS[7] = tS[6]
                    sim[6] = cos
                    tS[6] = tvShows[x]
                }
                else if cos > sim[7] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = sim[7]
                    tS[8] = tS[7]
                    sim[7] = cos
                    tS[7] = tvShows[x]
                }
                else if cos > sim[8] {
                    sim[9] = sim[8]
                    tS[9] = tS[8]
                    sim[8] = cos
                    tS[8] = tvShows[x]
                }
                else if cos > sim[9] {
                    sim[9] = cos
                    tS[9] = tvShows[x]
                }
            }
        }
        else if showDetail[0].genres.count > 0 {
            let perEach = 204 / showDetail[0].genres.count
            print(perEach)
            for gen in showDetail[0].genres {
                print(gen)
                if (genreGroups[gen]?.count)! > perEach {
                    print(genreGroups[gen]!.count)
                    rands = CosSim.makeList(forLowerBound: 0, andUpperBound: (genreGroups[gen]?.count)!, andNumNumbers: perEach)
                    print(rands)
                    for x in rands {
                        let cos = CosSim.cosSim(wordBag: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[gen]![x].summary).wordBag, freq1: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[gen]![x].summary).freq1, freq2: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[gen]![x].summary).freq2)
                        if cos > sim[0] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = sim[3]
                            tS[4] = tS[3]
                            sim[3] = sim[2]
                            tS[3] = tS[2]
                            sim[2] = sim[1]
                            tS[2] = tS[1]
                            sim[1] = sim[0]
                            tS[1] = tS[0]
                            sim[0] = cos
                            tS[0] = genreGroups[gen]![x]
                        }
                        else if cos > sim[1] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = sim[3]
                            tS[4] = tS[3]
                            sim[3] = sim[2]
                            tS[3] = tS[2]
                            sim[2] = sim[1]
                            tS[2] = tS[1]
                            sim[1] = cos
                            tS[1] = genreGroups[gen]![x]
                        }
                        else if cos > sim[2] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = sim[3]
                            tS[4] = tS[3]
                            sim[3] = sim[2]
                            tS[3] = tS[2]
                            sim[2] = cos
                            tS[2] = genreGroups[gen]![x]
                        }
                        else if cos > sim[3] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = sim[3]
                            tS[4] = tS[3]
                            sim[3] = cos
                            tS[3] = genreGroups[gen]![x]
                        }
                        else if cos > sim[4] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = cos
                            tS[4] = genreGroups[gen]![x]
                        }
                        else if cos > sim[5] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = cos
                            tS[5] = genreGroups[gen]![x]
                        }
                        else if cos > sim[6] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = cos
                            tS[6] = genreGroups[gen]![x]
                        }
                        else if cos > sim[7] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = cos
                            tS[7] = genreGroups[gen]![x]
                        }
                        else if cos > sim[8] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = cos
                            tS[8] = genreGroups[gen]![x]
                        }
                        else if cos > sim[9] {
                            sim[9] = cos
                            tS[9] = genreGroups[gen]![x]
                        }
                    }
                }
                else {
                    for x in genreGroups[gen]! {
                        let cos = CosSim.cosSim(wordBag: CosSim.wordCount(r: showDetail[0].summary, s: x.summary).wordBag, freq1: CosSim.wordCount(r: showDetail[0].summary, s: x.summary).freq1, freq2: CosSim.wordCount(r: showDetail[0].summary, s: x.summary).freq2)
                        if cos > sim[0] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = sim[3]
                            tS[4] = tS[3]
                            sim[3] = sim[2]
                            tS[3] = tS[2]
                            sim[2] = sim[1]
                            tS[2] = tS[1]
                            sim[1] = sim[0]
                            tS[1] = tS[0]
                            sim[0] = cos
                            tS[0] = x
                        }
                        else if cos > sim[1] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = sim[3]
                            tS[4] = tS[3]
                            sim[3] = sim[2]
                            tS[3] = tS[2]
                            sim[2] = sim[1]
                            tS[2] = tS[1]
                            sim[1] = cos
                            tS[1] = x
                        }
                        else if cos > sim[2] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = sim[3]
                            tS[4] = tS[3]
                            sim[3] = sim[2]
                            tS[3] = tS[2]
                            sim[2] = cos
                            tS[2] = x
                        }
                        else if cos > sim[3] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = sim[3]
                            tS[4] = tS[3]
                            sim[3] = cos
                            tS[3] = x
                        }
                        else if cos > sim[4] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = sim[4]
                            tS[5] = tS[4]
                            sim[4] = cos
                            tS[4] = x
                        }
                        else if cos > sim[5] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = sim[5]
                            tS[6] = tS[5]
                            sim[5] = cos
                            tS[5] = x
                        }
                        else if cos > sim[6] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = sim[6]
                            tS[7] = tS[6]
                            sim[6] = cos
                            tS[6] = x
                        }
                        else if cos > sim[7] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = sim[7]
                            tS[8] = tS[7]
                            sim[7] = cos
                            tS[7] = x
                        }
                        else if cos > sim[8] {
                            sim[9] = sim[8]
                            tS[9] = tS[8]
                            sim[8] = cos
                            tS[8] = x
                        }
                        else if cos > sim[9] {
                            sim[9] = cos
                            tS[9] = x
                        }
                    }
                }
                
            }
        }
        /*if genreGroups[showDetail[0].genres[0]]!.count > 200 {
            rands =  CosSim.makeList(forLowerBound: 0, andUpperBound: genreGroups[showDetail[0].genres[0]]!.count, andNumNumbers: 200)
            
        }
        print(rands)
        if showDetail[0].genres.count > 0 {
            print(true)
            print(showDetail[0].genres.count)
        }*/
        
        //Keep This Portion and update it!
        
       /* for x in rands {
            let cos = CosSim.cosSim(wordBag: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[showDetail[0].genres[0]]![x].summary).wordBag, freq1: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[showDetail[0].genres[0]]![x].summary).freq1, freq2: CosSim.wordCount(r: showDetail[0].summary, s: genreGroups[showDetail[0].genres[0]]![x].summary).freq2)
            if cos > sim[0] {
                sim[2] = sim[1]
                tS[2] = tS[1]
                sim[1] = sim[0]
                tS[1] = tS[0]
                sim[0] = cos
                tS[0] = genreGroups[showDetail[0].genres[0]]![x]
            }
            else if cos > sim[1] {
                sim[2] = sim[1]
                tS[2] = tS[1]
                sim[1] = cos
                tS[1] = genreGroups[showDetail[0].genres[0]]![x]
            }
            else if cos > sim[2] {
                sim[2] = cos
                tS[2] = genreGroups[showDetail[0].genres[0]]![x]
        }
    }*/
        
        print(sim)
        for show in tS {
            print("\(show.name) \(show.genres)")
        }
        
        testQueue.append("Tim")
        print(testQueue)
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "simSegue" {
            guard let SimShowsVC = segue.destination as? SimShowsVC else {return}
            SimShowsVC.simShows = self.tS
            SimShowsVC.name = self.showDetail[0].name
            //SearchResultsVC.tvShows = self.tvShows
            //SearchResultsVC.genreGroups = self.genreGroups
            //print(searchShows.count)
            //print(SearchResultsVC.showsList.count)
        }
    }
    @IBAction func didUnwindFromSimShowsVC(_ sender: UIStoryboardSegue) {
        guard let simShowVc = sender.source as? SimShowsVC else {return}
    }


}
