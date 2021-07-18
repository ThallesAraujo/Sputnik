//
//  Tab.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 07/10/20.
//

import Foundation
import WebKit
class Tab{
    
    var url: URL?
    var title: String?
    var webView: WKWebView = WKWebView.init()
    var tag: Int?
    
    init(){}
    
    init(webView: WKWebView){
        self.url = webView.url
        self.title = webView.title
        self.webView = webView
    }
    
}
