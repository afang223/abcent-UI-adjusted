//
//  ViewController.swift
//  Abcent-Swift
//
//  Created by Patrick Yin on 10/26/19.
//  Copyright © 2019 Patrick Yin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import AVKit
import AVFoundation

class FeedVC: UIViewController {
    
    var videos: [Video]! = []
    var selectedVideo: Video!
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllVideoURLs()
        
        self.navigationItem.title = "Feed"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailVC
        destinationVC.selectedVideo = selectedVideo
    }
}

extension FeedVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var index = indexPath[1]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as! FeedCell
        cell.awakeFromNib()
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //For entire screen size
        let screenSize = UIScreen.main.bounds.size
        return screenSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var index = indexPath[1]
        selectedVideo = videos[indexPath.item]
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfMajorCell = self.indexOfMajorCell()
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        feedCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = UIScreen.main.bounds.width
        let proportionalOffset = feedCollectionView.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(videos.count - 1, index))
        return safeIndex
    }
    
}
 
