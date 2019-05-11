//
//  ModelClass.swift
//  NewsFeedApp
//
//  Created by LN-iMAC-001 on 09/01/19.
//  Copyright © 2019 infolabh. All rights reserved.
//

import Foundation
import EVReflection

class NewsDataModel : EVObject {
    var status = ""
    var totalResults = ""
    var articles : [ArticalData]?
}

class ArticalData : EVObject {
    var source : SourceData?
    var author = ""
    var title = ""
    var detail = ""
    var url = ""
    var urlToImage = ""
    var publishedAt = ""
    var content = ""
}

class SourceData : EVObject {
    var id = ""
    var name = ""
}
