//
//  PlayListTableViewCell.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import UIKit


class PlayListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playListImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var video: CoreVideo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //顯示Cell內容
    func setCell(_ v: CoreVideo) {
        self.video = v
        
        // Ensure that we have a Video
        guard self.video != nil else {
            return
        }
        
        // Set the title
        self.titleLabel.text = video?.cTitle
        
        // 轉換日期格式
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        
        if video!.cPublished != nil {
            self.publishedLabel.text = df.string(from: video!.cPublished!)
        }
        
        
        // 確定縮圖不是空的
        guard self.video!.cThumbnail != "" else {
            return
        }
        
        // 取得cache
        if let cachedData = CacheManager.getVideoCache(self.video!.cThumbnail!) {
            
            // 設定顯示圖片
            self.playListImage.image = UIImage(data: cachedData)
            return
        }
        
        // 下載縮圖圖片
        let url = URL(string: self.video!.cThumbnail!)
        
        // Get the shared URL Session object
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            
            //沒有錯誤，有資料
            if error == nil && data != nil {
                
                // 建立緩存
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // Check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                
                if url!.absoluteString != self.video?.cThumbnail! {
                    // Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    
                    return
                }
                
                // Create the image object
                let image = UIImage(data: data!)
                
                // Set the imageview
                DispatchQueue.main.async {
                    self.playListImage.image = image
                }
            }
        }
        // Start data task
        dataTask.resume()
    }

}
