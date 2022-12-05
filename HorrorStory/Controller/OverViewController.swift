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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }


}


extension OverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.channelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OverViewTableViewCell
        
        let channelName = self.Model.channelArray[indexPath.row]
        cell.channelName.text = channelName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

