//
//  PlayListViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import UIKit

class PlayListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var urlParseModel = URLParseModel()
    public var playVideo = [VideoModel]()
    var likeVideo = [VideoModel]()
    
    
    //接收overView傳送過來的值
    var getAPI: String?
    var navigationTitle: String?
    
    //接收playVideo傳送過來的值
    var backLike: Bool?
    //var backVideoId: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //urlParseModel.delegate = self
        
//        if getAPI != nil {
//            urlParseModel.getVideos(channelAPI: getAPI!)
//        }
        
        backValueAddLikeAarry()
        
        navigationItem.title = navigationTitle
        
        
        
        //左上回去按鈕
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //傳過來按鈕資訊，可以傳新整理
    override func viewWillAppear(_ animated: Bool) {
        backValueAddLikeAarry()
        
        tableView.reloadData()
    }
    
    
//    func sortArray() {
//        let playVideo.sorted(by: { $0.published > $1.published } )
//    }
    
    //按鈕
    @IBAction func likeButtonPress(_ sender: UIButton) {
        //改變Bool值
        playVideo[sender.tag].isLike = !playVideo[sender.tag].isLike
        
        // true增加到array
        if playVideo[sender.tag].isLike == true {
            
            likeVideo.append(playVideo[sender.tag])
            
            //print("I send \(likeVideo.count) like")
            sendLikeData()
            
        } else {
            
            // false, array刪減
            for i in 0 ..< likeVideo.count {
                
                if playVideo[sender.tag].videoId == likeVideo[i].videoId {
                    print("remove \(likeVideo[i].title), \(likeVideo[i].isLike)")
                    likeVideo.remove(at: i)
                    //print("remove after have \(likeVideo.count) video")
                    sendLikeData()
                    break
                    
                }
            }
        }
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    
    private func sendLikeData() {
        
        let navVC = tabBarController?.viewControllers![1] as! UINavigationController
        let LikeListViewController = navVC.topViewController as! LikeListViewController
        LikeListViewController.senderLikeVideos = likeVideo
    }
    
    
    func backValueAddLikeAarry() {
        
        likeVideo = playVideo.filter { $0.isLike == true }
        sendLikeData()
          
    }
    
    
    
    //把檔案傳到下一頁
    private func showVideoView(video: VideoModel) {
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "goToPlayVideo") as! PlayVideoViewController
        
        dvc.video = video
        dvc.channelTitle = navigationTitle
        
        dvc.likeBool = video.isLike
        //print("\(video.isLike)")
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}


extension PlayListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playVideo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell", for: indexPath) as! PlayListTableViewCell
        
        let selectVideo = self.playVideo[indexPath.row]
        
        //回傳Bool過來有值
        if backLike != nil {
            selectVideo.isLike = backLike!
            
        }

        
        //改變按鈕圖案
        if selectVideo.isLike == false {
            cell.likeButton.imageView?.image = UIImage(systemName: "heart")
            
        } else {
            cell.likeButton.imageView?.image = UIImage(systemName: "heart.fill")
            
        }
        
        cell.setCell(selectVideo)
        cell.likeButton.tag = indexPath.row
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //傳送資料到下一頁
        showVideoView(video: playVideo[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}


//extension PlayListViewController: ModelDelegate {
//
//    func videosFetched(_ videos: [VideoModel]) {
//
//        self.playVideo = videos
//        tableView.reloadData()
//    }
//
//}
