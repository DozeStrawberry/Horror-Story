//
//  LikeVideoViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/15.
//

import UIKit
import WebKit

class LikeVideoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var aLikeButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var connectYoutube: UIButton!
    
    
    //介面顯示
    var video: VideoModel?
    
    //接收傳過來的值
    //var channelTitle: String?
    var likeBool: Bool?
    

    override func viewDidLoad() {
        super.viewDidLoad()

         //navigationItem.title = channelTitle
     
         //左上按鈕
         self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
    }
    
    
    @objc func backAction() {
    
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func aLikeButtonPress(_ sender: UIButton) {
        guard video != nil else { return }

        video!.isLike = !video!.isLike
        print("Button value \(video!.isLike)")

        setButtonImage()

        sendLikeBool()
    }
    
    @IBAction func connectYoutubePressed(_ sender: UIButton) {
        guard video != nil else {
            return
        }
        
        let videoId = video!.videoId
        guard let youtubeUrl = URL(string: "youtube://\(videoId)") else { return }
        if UIApplication.shared.canOpenURL(youtubeUrl) {
            UIApplication.shared.open(youtubeUrl)
        } else {
            guard let videoUrl = URL(string: "https://www.youtube.com/watch?v=\(videoId)") else { return }
            UIApplication.shared.open(videoUrl)
        }
        
    }
    
    
    //按鈕圖片改變
    func setButtonImage() {
        guard video != nil else { return }
        if video!.isLike == false {
            aLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            aLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    
    private func sendLikeBool() {

        let dvc = storyboard?.instantiateViewController(withIdentifier: "goToLikeList") as! LikeListViewController

        guard video != nil else { return }

        dvc.likeBackLike = video!.isLike
        //dvc.backVideoId = video!.videoId
        //print("\(video!.videoId)")
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
        
        //print("\(video?.title)")
        
        guard likeBool != nil else {
            return
        }

        print("value is \(likeBool!)")

        video!.isLike = likeBool!

        //setButtonImage()
        
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
