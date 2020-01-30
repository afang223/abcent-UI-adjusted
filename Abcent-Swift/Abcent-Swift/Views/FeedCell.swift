//
//  FeedViewCell.swift
//  Abcent-Swift
//
//  Created by Patrick Yin on 10/26/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//


import UIKit

class FeedCell: UICollectionViewCell {
    
    var video: Video? {
        didSet {
            if let video = video {
//                videoLength.text = "Created by: " + video.creator
//                attendeeNumber.text = "\(video.interested.count)"
                videoTitle.text = video.title
                thumbnail.image = video.thumbnail
            }
        }
    }
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
