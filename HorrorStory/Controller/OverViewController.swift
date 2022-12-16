//
//  ViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/3.
//

import UIKit

class OverViewController: UIViewController {
   

    @IBOutlet weak var tableView: UITableView!

    let Model = OverViewModel()
    
    var channelURL = String()
    var channelName = String()
    
    
    let ch1UrlParseModel = Ch1UrlParseModel()
    let ch2UrlParseModel = Ch2UrlParseModel()
    let ch3UrlParseModel = Ch3UrlParseModel()
    let ch4UrlParseModel = Ch4UrlParseModel()
    let ch5UrlParseModel = Ch5UrlParseModel()
    let ch6UrlParseModel = Ch6UrlParseModel()
    
    var allChannelVideo = [VideoModel]()
    var ch1Video = [VideoModel]()
    var ch2Video = [VideoModel]()
    var ch3Video = [VideoModel]()
    var ch4Video = [VideoModel]()
    var ch5Video = [VideoModel]()
    var ch6Video = [VideoModel]()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ch1UrlParseModel.delegate = self
        ch1UrlParseModel.getVideos()
        
        ch2UrlParseModel.delegate = self
        ch2UrlParseModel.getVideos()
        
        ch3UrlParseModel.delegate = self
        ch3UrlParseModel.getVideos()
        
        ch4UrlParseModel.delegate = self
        ch4UrlParseModel.getVideos()
        
        ch5UrlParseModel.delegate = self
        ch5UrlParseModel.getVideos()
        
        ch6UrlParseModel.delegate = self
        ch6UrlParseModel.getVideos()

       
        print("\(ch3Video.count)")
        print("\(allChannelVideo.count)")
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true
    }

    private func showVideoView(url: String, channelTitle: String) {

        let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
        
        //let dvc = VideoViewController.init() //傳送xib方法

        dvc.getAPI = url
        dvc.navigationTitle = channelTitle
       
        navigationController?.pushViewController(dvc, animated: true)
    }
    
 
    
    
}


extension OverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.channelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OverViewTableViewCell
        
        let channelText = self.Model.channelArray[indexPath.row]
        cell.channelName.text = channelText
        
        let sortText = self.Model.sortArray[indexPath.row]
        cell.sortLabel.text = sortText
        
        let channelImage = self.Model.channelImageArray[indexPath.row]
        cell.channelImage.image = channelImage
        cell.channelImage?.layer.cornerRadius = (cell.channelImage?.frame.height)!/2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {

        case 0:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
            allChannelVideo = ch3Video + ch5Video + ch2Video + ch1Video + ch4Video + ch6Video
            let sortArray = allChannelVideo.sorted(by: { $0.published > $1.published } )
            dvc.playVideo = sortArray
            dvc.navigationTitle = Model.channelArray[0]
            navigationController?.pushViewController(dvc, animated: true)

    
        case 1:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
       
            dvc.playVideo = ch1Video
            dvc.navigationTitle = Model.channelArray[1]
            navigationController?.pushViewController(dvc, animated: true)

            
        case 2:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
   
            dvc.playVideo = ch2Video
            dvc.navigationTitle = Model.channelArray[2]

            navigationController?.pushViewController(dvc, animated: true)

            
        case 3:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
     
            dvc.playVideo = ch3Video
            dvc.navigationTitle = Model.channelArray[3]
           
            navigationController?.pushViewController(dvc, animated: true)

            
        case 4:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
          
            dvc.playVideo = ch4Video
            dvc.navigationTitle = Model.channelArray[4]
           
            navigationController?.pushViewController(dvc, animated: true)

            
        case 5:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
       
            dvc.playVideo = ch5Video
            dvc.navigationTitle = Model.channelArray[5]
           
            navigationController?.pushViewController(dvc, animated: true)

        case 6:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
            let sort6Array = ch6Video.sorted(by: { $0.title < $1.title } )
            dvc.playVideo = sort6Array
            dvc.navigationTitle = Model.channelArray[6]
           
            navigationController?.pushViewController(dvc, animated: true)
            
          
        default:
            break
        }
    }
     
}

//MARK: - get all channel video

extension OverViewController: Ch1ModelDelegate {
    func ch1VideosFetched(_ videos: [VideoModel]) {
        self.ch1Video = videos
        //tableView.reloadData()
    }
}

extension OverViewController: Ch2ModelDelegate {
    func ch2VideosFetched(_ videos: [VideoModel]) {
        self.ch2Video = videos
    }
}

extension OverViewController: Ch3ModelDelegate {
    func ch3VideosFetched(_ videos: [VideoModel]) {
        self.ch3Video = videos
    }
}

extension OverViewController: Ch4ModelDelegate {
    func ch4VideosFetched(_ videos: [VideoModel]) {
        self.ch4Video = videos
    }
}

extension OverViewController: Ch5ModelDelegate {
    func ch5VideosFetched(_ videos: [VideoModel]) {
        self.ch5Video = videos
    }
}

extension OverViewController: Ch6ModelDelegate {
    func ch6VideosFetched(_ videos: [VideoModel]) {
        self.ch6Video = videos
    }
}



