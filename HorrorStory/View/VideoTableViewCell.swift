//
//  VideoTableViewCell.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/7.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoReleaseLabel: UILabel!
    
    var video: PlayListVideo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //顯示Cell內容
    func setCell(_ v: PlayListVideo) {
        self.video = v
        
        // Ensure that we have a Video，確定有值
        guard self.video != nil else {
            return
        }
        
        // Set the title
        self.videoTitleLabel.text = video?.title
        
        // Set data label，轉換日期格式
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.videoReleaseLabel.text = df.string(from: video!.published)
        
        // Set the thumbnail，確定縮圖不是空的
        guard self.video!.thumbnail != "" else {
            return
        }
        
        // Check cache before downloading data，取得cache
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            // Set the thumbnail imageview，設定顯示圖片
            self.videoImage.image = UIImage(data: cachedData)
            return
        }
        
        // Download the thumbnail data，下載縮圖圖片
        let url = URL(string: self.video!.thumbnail)
        
        // Get the shared URL Session object
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            
            //沒有錯誤，有資料
            if error == nil && data != nil {
                
                // Save the data in the cache，建立緩存
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // Check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                
                if url!.absoluteString != self.video?.thumbnail {
                    // Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    
                    return
                }
                
                // Create the image object
                let image = UIImage(data: data!)
                
                // Set the imageview
                DispatchQueue.main.async {
                    self.videoImage.image = image
                }
            }
        }
        // Start data task
        dataTask.resume()
    }
    
}
