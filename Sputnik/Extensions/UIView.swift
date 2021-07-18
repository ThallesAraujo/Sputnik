//
//  UIView.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 02/10/20.
//

import Foundation
import UIKit
import WebKit

extension UIView{
    
    func viewIgnoringSafeArea(_ view: UIView){
        
        self.translatesAutoresizingMaskIntoConstraints = false


        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)

        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
    func viewToTab() -> Tab{
        
        let tab = Tab()
        
        if let webView = self as? WKWebView{
            tab.title = webView.title
            tab.url = webView.url
            tab.webView = webView
            tab.tag = self.tag
        }
        
        return tab
        
    }
    
}
