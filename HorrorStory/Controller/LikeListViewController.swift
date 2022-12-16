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
    
    //接收LikeVideo傳送過來的值
    var likeBackLike: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backValueAddLikeAarry()
        tableView.reloadData()
    }
    

    @IBAction func likeButtonChange(_ sender: UIButton) {
        
        senderLikeVideos[sender.tag].isLike = !senderLikeVideos[sender.tag].isLike
        
        if senderLikeVideos[sender.tag].isLike == false {
            
            for i in 0 ..< senderLikeVideos.count {
                
                if senderLikeVideos[sender.tag].videoId == senderLikeVideos[i].videoId {

                    senderLikeVideos.remove(at: i)

                    sendLikeData()
                    tableView.reloadData()
                    
                    //print("\(senderLikeVideos.count)")
                    break
                }
            }
        }

        //tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        tableView.reloadData()
    }
    
    
    private func sendLikeData() {

        //let navVC = tabBarController?.viewControllers![0] as! UINavigationController
        //let playListViewController = navVC.topViewController as! PlayListViewController
        //playListViewController.likeVideo = senderLikeVideos
    }
    
    
    //把檔案傳到下一頁
    private func showVideoView(video: VideoModel) {
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "goToLikeVideo") as! LikeVideoViewController
        
        dvc.video = video
        //dvc.channelTitle = navigationTitle
        
        dvc.likeBool = video.isLike
        //print("\(video.isLike)")
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func backValueAddLikeAarry() {
        
        senderLikeVideos = senderLikeVideos.filter { $0.isLike == true }
        sendLikeData()
          
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
        
        if likeBackLike != nil {
            video.isLike = likeBackLike!
        }
        
       
        
        cell.setCell(video)
        cell.likeButton.tag = indexPath.row

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //傳送資料到下一頁
        showVideoView(video: senderLikeVideos[indexPath.row])
        print("\(senderLikeVideos[indexPath.row])")
    }
    
    
    
}

