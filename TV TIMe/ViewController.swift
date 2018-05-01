//
//  ViewController.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 2/26/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyJSON
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
    
    @IBOutlet weak var loadingView: UIImageView!
    
    @IBOutlet weak var loadingMessage: UILabel!
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    @IBOutlet weak var loadingTitle: UILabel!
    @IBOutlet weak var loadingTV: UIImageView!
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
        print(launch)
        
        genrePicker.delegate = self
        genrePicker.dataSource = self
        
        //UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        
        //activityIndicator.center = self.view.center
        //activityIndicator.hidesWhenStopped = true
        //activityIndicator.activityIndicatorViewStyle = .gray
        //self.view.addSubview(activityIndicator)
        loadingWheel.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.global(qos:.userInteractive).async {
            if firstLaunch {
                self.saveShows()
                print("shows loaded")
                DispatchQueue.main.async {
                    self.loadingView.isHidden = true
                    self.loadingTV.isHidden = true
                    self.loadingWheel.isHidden = true
                    self.loadingTitle.isHidden = true
                    self.loadingWheel.stopAnimating()
                    self.loadingMessage.isHidden = true
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
            else {
                if let savedGenres = self.loadGenres(){
                    self.genreGroups = savedGenres
                }
                
                if let savedQueue = self.loadQueue(){
                    self.userQueue += savedQueue
                }
                if let savedShows = self.loadShows(){
                    self.tvShows += savedShows
                    
                    print("shows loaded")
                    DispatchQueue.main.async {
                        self.loadingView.isHidden = true
                        self.loadingTV.isHidden = true
                        self.loadingWheel.isHidden = true
                        self.loadingTitle.isHidden = true
                        self.loadingWheel.stopAnimating()
                        self.loadingMessage.isHidden = true
                        //self.loadingLbl.isHidden = true
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
        
     
    }
    
    

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
                
            }
        
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tvShows, toFile: TVShow.ArchiveURL.path)
            
            if isSuccessfulSave {
                os_log("Show saved", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed", log: OSLog.default, type: .error)
            }
        }
        getGenres()
        NSKeyedArchiver.archiveRootObject(genreGroups, toFile: TVShow.ArchiveURL3.path)
        NSKeyedArchiver.archiveRootObject(userQueue, toFile: TVShow.ArchiveURL2.path)
        
    }
    
    private func loadShows() -> [TVShow]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: TVShow.ArchiveURL.path) as? [TVShow]!
        
    }
    
    private func loadQueue() -> [TVShow]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: TVShow.ArchiveURL2.path) as? [TVShow]!
        
    }
    
    private func loadGenres() -> [String:[TVShow]]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: TVShow.ArchiveURL3.path) as? [String:[TVShow]]!
        
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
            if searchField.text != "" && gen != ""{
                SearchResultsVC.name = "\(searchField.text!) and \(gen)"
            }
            else if searchField.text == "" {
                SearchResultsVC.name = self.gen
            }
            else {
                SearchResultsVC.name = self.searchField.text!
            }
            
            SearchResultsVC.tvShows = self.tvShows
            SearchResultsVC.genreGroups = self.genreGroups
            SearchResultsVC.userQueue = self.userQueue
            print(searchShows.count)
            print(SearchResultsVC.showsList.count)
        }
        if segue.identifier == "userQueueSeg" {
            guard let UserQueueVC = segue.destination as? UserQueueVC else {return}
            UserQueueVC.userQueue = userQueue
            UserQueueVC.tvShows = self.tvShows
            UserQueueVC.genreGroups = self.genreGroups
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
    @IBAction func didUnWindFromDetailViewVCToHome(_ sender: UIStoryboardSegue) {
        guard let DetailViewVC = sender.source as? DetailViewVC else { return }
        userQueue = DetailViewVC.userQueue
    }
    
}
    



