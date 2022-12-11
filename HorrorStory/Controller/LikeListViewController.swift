//
//  LikeListViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/11.
//

import UIKit

class LikeListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var senderLikeVideos = [VideoModel]()
    
    //var sLikeVideo: LikeVideosDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
//        guard sLikeVideo != nil else { return }
//        aLikeVideo = sLikeVideo!.selectedLikeVideos
        
        //print("have \(likeVideo.count) like Videos")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("have \(senderLikeVideos.count) like Videos")
        tableView.reloadData()
    }
    

    
  

}

extension LikeListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senderLikeVideos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell", for: indexPath) as! PlayListTableViewCell
        
        let video = self.senderLikeVideos[indexPath.row]
        
        //guard backLike != nil else { return }
        
//        if backLike != nil {
//            video.isLike = backLike!
//        }
        
        //改變按鈕圖案
        if video.isLike == false {
            cell.likeButton.imageView?.image = UIImage(systemName: "heart")
            //likeVideo.remove(at: video)
            print("like video remove \(video)")
        } else {
            cell.likeButton.imageView?.image = UIImage(systemName: "heart.fill")
            senderLikeVideos.append(video)
            print("like video have \(video)")
        }
        
        cell.setCell(video)
        cell.likeButton.tag = indexPath.row

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //傳送資料到下一頁
        //showVideoView(video: playVideo[indexPath.row])
   
    }
    
}

//extension LikeListViewController: LikeVideosDelegate {
//    func addLikeArray(_ likeVideos: [VideoModel]) {
//        self.aLikeVideo = likeVideos
//        tableView.reloadData()
//        
//    }
//    
//   
//}
