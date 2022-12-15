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
        
        self.tabBarController?.tabBar.isHidden = true
        
        ch1UrlParseModel.delegate = self
        ch1UrlParseModel.getVideos()
        
        ch2UrlParseModel.delegate = self
        ch2UrlParseModel.getVideos()
        //print("\(ch2Video.count)")
        //print("teat \(ch1Video.count)")
        
        
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
            
            dvc.playVideo = ch1Video
            //dvc.navigationTitle = channelTitle
           
            navigationController?.pushViewController(dvc, animated: true)
//            channelURL = Constants.S01_API_URL
//            channelName = Model.channelArray[0]
//            showVideoView(url: channelURL, channelTitle: channelName)
//            channelURL = ""
//            channelName = ""
            //break
    
        case 1:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
            
            dvc.playVideo = ch2Video
            //dvc.navigationTitle = channelTitle
           
            navigationController?.pushViewController(dvc, animated: true)
//            channelURL = Constants.S02_API_URL
//            channelName = Model.channelArray[1]
//            showVideoView(url: channelURL, channelTitle: channelName)
//            channelURL = ""
//            channelName = ""
            
        case 2:
            channelURL = Constants.S03_API_URL
            channelName = Model.channelArray[2]
            showVideoView(url: channelURL, channelTitle: channelName)
            channelURL = ""
            channelName = ""
            
        case 3:
            channelURL = Constants.S04_API_URL
            channelName = Model.channelArray[3]
            showVideoView(url: channelURL, channelTitle: channelName)
            channelURL = ""
            channelName = ""
            
        case 4:
            channelURL = Constants.S05_API_URL
            channelName = Model.channelArray[4]
            showVideoView(url: channelURL, channelTitle: channelName)
            channelURL = ""
            channelName = ""
            
        case 5:
            channelURL = Constants.S06_API_URL
            channelName = Model.channelArray[5]
            showVideoView(url: channelURL, channelTitle: channelName)
            channelURL = ""
            channelName = ""
            
        default:
            break
        }
    }
     
}



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


