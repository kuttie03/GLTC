//
//  NewsCell.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 2/2/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsImg: UIImageView!
    
    @IBOutlet weak var newsDateLbl: UILabel!
    
    @IBOutlet weak var newsHeadlineLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getNewsImage() -> UIImageView{
        return self.newsImg
    }
    
    func setNewsImage(newsImg: UIImageView){
        self.newsImg = newsImg
    }
    
    func setNewsDate(newsDate: String) {
        self.newsDateLbl.text = newsDate
    }
    
    func setNewsHeadline(newsHeadline: String) {
        self.newsHeadlineLbl.text = newsHeadline
    }
    
}
