//
//  NewsFeedListPresenter.swift
//  NewsFeedApp
//
//  Created by LN-iMAC-001 on 09/01/19.
//  Copyright © 2019 infolabh. All rights reserved.
//

import Foundation


protocol  NewsFeedListDelegate : class {
    func startLoading()
    func stopLoading()
    func setNewsFeedList(_ articals: [ArticalData])
    func setEmptyNewsFeedList()
}

class NewsFeedListPresenter {
    
    fileprivate let newsFeedListService:NewsFeedListService
    var nflDelegate : NewsFeedListDelegate?
    
    
    init(newsFeedListService : NewsFeedListService) {
        self.newsFeedListService = newsFeedListService
    }
    
    func getNewsFeedList() {
        nflDelegate?.startLoading()
        newsFeedListService.getNewsfeedDataFromAPI { [weak self] (dataArray) in
            self?.nflDelegate?.stopLoading()
            if let dataArray = dataArray {
                if dataArray.isEmpty {
                    self?.nflDelegate?.setEmptyNewsFeedList()
                }
                else {
                    self?.nflDelegate?.setNewsFeedList(dataArray)
                }
            }
            else {
                self?.nflDelegate?.setEmptyNewsFeedList()
            }
        }
    }
    
}
