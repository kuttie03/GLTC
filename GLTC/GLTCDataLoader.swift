//
//  GLTCDataLoader.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/20/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit
import Alamofire

class GLTCDataLoader {
    
    //Singleton
    static let sharedInstance = GLTCDataLoader()
    
    private var events: [GLTCEvent] = []
    private var committees: [GLTCCommittee] = []
    private var sponsors: [GLTCSponsor] = []
    private var news: Dictionary<Int, GLTCNews> = [:]
    private var videos: [GLTCVideo] = []
    
    private init() {
        
    }
    
    func getEvents() -> [GLTCEvent] {
        return self.events
    }
    
    func getCommittees() -> [GLTCCommittee] {
        return self.committees
    }
    
    func getSponsors() -> [GLTCSponsor] {
        return self.sponsors
    }
    
    func getNews() -> Dictionary<Int, GLTCNews> {
        return self.news
    }
    
    func getVideos() -> [GLTCVideo] {
        return self.videos
    }
    
    //Synchronous JSON retrieval
    func loadGLTCJson(refresh: Bool) {
        if(events.isEmpty || committees.isEmpty || sponsors.isEmpty || news.isEmpty || videos.isEmpty || refresh){
            print("Loading data from the server")
            let url = NSURL(string: GLTC_JSON_URL)
            /*let authCredentials = "username=GLTC&password=GLTC"
            let authCrdentialsData = authCredentials.dataUsingEncoding(NSUTF8StringEncoding)
            let base64EncodedCredentials = authCrdentialsData?.base64EncodedDataWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            let request = NSMutableURLRequest(URL: url!)
            request.setValue("Basic \(base64EncodedCredentials)", forHTTPHeaderField: "Authorization")
            request.HTTPMethod = "GET"
            //var response:<#T##AutoreleasingUnsafeMutablePointer<NSURLResponse?>#>= nil
            do{
            let data1: NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
            print(NSString(data: data1, encoding: NSUTF8StringEncoding))
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data1, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                print(jsonDictionary)
            }catch let err as NSError {
                print(err.debugDescription)
            }*/
            
            
            if let data = NSData(contentsOfURL: url!){
                do {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                    if let dict = jsonDictionary as? Dictionary<String, AnyObject> {
                        emptyContent()
                        if let eventsDict = dict["events"] as? [Dictionary<String, String>] where eventsDict.count > 0 {
                            for eventDict in eventsDict {
                                let event = GLTCEvent()
                                for (key, value) in eventDict {
                                    if(key == "imageUrl"){
                                        event.setImageUrl(value)
                                    }
                                }
                                self.events.append(event)
                            }
                        }
                        
                        if let committeesDict = dict["committees"] as? [Dictionary<String, AnyObject>]  where committeesDict.count > 0 {
                            for committeeDict in committeesDict {
                                let committee = GLTCCommittee()
                                for (key, value) in committeeDict {
                                    if(key == "name"){
                                        committee.setName(value as! String)
                                    }else if(key == "members"){
                                        if let membersDict = value as? [Dictionary<String, String>] where membersDict.count > 0{
                                            var members = [GLTCCommitteeMember]()
                                            for memberDict in membersDict {
                                                let member = GLTCCommitteeMember()
                                                for (key, value) in memberDict {
                                                    if(key == "name"){
                                                        member.setName(value)
                                                    }else if(key == "title"){
                                                        member.setTitle(value)
                                                    }else if(key == "imageUrl"){
                                                        member.setImageUrl(value)
                                                    }
                                                }
                                                members.append(member)
                                            }
                                            committee.setMembers(members)
                                        }
                                    }
                                }
                                self.committees.append(committee)
                            }
                        }
                        
                        if let sponsorsDict = dict["sponsors"] as? [Dictionary<String, String>]  where sponsorsDict.count > 0 {
                            for sponsorDict in sponsorsDict {
                                let sponsor = GLTCSponsor()
                                for (key, value) in sponsorDict {
                                    if(key == "name") {
                                        sponsor.setName(value)
                                    }else if(key == "imageUrl"){
                                        sponsor.setImageUrl(value)
                                    }
                                }
                                self.sponsors.append(sponsor)
                            }
                        }
                        
                        if let newsDict = dict["news"] as? [Dictionary<String, String>]  where newsDict.count > 0 {
                            for newDict in newsDict {
                                let news = GLTCNews()
                                for (key, value) in newDict {
                                    if(key == "newsId"){
                                        news.setNewsId(Int(value)!)
                                    }else if(key == "newsDate"){
                                        news.setNewsDate(value)
                                    }else if(key == "newsHeadline") {
                                        news.setNewsHeadline(value)
                                    }else if(key == "newsText") {
                                        news.setNewsText(value)
                                    }else if(key == "imageUrl") {
                                        news.setImageUrl(value)
                                    }
                                }
                                self.news[news.getNewsId()] = news
                            }
                        }
                        
                        if let videosDict = dict["videos"] as? [Dictionary<String, String>]  where videosDict.count > 0 {
                            for videoDict in videosDict {
                                let video = GLTCVideo()
                                for (key, value) in videoDict {
                                    if(key == "videoName"){
                                        video.setVideoName(value)
                                    }else if(key == "videoUrl") {
                                        video.setVideoUrl(value)
                                    }
                                }
                                self.videos.append(video)
                            }
                        }
                    }
                }catch let err as NSError {
                    print(err.debugDescription)
                }
            }else{
                print("Unable to retrieve data from the server")
            }
        }else{
            print("Content Exists - No need to load data from the server")
        }
    }
    
