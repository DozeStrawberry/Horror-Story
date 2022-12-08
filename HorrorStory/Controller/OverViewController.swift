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
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
//    let vc = SecondViewController.init()
//    self.navigationController?.pushViewController(vc, animated: true)
    
    private func showItemView(url: String) {

        //let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController
        
        let dvc = VideoViewController.init()

        dvc.getAPI = url

        self.navigationController?.pushViewController(dvc, animated: true)
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
            channelURL = Constants.S01_API_URL
            showItemView(url: channelURL)
            channelURL = ""
    
        case 1:
            channelURL = Constants.S02_API_URL
            showItemView(url: channelURL)
            channelURL = ""
            
        case 2:
            channelURL = Constants.S03_API_URL
            showItemView(url: channelURL)
            channelURL = ""
            
        case 3:
            channelURL = Constants.S04_API_URL
            showItemView(url: channelURL)
            channelURL = ""
            
        case 4:
            channelURL = Constants.S05_API_URL
            showItemView(url: channelURL)
            channelURL = ""
            
        case 5:
            channelURL = Constants.S06_API_URL
            showItemView(url: channelURL)
            channelURL = ""
            
        default:
            break
        }
    }
     
}






