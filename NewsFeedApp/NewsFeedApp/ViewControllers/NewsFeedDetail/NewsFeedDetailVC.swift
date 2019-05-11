//
//  NewsFeedDetailVC.swift
//  NewsFeedApp
//
//  Created by LN-iMAC-001 on 09/01/19.
//  Copyright © 2019 infolabh. All rights reserved.
//

import UIKit
import SVProgressHUD
import SafariServices
import Serrata

class NewsFeedDetailVC: UIViewController {
    
    @IBOutlet var lblAuthor: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblPublishAt: UILabel!
    @IBOutlet var btnLink: UIButton!
    
    @IBOutlet var authorView: UIStackView!
    @IBOutlet var titleView: UIStackView!
    @IBOutlet var descView: UIStackView!
    @IBOutlet var publishView: UIStackView!
    @IBOutlet var linkView: UIStackView!
    
    
    @IBOutlet var imgView: UIImageView!
    
    var articalData : ArticalData?
    
    fileprivate var nfdPresenter : NewsFeedDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data = self.articalData else {
            return
        }
        nfdPresenter = NewsFeedDetailPresenter(artical: data)
        nfdPresenter.nfdDelegate = self
        nfdPresenter.updateDetail()
        btnLink.titleLabel?.numberOfLines = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnImage))
        self.imgView.addGestureRecognizer(gesture)
    }
    
    
    
    @objc func tapOnImage() {
        let img = [self.imgView.image]
        
        let slideLeafs: [SlideLeaf] = img.enumerated().map { SlideLeaf(image: $0.1,
                                                                            title: " ",
                                                                            caption: "") }
        
        let slideImageViewController = SlideLeafViewController.make(leafs: slideLeafs,
                                                                    startIndex: 0,
                                                                    fromImageView: self.imgView)
        present(slideImageViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnClkLinkURL(_ sender: UIButton) {
        nfdPresenter.tapOnLink()
    }
    
}

//MARK: - Presenter delegate -

extension NewsFeedDetailVC : NewsFeedDetailDelegate {
    func presentWebBrowser(linkURL: URL) {
        let svc = SFSafariViewController(url: linkURL)
        present(svc, animated: true, completion: nil)
    }
    
    func failToPresentURL() {
        print("Not Able to load url")
    }
    
    func startLoading() {
        SVProgressHUD.show()
    }
    
    func stopLoading() {
        SVProgressHUD.dismiss()
    }
    
    func updateImage(img: UIImage) {
        imgView.contentMode = .scaleToFill
        imgView.image = img
    }
    
    func failUpdateImage(img: UIImage) {
        imgView.contentMode = .center
        imgView.image = img
    }
    
    func updateAutherName(name: String) {
        lblAuthor.text = name
    }
    
    func failUpdateAutherName() {
        authorView.isHidden = true
    }
    
    func updateTitle(title: String) {
        lblTitle.text = title
    }
    
    func failUpdateTitle() {
        titleView.isHidden = true
    }
    
    func updateDescription(desc: String) {
        lblDesc.text = desc
    }
    
    func failUpdateDescription() {
        descView.isHidden = true
    }
    
    func updatePublishAt(pubat: String) {
        lblPublishAt.text = pubat
    }
    
    func failUpdatePublishAt() {
        publishView.isHidden = true
    }
    
    func updatePublishLink(linkURL: String) {
        btnLink.setTitle(linkURL, for: UIControl.State.normal)
    }
    
    func failUpdatePublishLink() {
        linkView.isHidden = true
    }
    
    
}
