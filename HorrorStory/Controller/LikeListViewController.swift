//
//  LikeListViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/11.
//

import UIKit
import CoreData

class LikeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var channelUrlParseModel = ChannelUrlParseModel()
    var overViewController = OverViewController()
    var coreData = CoreDataStack()

    var likeVideos = [CoreVideo]()
    
    //接收LikeVideo傳送過來的值
    var likeBackLike: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //channelUrlParseModel = .init()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadVideos()
        
    }
    
    
    private func loadVideos() {
        overViewController.videoService = VideoService(moc: coreData.persistentContainer.viewContext)
        if overViewController.videoService != nil {
            print("videoService is \(overViewController.videoService!)")
        }
        
        if let videos = overViewController.videoService?.getLikeVideos() {
            likeVideos = videos
            //print("likeVideos have \(likeVideos.count)")
            tableView.reloadData()
        }
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        print("like video have \(likeVideos.count)")
        deleteVideos()
        print("like video have \(likeVideos.count)")
    }
    
    func deleteVideos() {
        
        for array in likeVideos{
            array.isLike = false
            array.cAddNumber = 0
            tableView.reloadData()
        }
        likeVideos = []
        coreData.saveContext()
        tableView.reloadData()
    }
    
 
    @IBAction func likeButtonChange(_ sender: UIButton) {
        
        likeVideos[sender.tag].isLike = !likeVideos[sender.tag].isLike
        
        coreData.saveContext()
        
        if likeVideos[sender.tag].isLike == false
        {
            
            for i in 0 ..< likeVideos.count
            {
                
                if likeVideos[sender.tag].cVideoId == likeVideos[i].cVideoId
                {

                    likeVideos.remove(at: i)

                    for array in likeVideos
                    {

                        if i < array.cAddNumber
                        {
                            array.cAddNumber -= 1
                            print("\(array.cAddNumber)")
                        }
                    }
                    
                    coreData.saveContext()
                    //tableView.reloadData()
                    
                    //print("\(senderLikeVideos.count)")
                    break
                }
            }
        }

        //tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        tableView.reloadData()
    }
    
    
    //把檔案傳到下一頁
    private func showVideoView(video: CoreVideo) {
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "goToLikeVideo") as! LikeVideoViewController
        
        dvc.video = video
        dvc.likeBool = video.isLike
        
        dvc.overViewController = overViewController
        dvc.coreData = coreData
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
}

extension LikeListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeVideos.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell", for: indexPath) as! PlayListTableViewCell
        
        let video = self.likeVideos[indexPath.row]
        
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
        showVideoView(video: likeVideos[indexPath.row])
        //print("\(senderLikeVideos[indexPath.row])")
    }
    
    
    
}

