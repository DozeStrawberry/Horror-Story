//
//  ViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/3.
//

import UIKit
import CoreData


class OverViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //目錄顯示
    let Model = OverViewModel()
    //解析API
    let channelUrlParseModel = ChannelUrlParseModel()
    
    private var coreData = CoreDataStack()
    public var videoService: VideoService?
    
    //解析完影片
    var channelVideos = [CoreVideo]()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        catchAPIVideos()
        
        videoService = VideoService(moc: coreData.persistentContainer.viewContext)

//        print("videoService \(videoService)")
        loadVideos()
        
     
        
    }
    
    //如果沒有影片會解析API
    func catchAPIVideos() {
        channelUrlParseModel.checkData ()
//        tableView.reloadData()
    }
    
    //匯入影片
    private func loadVideos() {
        if let videos = videoService?.getAllVideos() {
            channelVideos = videos
//            tableView.reloadData()
        }
    }
    
    //傳遞資訊
    private func showVideoView(channelTitle: String) {

    let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController

    print("channel Videos have \(channelVideos.count) video ")
    let videoArray = channelVideos.filter { $0.cChannelTitle == "\(channelTitle)"}
    
    print("\(channelTitle) channel have \(videoArray.count) video")
//    dvc.corePlayVideo = videoArray
    dvc.navigationTitle = channelTitle
        dvc.mTitle = channelTitle
        dvc.overViewController = self

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
        
//        loadVideos()
        
        
        
        switch indexPath.row {

        case 0:
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
            
            dvc.corePlayVideo = channelVideos
            dvc.navigationTitle = Model.channelArray[0]
            dvc.overViewController = self
            dvc.coreData = coreData
            dvc.mTitle = nil
            
            navigationController?.pushViewController(dvc, animated: true)
            
        case 1:
            showVideoView(channelTitle: Model.channelArray[1])

        case 2:
            showVideoView(channelTitle: Model.channelArray[2])
            
        case 3:
            showVideoView(channelTitle: Model.channelArray[3])
            
        case 4:
            showVideoView(channelTitle: Model.channelArray[4])
            
        case 5:
            showVideoView(channelTitle: Model.channelArray[5])
            
        case 6:
            let channelName = "Muse木棉花-TW"
            
            let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController

            //print("channel Videos have \(channelVideos.count) video ")
            let videoArray = channelVideos.filter { $0.cChannelTitle == "\(channelName)"}.sorted(by: { $0.cTitle ?? "" < $1.cTitle ?? "" } )
            
            //print("Muse木棉花-TW channel have \(videoArray.count) video")
            dvc.corePlayVideo = videoArray
            dvc.navigationTitle = Model.channelArray[6]
            
            navigationController?.pushViewController(dvc, animated: true)
          
        default:
            break
        }
    }
     
}

