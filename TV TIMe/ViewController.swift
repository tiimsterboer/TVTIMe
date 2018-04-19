//
//  ViewController.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 2/26/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import os.log

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    
    var tvShows: [TVShow] = []
    var searchShows: [TVShow] = []
    var userQueue: [TVShow] = []
    //var genreGroups = [String:[TVShow]]()
    var genreGroups: [String:[TVShow]] = ["":[], "Action":[], "Adult":[], "Adventure":[], "Anime":[], "Children":[], "Comedy":[], "Crime":[], "DIY":[], "Drama":[], "Espionage":[], "Family":[], "Fantasy":[], "Food":[], "History":[], "Horror":[], "Legal":[], "Medical":[], "Music":[], "Mystery":[], "Nature":[], "Romance":[], "Science-Fiction":[], "Sports":[], "Supernatural":[], "Thriller":[], "Travel":[], "War":[], "Western":[]]
    var genres = ["", "Action", "Adult", "Adventure", "Anime", "Children", "Comedy", "Crime", "DIY", "Drama", "Espionage", "Family", "Fantasy", "Food", "History", "Horror", "Legal", "Medical", "Music", "Mystery", "Nature", "Romance", "Science-Fiction", "Sports", "Supernatural", "Thriller", "Travel", "War", "Western"]
    var myName = "Tim"
    var n = Int(arc4random_uniform(20367))
    var activityIndicator = UIActivityIndicatorView()
    var gen = ""

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var loadingLbl: UILabel!
    
    @IBOutlet weak var randShowImg: UIImageView!
    
    @IBOutlet weak var randShowName: UILabel!
    
    @IBOutlet weak var genrePicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gen = genres[row]
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: genres[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        return attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //queueTableView.delegate = self
        //queueTableView.dataSource = self
        genrePicker.delegate = self
        genrePicker.dataSource = self
        
        
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.global(qos:.userInteractive).async {
            if let savedShows = self.loadShows(){
                self.tvShows += savedShows
                print("shows loaded")
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.loadingLbl.isHidden = true
                    UIApplication.shared.endIgnoringInteractionEvents()
                    print(self.tvShows.count)
                    //self.searchField.becomeFirstResponder()
                    self.userQueue.append(self.tvShows[self.n])
                    print(self.userQueue[0].name)
                    self.randShowName.text = self.tvShows[self.n].name
                    do {
                        let data = try Data(contentsOf: self.tvShows[self.n].imageURL!)
                        self.randShowImg.image = UIImage(data: data)
                    }
                    catch let err {
                        print("error : \(err.localizedDescription)")
                    }
                    self.randShowName.isHidden = false
                    self.randShowImg.isHidden = false
                }
                    
            }
        }
        
     
    }
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userQueue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = userQueue[indexPath.row].name
        
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        queueTableView.reloadData()
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getData(_ sender: Any) {
        saveShows()
        }
    
    @IBAction func showData(_ sender: Any) {
        
        /*for show in tvShows {
            print (show.name)
            
        }*/
        print(tvShows.count)
        print(genreGroups)
        print(gen)
        getGenres()
    }
    
    @IBAction func search(_ sender: Any) {
        
        print("search pressed")
        
        
    }
    @IBAction func clear(_ sender: Any) {
        tvShows = []
    }
    private func searchTheShows() {
        searchShows = []
        print("works")
        print(searchField.text!)
        //var searchText = "Chicago"
        if gen == "" && searchField.text == "" {
            for show in tvShows{
                searchShows.append(show)
            }
        }
        if gen != "" {
            for show in genreGroups[gen]! {
                if searchField.text != "" {
                    if show.name.lowercased().contains(searchField.text!.lowercased()) {
                        searchShows.append(show)
                    }
                    
                }
                else {
                    searchShows.append(show)
                }
            }
        }
        else {
        for show in tvShows {
            if show.name.lowercased().contains(searchField.text!.lowercased()) {
                searchShows.append(show)
                //print(show.name)
                //print(show.imageURL ?? "default URL")
            }
                }
        }
        
        print(searchShows.count)
        
        }
    
    private func saveShows() {
        print("action works")
        
        
        
        for page in 0...139 {
            let webpage = "https://api.tvmaze.com/shows?page=\(page)"
            let url: NSURL = NSURL(string: webpage)!
            
            
            do {
                let data: Data = try! Data(contentsOf: url as URL)
                let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSMutableArray
                
                for jsonObject in jsonArray! {
                    if let show = TVShow(json: (jsonObject as AnyObject) as! [String : Any]) {
                        if show.language == "English" {
                            tvShows.append(show)
                        }
                        
                    }
                    if tvShows.count == 0 {
                        print("no shows parsed")
                    }
                    
                }
                print(tvShows.count)
                //print(tvShows[45].name)
               //print(tvShows[226].genres)
                //print(tvShows[137].summary)
            }
        
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tvShows, toFile: TVShow.ArchiveURL.path)
            
            if isSuccessfulSave {
                os_log("Show saved", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed", log: OSLog.default, type: .error)
            }
        }
        
        //NSKeyedArchiver.archiveRootObject(genreGroups, toFile: TVShow.ArchiveURL2.path)
        
    }
    
    private func loadShows() -> [TVShow]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: TVShow.ArchiveURL.path) as? [TVShow]!
        
    }
    private func getGenres() {
        for (key, _) in genreGroups {
            for show in tvShows {
                for genre in show.genres {
                    if key == genre {
                        genreGroups[key]?.append(show)
                    }
                    
                }
            }
            
            
            }
            for show in tvShows {
                if show.genres == [] {
                    genreGroups[""]?.append(show)
                }
            }
        }
        //return genreGroups

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            searchTheShows()
            //getGenres()
            guard let SearchResultsVC = segue.destination as? SearchResultsVC else {return}
            SearchResultsVC.showsList = self.searchShows
            SearchResultsVC.name = self.searchField.text!
            SearchResultsVC.tvShows = self.tvShows
            SearchResultsVC.genreGroups = self.genreGroups
            SearchResultsVC.userQueue = self.userQueue
            print(searchShows.count)
            print(SearchResultsVC.showsList.count)
        }
        if segue.identifier == "userQueueSeg" {
            guard let UserQueueVC = segue.destination as? UserQueueVC else {return}
            UserQueueVC.userQueue = userQueue
        }
    }
    
    
    @IBAction func didUnwindFromSearchResultsVC(_ sender: UIStoryboardSegue) {
        guard let SearchResultsVC = sender.source as? SearchResultsVC else { return }
        userQueue = SearchResultsVC.userQueue
        }
    @IBAction func didUnWindFromUserQueueVC(_ sender: UIStoryboardSegue) {
        guard let UserQueueVC = sender.source as? UserQueueVC else { return }
        userQueue = UserQueueVC.userQueue
    }
    
}
    



