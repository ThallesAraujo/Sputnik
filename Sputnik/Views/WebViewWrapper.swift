//
//  WebPageView.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 23/08/20.
//

//Mais informações: https://www.youtube.com/watch?v=C5xxrCj8LC0

import Foundation
import WebKit
import SwiftUI
struct WebPageView: UIViewRepresentable{
    
    
    var webview = WKWebView()
    @State var calledUrls : [String] = []
    var url: String{
        didSet{
            let request = URLRequest(url: URL.init(string: url)!)
            webview.load(request)
        }
    }
    
    
    //Aqui pode-se retornar uma página de 404, erro de rede ou tela inicial, por exemplo
    
    func makeUIView(context: Context) ->  WKWebView {
        
        guard let url = URL(string: self.url) else{
            return WKWebView()
        }
    
        
        let request = URLRequest(url: url)
        webview.load(request)
        webview.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("contexto: \(context.environment)")
       
        if (calledUrls.filter({$0 == url}).count == 0){
            let request = URLRequest(url: URL.init(string: url) ?? URL.init(string: "https://google.com")!)
            uiView.load(request)
            calledUrls.append(url)
        }
    }
    
    
    
    
}

