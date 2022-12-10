//
//  PlayVideoViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/8.
//

import UIKit
import WebKit

class PlayVideoViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var aLikeButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var video: VideoModel?
    
    var channelTitle: String?
    var likeBool: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = channelTitle
    
        
        //左上按鈕
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func aLikeButtonPress(_ sender: UIButton) {
        //likeBool = !likeBool!
        guard video != nil else { return }
        
        video!.isLike = !video!.isLike
        print("Button value \(video!.isLike)")
        
        setButtonImage()
        
    }
    
    func setButtonImage() {
        guard video != nil else { return }
        if video!.isLike == false {
            aLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            aLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    
    //即將出現
    override func viewWillAppear(_ animated: Bool) {
        
        
        // Clear the fields
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        // check if there's a video，確認有沒有值
        guard video != nil else {
            return
        }
        
        guard likeBool != nil else {
            return
        }

        print("value is \(likeBool!)")
        
        video!.isLike = likeBool!
        
        setButtonImage()
 
        // Create the embed URL
        let embedURLString = Constants.YT_EMBED_URL + video!.videoId
        
        // Load it into the webview
        let url = URL(string: embedURLString)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // Set the title
        titleLabel.text = video!.title
        
        // Set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = df.string(from: video!.published)
        
        // Set the description
        textView.text = video!.description
    }
    
}
