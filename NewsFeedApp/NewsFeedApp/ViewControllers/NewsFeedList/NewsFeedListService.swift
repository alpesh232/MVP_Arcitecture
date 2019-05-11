//
//  NewsFeedListService.swift
//  NewsFeedApp
//
//  Created by LN-iMAC-001 on 10/01/19.
//  Copyright © 2019 infolabh. All rights reserved.
//

import Foundation
import Alamofire

class NewsFeedListService {
    func getNewsfeedDataFromAPI(completionBLK : ((_ arrNewsFeed : [ArticalData]?)->())?) {
        if checkInternet() {
            Alamofire.request(apiURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                if let data = response.result.value as? NSDictionary {
                    if let dicData = self.convertStringToDictionary(self.jsonStringConvert(data).replacingOccurrences(of: "\"description\"", with: "\"detail\"")) {
                        let modObj = NewsDataModel(dictionary: dicData)
                        print(modObj)
                        let status : String = modObj.status
                        if status == "ok"{
                            if let data = modObj.articles {
                                completionBLK?(data)
                            }
                            else {
                                completionBLK?(nil)
                            }
                        }
                        else {
                            completionBLK?(nil)
                        }
                    }
                }
                else {
                    completionBLK?(nil)
                }
            }
        }
        else {
            appDelegate.AlertShowWithOK("No Internet", message: "Please check internet connection.")
        }
    }
    
    public func convertStringToDictionary(_ text: String) -> NSDictionary? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch _ as NSError {
                // print(error)
            }
        }
        return nil
    }
    public func jsonStringConvert(_ dict : AnyObject) -> String {
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            return  String(data: jsonData, encoding: String.Encoding.utf8)! as String
            
        } catch {
            return ""
        }
    }
}
