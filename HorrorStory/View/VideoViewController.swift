//
//  VideoViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/7.
//

import UIKit

class VideoViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var urlParseModel = URLParseModel()
    var playListVideo = [PlayListVideo]()
    
    var getAPI: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        urlParseModel.delegate = self
        
        if getAPI != nil {
            urlParseModel.getVideos(channelAPI: getAPI!)
        }
        
        let nib = UINib(nibName: "VideoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "VideoTableViewCell")
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }

}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playListVideo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        
        let video = self.playListVideo[indexPath.row]
        
        cell.setCell(video)
        
        return cell
    }


}


extension VideoViewController: ModelDelegate {

    func videosFetched(_ videos: [PlayListVideo]) {

        self.playListVideo = videos
        tableView.reloadData()
    }
    
    
}
