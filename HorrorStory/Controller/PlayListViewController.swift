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
    public var likeVideo = [VideoModel]()
    
    //接收overView傳送過來的值
    var getAPI: String?
    var navigationTitle: String?
    
    var backLike: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        urlParseModel.delegate = self
        
        if getAPI != nil {
            urlParseModel.getVideos(channelAPI: getAPI!)
        }
        
        navigationItem.title = navigationTitle
       
        //左上回去按鈕
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //傳過來按鈕資訊，可以傳新整理
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    
    //按鈕
    @IBAction func likeButtonPress(_ sender: UIButton) {
        //改變Bool值
        playVideo[sender.tag].isLike = !playVideo[sender.tag].isLike
        //print("\(playVideo[sender.tag].isLike)")
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        
       }
    
    //把檔案傳到下一頁
    private func showVideoView(video: VideoModel) {

        let dvc = storyboard?.instantiateViewController(withIdentifier: "goToPlayVideo") as! PlayVideoViewController

        dvc.video = video
        dvc.channelTitle = navigationTitle
        
        dvc.likeBool = video.isLike
        print("\(video.isLike)")
        
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
        
        let video = self.playVideo[indexPath.row]
        
        //guard backLike != nil else { return }
        
        if backLike != nil {
            video.isLike = backLike!
        }
        
        //改變按鈕圖案
        if video.isLike == false {
            cell.likeButton.imageView?.image = UIImage(systemName: "heart")
        } else {
            cell.likeButton.imageView?.image = UIImage(systemName: "heart.fill")
        }
        
        cell.setCell(video)
        cell.likeButton.tag = indexPath.row

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //傳送資料到下一頁
        showVideoView(video: playVideo[indexPath.row])
   
    }
    
}


extension PlayListViewController: ModelDelegate {

    func videosFetched(_ videos: [VideoModel]) {

        self.playVideo = videos
        tableView.reloadData()
    }
    
    
}
