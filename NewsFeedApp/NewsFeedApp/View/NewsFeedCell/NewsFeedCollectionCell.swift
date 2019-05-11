//
//  NewsFeedCollectionCell.swift
//  NewsFeedApp
//
//  Created by LN-iMAC-001 on 09/01/19.
//  Copyright © 2019 infolabh. All rights reserved.
//

import UIKit
import Kingfisher

class NewsFeedCollectionCell: UICollectionViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var bgView: UIView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        bgView.layer.cornerRadius = 12.0
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.borderWidth = 0.5
        
        imgView.layer.cornerRadius = 12.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImage(imgStr : String) {
        if !imgStr.isEmpty {
            let resource = ImageResource(downloadURL: URL(string: imgStr)!)
            imgView.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "ic_placeholder"), options: [.keepCurrentImageWhileLoading], progressBlock: nil) { (img, error, type, ur) in
                if let img  = img {
                    self.imgView.image = img
                }
            }
        }
        else {
            imgView.image = #imageLiteral(resourceName: "ic_placeholder")
        }
    }
    
}
