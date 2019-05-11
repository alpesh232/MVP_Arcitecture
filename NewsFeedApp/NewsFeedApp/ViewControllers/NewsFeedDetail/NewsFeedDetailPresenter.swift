//
//  NewsFeedDetailPresenter.swift
//  NewsFeedApp
//
//  Created by LN-iMAC-001 on 09/01/19.
//  Copyright © 2019 infolabh. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol  NewsFeedDetailDelegate : class {
    
    func startLoading()
    func stopLoading()
    
    func updateImage(img : UIImage)
    func failUpdateImage(img : UIImage)
    
    func updateAutherName(name : String)
    func failUpdateAutherName()
    
    func updateTitle(title : String)
    func failUpdateTitle()
    
    func updateDescription(desc : String)
    func failUpdateDescription()
    
    func updatePublishAt(pubat : String)
    func failUpdatePublishAt()
    
    func updatePublishLink(linkURL : String)
    func failUpdatePublishLink()
    
    func presentWebBrowser(linkURL : URL)
    func failToPresentURL()
}


class NewsFeedDetailPresenter {

    var nfdDelegate : NewsFeedDetailDelegate?
    var artical : ArticalData
    
    init(artical : ArticalData) {
        self.artical = artical
    }
    
    func updateDetail() {
        
        if artical.urlToImage.isEmpty {
            nfdDelegate?.failUpdateImage(img: #imageLiteral(resourceName: "ic_placeholder"))
        }
        else {
            nfdDelegate?.startLoading()
            ImageDownloader.default.downloadImage(with: URL(string: artical.urlToImage)!, retrieveImageTask: nil, options: nil, progressBlock: nil) {[weak self] (img, error, url, data) in
                self?.nfdDelegate?.stopLoading()
                if let img = img {
                    self?.nfdDelegate?.updateImage(img: img)
                }
                else {
                    self?.nfdDelegate?.failUpdateImage(img: #imageLiteral(resourceName: "ic_placeholder"))
                }
                
            }
        }
        
        artical.author.isEmpty ? nfdDelegate?.failUpdateAutherName() : nfdDelegate?.updateAutherName(name: artical.author)
        artical.title.isEmpty ? nfdDelegate?.failUpdateTitle() : nfdDelegate?.updateTitle(title: artical.title)
        artical.author.isEmpty ? nfdDelegate?.failUpdateDescription() : nfdDelegate?.updateDescription(desc: artical.detail)
        artical.author.isEmpty ? nfdDelegate?.failUpdatePublishAt() : nfdDelegate?.updatePublishAt(pubat: artical.publishedAt)
        artical.author.isEmpty ? nfdDelegate?.failUpdatePublishLink() : nfdDelegate?.updatePublishLink(linkURL:artical.url)
    }
    
    func tapOnLink() {
        if let url = URL(string: artical.url) {
            if UIApplication.shared.canOpenURL(url) {
                nfdDelegate?.presentWebBrowser(linkURL:url)
            }
            else {
                nfdDelegate?.failToPresentURL()
            }
        }
        else {
            nfdDelegate?.failToPresentURL()
        }
    }
    
}
