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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //Confirm that a video selected
//        guard tableView.indexPathForSelectedRow != nil else {
//            return
//        }
//
//        if segue.identifier == "goToPlayList"{
//            let dvc = segue.destination as? PlayListViewController
//            dvc?.getAPI = channelURL
//
//        }
//    }
    
    private func showItemView(url: String) {

        let dvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "goToPlayList") as! PlayListViewController

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
            channelURL = Constants.XSURVEY_API_URL
            showItemView(url: channelURL)
            //performSegue(withIdentifier: "goToPlayList", sender: nil)
            
    
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }
     
}






