//
//  ViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/3.
//

import UIKit
import CoreData


class OverViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let coreData = CoreDataStack()
    let Model = OverViewModel()
    
    var channelURL = String()
    var channelName = String()
    
    //var container: NSPersistentContainer!
    
    var channelVideos = [CoreVideo]()
    
    let ch1UrlParseModel = ChannelUrlParseModel()


  
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //ch1UrlParseModel.delegate = self
        ch1UrlParseModel.checkData()

        getAllItems()
        
    }
    
    
    func getAllItems() {
        let context = coreData.persistentContainer.viewContext
        let sortByTime = NSSortDescriptor(key: "cPublished", ascending: false)
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        request.sortDescriptors = [sortByTime]
         
         do {
             //獲取請求
             channelVideos = try context.fetch(request)
             //主畫面更新
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
         } catch {
             print("get All Items have error: ",error.localizedDescription)
         }
         
     }
    
    
    private func showVideoView(channelTitle: String) {

    let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController

    //print("channel Videos have \(channelVideos.count) video ")
    let videoArray = channelVideos.filter { $0.cChannelTitle == "\(channelTitle)"}
    
    //print("\(channelTitle) channel have \(videoArray.count) video")
    dvc.coreVideo = videoArray
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
            
            dvc.coreVideo = channelVideos
            dvc.navigationTitle = Model.channelArray[0]
            
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
            dvc.coreVideo = videoArray
            dvc.navigationTitle = Model.channelArray[6]
            
            navigationController?.pushViewController(dvc, animated: true)
          
        default:
            break
        }
    }
     
}