    //Asynchronous JSON retrieval
    /*func loadGLTCJson() {
        emptyContent()
        Alamofire.request(.GET, GLTC_JSON_URL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let eventsDict = dict["events"] as? [Dictionary<String, String>] where eventsDict.count > 0 {
                    for eventDict in eventsDict {
                        let event = GLTCEvent()
                        for (key, value) in eventDict {
                            if(key == "imageUrl"){
                                event.setImageUrl(value)
                            }
                        }
                        self.events.append(event)
                    }
                }
                
                if let committeesDict = dict["committees"] as? [Dictionary<String, AnyObject>]  where committeesDict.count > 0 {
                    for committeeDict in committeesDict {
                        let committee = GLTCCommittee()
                        for (key, value) in committeeDict {
                            if(key == "name"){
                                committee.setName(value as! String)
                            }else if(key == "members"){
                                if let membersDict = value as? [Dictionary<String, String>] where membersDict.count > 0{
                                    var members = [GLTCCommitteeMember]()
                                    for memberDict in membersDict {
                                        let member = GLTCCommitteeMember()
                                        for (key, value) in memberDict {
                                            if(key == "name"){
                                                member.setName(value)
                                            }else if(key == "title"){
                                                member.setTitle(value)
                                            }else if(key == "imageUrl"){
                                                member.setImageUrl(value)
                                            }
                                        }
                                        members.append(member)
                                    }
                                    committee.setMembers(members)
                                }
                            }
                        }
                        self.committees.append(committee)
                    }
                }
                
                if let sponsorsDict = dict["sponsors"] as? [Dictionary<String, String>]  where sponsorsDict.count > 0 {
                    for sponsorDict in sponsorsDict {
                        let sponsor = GLTCSponsor()
                        for (key, value) in sponsorDict {
                            if(key == "name") {
                                sponsor.setName(value)
                            }else if(key == "imageUrl"){
                                sponsor.setImageUrl(value)
                            }
                        }
                        self.sponsors.append(sponsor)
                    }
                }
                
                if let newsDict = dict["news"] as? [Dictionary<String, String>]  where newsDict.count > 0 {
                    for newDict in newsDict {
                        let news = GLTCNews()
                        for (key, value) in newDict {
                            if(key == "newsDate"){
                                news.setNewsDate(value)
                            }else if(key == "newsText") {
                                news.setNewsText(value)
                            }else if(key == "imageUrl") {
                                news.setImageUrl(value)
                            }
                        }
                        self.news.append(news)
                    }
                }
                
                if let videosDict = dict["videos"] as? [Dictionary<String, String>]  where videosDict.count > 0 {
                    for videoDict in videosDict {
                        let video = GLTCVideo()
                        for (key, value) in videoDict {
                            if(key == "videoName"){
                                video.setVideoName(value)
                            }else if(key == "videoUrl") {
                                video.setVideoUrl(value)
                            }
                        }
                        self.videos.append(video)
                    }
                }
            }
        }
    }*/
    
    func emptyContent() {
        print("Emptying Content before loading")
        events = []
        committees = []
        sponsors = []
        news = [:]
        videos = []
    }
}
