//
//  GLTCDataLoader.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/20/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class GLTCDataLoader {
    
    let COMMITTEE_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=committeesJson"
    let SPONSORS_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=sponsorsJson"
    let NEWS_JSON_URL = "http://1-dot-jsonloader-0834.appspot.com/jsonloader?jsonType=newsJson"
    
    //Singleton
    static let sharedInstance = GLTCDataLoader()
    
    private var committees: [GLTCCommittee] = []
    private var sponsors: [GLTCSponsor] = []
    private var news: [GLTCNews] = []
    
    private init() {
        loadCommittees()
        loadSponsors()
        loadNews()
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
    
    func loadCommittees(){
        let url:NSURL = NSURL(string: COMMITTEE_JSON_URL)!
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
                self.extractCommitteeJsondata(data!)
                return
            })
        }
        task.resume()
    }
    
    func extractCommitteeJsondata(data:NSData){
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
                            var members: [CommitteeMember] = []
                            let committeeMemberJsonArray = value as! NSArray
                            print("Number of Committee Members: \(committeeMemberJsonArray.count)")
                            for committeeMemberJson in committeeMemberJsonArray {
                                let committeeMember = CommitteeMember()
                                let committeeMemberJsonElement = committeeMemberJson as! NSDictionary
                                for (key,value) in committeeMemberJsonElement {
                                    if(key as! String == "name"){
                                        committeeMember.setName(value as! String)
                                    }else if(key as! String == "title"){
                                        committeeMember.setTitle(value as! String)
                                    }else if(key as! String == "picture"){
                                        committeeMember.setImageUrl(value as! String)
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
    
    func loadSponsors(){
        let url:NSURL = NSURL(string: SPONSORS_JSON_URL)!
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.extractSponsorJsondata(data!)
                return
            })
        }
        task.resume()
    }
    
    func extractSponsorJsondata(data:NSData){
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
                        }else if(key as! String == "pictureUrl"){
                            sponsor.setImageUrl(value as! String)
                        }
                    }
                    self.sponsors.append(sponsor)
                }
            }
        }catch {
            print(error)
        }
    }
    
    func loadNews() {
        let url = NSURL(string: NEWS_JSON_URL)
        if let data = NSData(contentsOfURL: url!) {
            extractNewsJsondata(data)
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
                            news.setNewsImage(UIImageView(image: UIImage(named: "sponsorImg")))
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
}
