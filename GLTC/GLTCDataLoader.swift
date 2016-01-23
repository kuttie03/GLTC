//
//  GLTCDataLoader.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/20/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class GLTCDataLoader {
    
    let EVENTS_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=eventsJson"
    let COMMITTEES_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=committeesJson"
    let SPONSORS_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=sponsorsJson"
    let NEWS_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=newsJson"
    
    //Singleton
    static let sharedInstance = GLTCDataLoader()
    
    private var events: [GLTCEvent] = []
    private var committees: [GLTCCommittee] = []
    private var sponsors: [GLTCSponsor] = []
    private var news: [GLTCNews] = []
    
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
    
    func getNews() -> [GLTCNews] {
        return self.news
    }
    
    func loadAllGLTCJson(){
        if(events.isEmpty || committees.isEmpty || sponsors.isEmpty || news.isEmpty) {
            print("Content Doesn't Exist - Loading Data from the server")
            emptyContent()
            loadJson("events")
            loadJson("committees")
            loadJson("sponsors")
            loadJson("news")
        }else{
            print("Content Exists - No need to Load Data from the server")
        }
    }
    
    func loadJson(type: String) {
        var urlString = ""
        if(type == "events"){
            urlString = EVENTS_JSON_URL
        }else if(type == "committees"){
            urlString = COMMITTEES_JSON_URL
        }else if(type == "sponsors"){
            urlString = SPONSORS_JSON_URL
        }else if(type == "news"){
            urlString = NEWS_JSON_URL
        }
        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                if(type == "events"){
                    self.extractEventsJsondata(data!)
                    print("Loaded Events")
                }else if(type == "committees"){
                    self.extractCommitteesJsondata(data!)
                    print("Loaded Committees")
                }else if(type == "sponsors"){
                    self.extractSponsorsJsondata(data!)
                    print("Loaded Sponsors")
                }else if(type == "news"){
                    self.extractNewsJsondata(data!)
                    print("Loaded News")
                }
                return
            })
        }
        task.resume()
    }
    
    func extractEventsJsondata(data:NSData){
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            if let jsonDict = jsonDictionary {
                let eventsJsonArray = jsonDict["events"] as! NSArray
                print("Number of Events: \(eventsJsonArray.count)")
                for eventJson in eventsJsonArray {
                    let event = GLTCEvent()
                    let eventJsonElement = eventJson as! NSDictionary
                    for (key, value) in eventJsonElement {
                        if(key as! String == "imageUrl"){
                            event.setEventImage(UIImageView(image: UIImage(named: "events_blue_medium")))
                            event.getEventImage().downloadImageFrom(link:value as! String, contentMode: UIViewContentMode.ScaleAspectFit)
                        }
                    }
                    self.events.append(event)
                }
            }
        }catch {
            print(error)
        }
    }
    
    func extractCommitteesJsondata(data:NSData){
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            if let jsonDict = jsonDictionary {
                let committeeJsonArray = jsonDict["committee"] as! NSArray
                print("Number of Committees: \(committeeJsonArray.count)")
                for committeeJson in committeeJsonArray {
                    let committee = GLTCCommittee()
                    let committeeJsonElement = committeeJson as! NSDictionary
                    for (key, value) in committeeJsonElement {
                        if(key as! String == "name"){
                            print("Committee Name: \(value)")
                            committee.setName(value as! String)
                        }else if(key as! String == "members"){
                            var members: [GLTCCommitteeMember] = []
                            let committeeMemberJsonArray = value as! NSArray
                            print("Number of Committee Members: \(committeeMemberJsonArray.count)")
                            for committeeMemberJson in committeeMemberJsonArray {
                                let committeeMember = GLTCCommitteeMember()
                                let committeeMemberJsonElement = committeeMemberJson as! NSDictionary
                                for (key,value) in committeeMemberJsonElement {
                                    if(key as! String == "name"){
                                        committeeMember.setName(value as! String)
                                    }else if(key as! String == "title"){
                                        committeeMember.setTitle(value as! String)
                                    }else if(key as! String == "imageUrl"){
                                        committeeMember.setMemberImage(UIImageView(image: UIImage(named: "userImg_medium")))
                                        committeeMember.getMemberImage().downloadImageFrom(link:value as! String, contentMode: UIViewContentMode.ScaleAspectFit)
                                    }
                                }
                                members.append(committeeMember)
                            }
                            committee.setMembers(members)
                        }
                    }
                    self.committees.append(committee)
                }
            }
        }catch {
            print(error)
        }
    }
    
    func extractSponsorsJsondata(data:NSData){
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            if let jsonDict = jsonDictionary {
                let sponsorJsonArray = jsonDict["sponsors"] as! NSArray
                print("Number of Sponsors: \(sponsorJsonArray.count)")
                for sponsorJson in sponsorJsonArray {
                    let sponsor = GLTCSponsor()
                    let sponsorJsonElement = sponsorJson as! NSDictionary
                    for (key, value) in sponsorJsonElement {
                        if(key as! String == "name"){
                            sponsor.setName(value as! String)
                        }else if(key as! String == "imageUrl"){
                            sponsor.setSponsorImage(UIImageView(image: UIImage(named: "sponsorImg")))
                            sponsor.getSponsorImage().downloadImageFrom(link:value as! String, contentMode: UIViewContentMode.ScaleAspectFit)
                        }
                    }
                    self.sponsors.append(sponsor)
                }
            }
        }catch {
            print(error)
        }
    }
    
    func extractNewsJsondata(data:NSData){
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            if let jsonDict = jsonDictionary {
                let newsJsonArray = jsonDict["news"] as! NSArray
                print("Number of News Items: \(newsJsonArray.count)")
                for newsJson in newsJsonArray {
                    let news = GLTCNews()
                    let newsJsonElement = newsJson as! NSDictionary
                    for (key, value) in newsJsonElement {
                        if(key as! String == "imageUrl"){
                            news.setNewsImage(UIImageView(image: UIImage(named: "news_blue_medium")))
                            news.getNewsImage().downloadImageFrom(link:value as! String, contentMode: UIViewContentMode.ScaleAspectFit)
                        }else if(key as! String == "newsText"){
                            news.setNewsText(value as! String)
                        }
                    }
                    self.news.append(news)
                }
            }
        }catch {
            print(error)
        }
    }
    
    func emptyContent() {
        events = []
        committees = []
        sponsors = []
        news = []
    }
}
