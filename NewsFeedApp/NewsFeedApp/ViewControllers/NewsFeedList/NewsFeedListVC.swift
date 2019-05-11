//
//  NewsFeedListVC.swift
//  NewsFeedApp
//
//  Created by LN-iMAC-001 on 09/01/19.
//  Copyright © 2019 infolabh. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

class NewsFeedListVC: UIViewController {

    
    @IBOutlet var collectionNewsFeed: UICollectionView!
    @IBOutlet var lblNoData: UILabel!
    
    fileprivate let newsFeedListPresenter = NewsFeedListPresenter(newsFeedListService: NewsFeedListService())
    fileprivate var arrNewsFeedArticals = [ArticalData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeedListPresenter.nflDelegate = self
        let nib = UINib(nibName: "NewsFeedCollectionCell", bundle: nil)
        collectionNewsFeed.register(nib, forCellWithReuseIdentifier: "NewsFeedCollectionCell")
        
        guard let layout = collectionNewsFeed.collectionViewLayout as? PinterestLayout else {
            return
        }
        layout.delegate = self
        
        newsFeedListPresenter.getNewsFeedList()
        // Do any additional setup after loading the view.
    }
}

//MARK: - Presenter delegate - 
extension NewsFeedListVC : NewsFeedListDelegate {
    func startLoading() {
        SVProgressHUD.show()
    }
    
    func stopLoading() {
        SVProgressHUD.dismiss()
    }
    
    func setNewsFeedList(_ articals: [ArticalData]) {
        lblNoData.isHidden = true
        arrNewsFeedArticals = articals
        collectionNewsFeed.reloadData()
    }
    
    func setEmptyNewsFeedList() {
        lblNoData.isHidden = false
        appDelegate.AlertShowWithOK("Error", message: "Something went wrong")
    }
    
    func calculateHeight (str : String, font : UIFont, widhth : CGFloat) -> CGFloat {
        return str.heightOfString(font, width: widhth)
    }
}

//MARK: - collectionview delegate -
extension NewsFeedListVC : UICollectionViewDelegate, UICollectionViewDataSource, PinterestLayoutDelegate
{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let obj = arrNewsFeedArticals[indexPath.item]
        let strheight = calculateHeight(str: obj.title, font: UIFont.systemFont(ofSize: 15.0), widhth: collectionView.frame.size.width/2-36)
        return strheight + 175.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrNewsFeedArticals.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFeedCollectionCell", for: indexPath) as! NewsFeedCollectionCell
        let obj = arrNewsFeedArticals[indexPath.item]
        cell.lblTitle.text = obj.title
        cell.setImage(imgStr: obj.urlToImage)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controll = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeedDetailVC") as! NewsFeedDetailVC
        controll.articalData = arrNewsFeedArticals[indexPath.item]
        self.navigationController?.pushViewController(controll, animated: true)
    }
}
