//
//  HistoryEntry.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 25/10/20.
//

import Foundation

let urlKey = "SiteEntry.url"
let siteNameKey = "SiteEntry.siteName"
let siteFaviconUrlKey = "SiteEntry.siteFaviconUrl"

//NSObject, NSCoding, NSSecureCoding

class SiteEntry {
    
    static var supportsSecureCoding: Bool = true
    
    var url: String?
    var siteName: String?
    var siteFaviconUrl: String?
    
//    func encode(with coder: NSCoder) {
//        coder.encode(self.url, forKey: urlKey)
//        coder.encode(self.siteName, forKey: siteNameKey)
//        coder.encode(self.siteFaviconUrl, forKey: siteFaviconUrlKey)
//
//    }
    
    init(url: String, siteName: String, siteFaviconUrl: String) {
        
        self.url = url
        self.siteName = siteName
        self.siteFaviconUrl = siteFaviconUrl
        
    }
//
//    required init?(coder: NSCoder) {
//        self.url = coder.decodeObject(forKey: urlKey) as? String
//        self.siteName = coder.decodeObject(forKey: siteNameKey) as? String
//        self.siteFaviconUrl = coder.decodeObject(forKey: siteFaviconUrlKey) as? String
//    }

    
    
    
}
