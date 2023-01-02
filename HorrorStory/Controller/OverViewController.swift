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
        
        videoService = VideoService(moc: self.coreData.persistentContainer.viewContext)
        loadVideos()
        
//        reloadCatchAPIVideos()
//
//        loadVideos()
        
        
//        reloadCatchAPIVideos()
//        loadVideos()
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        reloadCatchAPIVideos()
//        loadVideos()
//    }
    
    
    //如果沒有影片會解析API
    func catchAPIVideos() {
        channelUrlParseModel.checkData ()
        tableView.reloadData()
     
    }
    
    //匯入影片
    private func loadVideos() {
        if let videos = videoService?.getAllVideos() {
            channelVideos = videos
            tableView.reloadData()
        }
    }
    
    
    private func reloadCatchAPIVideos(checkDataIndex:Int?, CompletionHandleer handler:(Bool)->()) {
        
        let videoArray1 = channelVideos.filter { $0.cChannelTitle == "\(Model.channelArray[1])"}
        let videoArray2 = channelVideos.filter { $0.cChannelTitle == "\(Model.channelArray[2])"}
        let videoArray3 = channelVideos.filter { $0.cChannelTitle == "\(Model.channelArray[3])"}
        let videoArray4 = channelVideos.filter { $0.cChannelTitle == "\(Model.channelArray[4])"}
        let videoArray5 = channelVideos.filter { $0.cChannelTitle == "\(Model.channelArray[5])"}
        let videoArray6 = channelVideos.filter { $0.cChannelTitle == "\(Model.channelArray[6])"}
        
        let videoAry = [videoArray1,videoArray2,videoArray3,videoArray4,videoArray5,videoArray6]
        
        let urlAry = [Constants.S01_API_URL,
                      Constants.S02_API_URL,
                      Constants.S03_API_URL,
                      Constants.S04_API_URL,
                      Constants.S05_API_URL,
                      Constants.S06_API_URL]

        
        if let index = checkDataIndex, index != 0
        {
            if videoAry[index - 1 ].isEmpty
            {
                channelUrlParseModel.getVideos(urlAry[index],cChannelTitle: Model.channelArray[index])
            }
        }else
        {
            for i in 0...videoAry.count - 1
            {
                if videoAry[i].isEmpty{
                    channelUrlParseModel.getVideos(urlAry[i],cChannelTitle: Model.channelArray[i - 1])
                }
            }
        }
        
//        Thread.sleep(forTimeInterval: 0.2)
        handler(true)
        
        tableView.reloadData()
        
        
//        if videoArray1.isEmpty{
//            channelUrlParseModel.getVideos(Constants.S01_API_URL)
//            tableView.reloadData()
//
//        } else if videoArray2.isEmpty{
//            channelUrlParseModel.getVideos(Constants.S02_API_URL)
//            tableView.reloadData()
//
//        } else if videoArray3.isEmpty{
//            channelUrlParseModel.getVideos(Constants.S03_API_URL)
//            tableView.reloadData()
//
//        } else if videoArray4.isEmpty{
//            channelUrlParseModel.getVideos(Constants.S04_API_URL)
//            tableView.reloadData()
//
//        } else if videoArray5.isEmpty{
//            channelUrlParseModel.getVideos(Constants.S05_API_URL)
//            tableView.reloadData()
//
//        } else if videoArray6.isEmpty{
//            channelUrlParseModel.getVideos(Constants.S06_API_URL)
//            tableView.reloadData()
//
//        }
    }
    
    
    //傳遞資訊
    private func showVideoView(channelTitle: String, navigationTitle: String) {

    let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController

    print("channel Videos have \(channelVideos.count) video ")
    let videoArray = channelVideos.filter { $0.cChannelTitle == "\(channelTitle)"}
    print("\(channelTitle) channel have \(videoArray.count) video")
        
        //防止NSarray空的發生錯誤

        
        dvc.mTitle = channelTitle

        dvc.navigationTitle = navigationTitle
        dvc.coreData = coreData
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
    
        //解析影片慢，按下讀取影片
        //loadVideos()
        reloadCatchAPIVideos(checkDataIndex: indexPath.row) { ok in
            
            
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
                showVideoView(channelTitle: Model.channelArray[1], navigationTitle: Model.channelArray[1])

            case 2:
                showVideoView(channelTitle: Model.channelArray[2], navigationTitle: Model.channelArray[2])
                
            case 3:
                showVideoView(channelTitle: Model.channelArray[3], navigationTitle: Model.channelArray[3])
                
            case 4:
                showVideoView(channelTitle: Model.channelArray[4], navigationTitle: Model.channelArray[4])
                
            case 5:
                showVideoView(channelTitle: Model.channelArray[5], navigationTitle: Model.channelArray[5])
                
            case 6:
                //let channelName = "Muse木棉花-TW"
                showVideoView(channelTitle: Model.channelArray[6], navigationTitle: Model.channelArray[6])
     
              
            default:
                break
            }
        }
       
    }
     
}

