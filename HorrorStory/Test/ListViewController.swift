//
//  ListViewController.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/7.
//

import UIKit

class ListViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //let videoView = VideoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //scrollView.delegate = self
        
        //scrollView.addSubview(videoView)
        
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
    }
    
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
  



}
