//
//  PlayListViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import UIKit
import CoreData

class PlayListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    public var playVideo = [VideoModel]()
    
    var coreData = CoreDataStack()
    var overViewController = OverViewController()
    
    var corePlayVideo = [CoreVideo]()
    var likeVideo = [CoreVideo]()
    
    //解析影片
    var mTitle:String?
    
    
    //接收overView傳送過來的值
    var navigationTitle: String?
    
    //接收playVideo傳送過來的值
    var backLike: Bool?
    var backVideoId: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadVideos()
        
        navigationItem.title = navigationTitle
        
        sendLikeData()
        likeVideo = corePlayVideo.filter { $0.isLike == true }
        
        //左上回去按鈕
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
    }
    
    
    //have channel name can get video
    private func loadVideos() {
        
        //初始化
        overViewController.videoService = VideoService(moc: coreData.persistentContainer.viewContext)
        
        if let videos = overViewController.videoService?.getVideosByTitle(cChannelTitle: mTitle) {
            
            corePlayVideo = videos
            
            tableView.reloadData()
        }
    }
    
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //傳過來按鈕資訊，可以傳新整理
    override func viewWillAppear(_ animated: Bool) {
        //backValueAddLikeAarry()
        
        tableView.reloadData()
    }
    
    
    //按鈕
    @IBAction func likeButtonPress(_ sender: UIButton) {
        
        //改變Bool值
        corePlayVideo[sender.tag].isLike = !corePlayVideo[sender.tag].isLike
        
        coreData.saveContext()
        
        // true增加到array
        if corePlayVideo[sender.tag].isLike == true {
            
            likeVideo.append(corePlayVideo[sender.tag])
            
            for i in 0 ..< likeVideo.count {
                
                if likeVideo[i].cVideoId == corePlayVideo[sender.tag].cVideoId {
                    
                    let likeVideoNumber = overViewController.channelVideos.filter { $0.isLike == true }
                    print("save like video \(likeVideoNumber.count)")
                    likeVideo[i].cAddNumber = Int64(likeVideoNumber.count + 1)
                    print("like video number \(likeVideo[i].cAddNumber)")
                    
                    coreData.saveContext()
                    sendLikeData()
                }
            }
            
            
        } else {
            
            // false, array刪減
            for i in 0 ..< likeVideo.count
            {
                
                if corePlayVideo[sender.tag].cVideoId == likeVideo[i].cVideoId
                {
                    
                    likeVideo.remove(at: i)
                    
                    for array in likeVideo
                    {
                        if i < array.cAddNumber
                        {
                            array.cAddNumber -= 1
                            print("\(array.cAddNumber)")
                        }
                    }

                    //dump(likeVideo)
                    coreData.saveContext()
                    sendLikeData()
                    break
                }
            }
        }
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    //內存同步
    private func sendLikeData() {
        
        let navVC = tabBarController?.viewControllers![1] as! UINavigationController
        let LikeListViewController = navVC.topViewController as! LikeListViewController
        LikeListViewController.coreData = coreData
        LikeListViewController.overViewController = overViewController
    }
    
    
    
    //把檔案傳到下一頁
    private func showVideoView(video: CoreVideo) {
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "goToPlayVideo") as! PlayVideoViewController
        
        dvc.overViewController = self.overViewController
        dvc.coreData = self.coreData
        
        dvc.video = video
        dvc.channelTitle = navigationTitle
        dvc.acceptLikeArray = likeVideo
        
        dvc.likeBool = video.isLike
        //print("\(video.isLike)")
        
        dvc.coreData = coreData
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    
}


extension PlayListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return corePlayVideo.count
        //return playVideo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell", for: indexPath) as! PlayListTableViewCell
        
        let selectVideo = self.corePlayVideo[indexPath.row]
        
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
        showVideoView(video: corePlayVideo[indexPath.row])
        
    }
    
    
}



