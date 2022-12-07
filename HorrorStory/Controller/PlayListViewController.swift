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
        
        
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
  

}

extension PlayListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playListVideo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell", for: indexPath) as! PlayListTableViewCell
        
        let video = self.playListVideo[indexPath.row]
        
        cell.setCell(video)
        
        return cell
    }


}



extension PlayListViewController: ModelDelegate {

    func videosFetched(_ videos: [PlayListVideo]) {

        self.playListVideo = videos
        tableView.reloadData()
    }
    
    
}
