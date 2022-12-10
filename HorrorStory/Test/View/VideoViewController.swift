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
    var playListVideo = [VideoModel]()
    
    var getAPI: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        urlParseModel.delegate = self
        
        if getAPI != nil {
            urlParseModel.getVideos(channelAPI: getAPI!)
        }
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
        
        let nib = UINib(nibName: "VideoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "VideoTableViewCell")
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
//    private func showVideoView(video: PlayListVideo) {
//
//        //let dvc = UIStoryboard.init(name: "goToPlayList", bundle: nil).instantiateViewController(identifier: "goToPlayVideo") as! PlayVideoViewController
//
//        let dvc = storyboard?.instantiateViewController(withIdentifier: "goToPlayVideo") as! PlayVideoViewController
//
//        //let dvc = VideoViewController.init()
//
//        dvc.video = video
//
//        self.navigationController?.pushViewController(dvc, animated: true)
//    }
    
//
//    private func showVideoView(_ video: PlayListVideo) {
//
//        guard tableView.indexPathForSelectedRow != nil else {
//            return
//        }
//
//        let sb = UIStoryboard(name: "VideoViewStoryboard", bundle: nil)
//        let dvc = sb.instantiateViewController(withIdentifier: "goToPlayVideo") as! PlayVideoViewController
//
//        let selectedVideo = playListVideo[tableView.indexPathForSelectedRow!.row]
//
//        dvc.video = selectedVideo
//
//        self.present(dvc, animated: true, completion: nil)
//    }
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //        //Confirm that a video selected
    //        guard tableView.indexPathForSelectedRow != nil else {
    //            return
    //        }
    //
    //        // Get a reference to the video that was tapped on
    //        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
    //
    //        // Get a reference to the detail view controller
    //        let detailVC = segue.destination as! DetailViewController
    //
    //        // Set the video property of the datail view controller
    //        detailVC.video = selectedVideo
    //    }
    
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //return 300
        return UITableView.automaticDimension
    }
    
    //    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    //        return 350
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //showVideoView(video: playListVideo[indexPath.row])
    }
    
    
}


extension VideoViewController: ModelDelegate {
    
    func videosFetched(_ videos: [VideoModel]) {
        
        self.playListVideo = videos
        tableView.reloadData()
    }
    
    
}
