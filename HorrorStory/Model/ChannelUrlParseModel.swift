//
//  Ch1UrlParseModel.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/15.
//
import Foundation
import CoreData

 
class ChannelUrlParseModel {
    
    private var coreData = CoreDataStack()
    
    func checkData() {
        let moc = coreData.persistentContainer.viewContext
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        
        if let movieCount = try? moc.count(for: request), movieCount > 0 {
            print("already")
            return
        }
        
        
//        - (void)identifyTask:(AGSIdentifyTask *)identifyTask operation:(NSOperation *)op didExecuteWithIdentifyResults:(NSArray *)results {          //clear previous results     [self.graphicsLayer removeAllGraphics];          if ([results count] > 0) {                          //add new results         AGSSymbol* symbol = [AGSSimpleFillSymbol simpleFillSymbol];         symbol.color = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];                  // for each result, set the symbol and add it to the graphics layer         for (AGSIdentifyResult* result in results) {             result.feature.symbol = symbol;             [self.graphicsLayer addGraphic:result.feature];         }                  //set the callout content for the first result         //get the state name         NSString *stateName = [((AGSIdentifyResult*)[results objectAtIndex:0]).feature.attributes objectForKey:@"STATE_NAME"];          self.mapView.callout.title = stateName;         self.mapView.callout.detail = @"Click for more detail..";                  //show callout         [self.mapView showCalloutAtPoint:self.mappoint forGraphic:((AGSIdentifyResult*)[results objectAtIndex:0]).feature animated:YES];     }     else {                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Identify Result"                                                         message:@"No Result Found!"                                                        delegate:nil                                               cancelButtonTitle:@"OK"                                               otherButtonTitles:nil];         [alert show];         [alert release];     }          //call dataChanged on the graphics layer to redraw the graphics     [self.graphicsLayer dataChanged];  }

        
        var urlAry:[String] = []
        
        urlAry = [Constants.S01_API_URL,Constants.S02_API_URL,
                  Constants.S03_API_URL,
                  Constants.S04_API_URL,
                  Constants.S05_API_URL,
                  Constants.S06_API_URL]
        
        
        getVideosAry(urlAry) { success in
            
        }
//        getVideos(Constants.S01_API_URL)
//        getVideos(Constants.S02_API_URL)
//        getVideos(Constants.S03_API_URL)
//        getVideos(Constants.S04_API_URL)
//        getVideos(Constants.S05_API_URL)
//        getVideos(Constants.S06_API_URL)
        
    }
    
    
//    func getVideos(_ urlString: String) {
//
//        let moc = coreData.persistentContainer.viewContext
//
//        let url = URL(string: urlString)
//
//        guard url != nil else {
//            return
//        }
//
//        let session = URLSession.shared
//
//        let dataTask = session.dataTask(with: url!) { data, response, error in
//
//            if error != nil || data == nil {
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//
//                let response = try decoder.decode(PlayListResponse.self, from: data!)
//
//                var newVideos: [CoreVideo] = []
//
//                for item in response.items! {
//
//                    let newVideo = CoreVideo(context: moc)
//
//                    //CoreVideo.setValue(false, forKey: "cIsLike")
//                    newVideo.isLike = false
//                    //newVideo.cIsLike = false
//                    newVideo.cThumbnail = item.thumbnail
//                    newVideo.cPublished = item.published
//                    newVideo.cVideoId = item.videoId
//                    newVideo.cDescription = item.description
//                    newVideo.cChannelTitle = item.channelTitle
//                    newVideo.cTitle = item.title
//
//                    newVideos += [newVideo]
//
//                }
//
//                self.coreData.saveContext()
//
//
//                //可以階層都印出來
//                //dump(response.items)
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//
//        }
//        dataTask.resume()
//    }
    
    func getVideosAry(_ urlString: [String], completion: @escaping(_ success: Bool)->Void) {
        
        let moc = coreData.persistentContainer.viewContext
        
        
        for urlString in urlString
        {
            let url = URL(string: urlString)
            
            guard url != nil else {
                return
            }
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url!) { data, response, error in
                
                if error != nil || data == nil {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let response = try decoder.decode(PlayListResponse.self, from: data!)
                    
                    var newVideos: [CoreVideo] = []
                    
                    for item in response.items! {
                        
                        let newVideo = CoreVideo(context: moc)
                        
                        //CoreVideo.setValue(false, forKey: "cIsLike")
                        newVideo.isLike = false
                        //newVideo.cIsLike = false
                        newVideo.cThumbnail = item.thumbnail
                        newVideo.cPublished = item.published
                        newVideo.cVideoId = item.videoId
                        newVideo.cDescription = item.description
                        newVideo.cChannelTitle = item.channelTitle
                        newVideo.cTitle = item.title
                        
                        newVideos += [newVideo]
                        
                    }
                    
                    self.coreData.saveContext()
                    
                    
                    //可以階層都印出來
                    //dump(response.items)
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
            dataTask.resume()

        }
        
    }
}
