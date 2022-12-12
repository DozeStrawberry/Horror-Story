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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    

    @IBAction func likeButtonChange(_ sender: UIButton) {
        
        senderLikeVideos[sender.tag].isLike = !senderLikeVideos[sender.tag].isLike
        
        if senderLikeVideos[sender.tag].isLike == false {
            
            for i in 0 ..< senderLikeVideos.count {
                
                if senderLikeVideos[sender.tag].videoId == senderLikeVideos[i].videoId {
                    print("Like page remove \(senderLikeVideos[i].title), \(senderLikeVideos[i].isLike)")
                    senderLikeVideos.remove(at: i)
                    print("Like page remove after have \(senderLikeVideos.count) video")
                    
                    sendLikeData()
                    tableView.reloadData()
                    
                    print("\(senderLikeVideos.count)")
                    break
                }
            
            }
            
        }

        
        //tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        tableView.reloadData()
    }
    
    private func sendLikeData() {

        let navVC = tabBarController?.viewControllers![0] as! UINavigationController
        let playListViewController = navVC.topViewController as! PlayListViewController
        playListViewController.likeVideo = senderLikeVideos
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

