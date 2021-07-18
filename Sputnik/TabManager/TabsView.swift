//
//  TabsView.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 21/11/20.
//

import Foundation
import UIKit
import WebKit

protocol TabsViewDelegate{
    
    //var tabs: [Tab]? {get set}
    var delegatedView: UIView {get}
    
//    func didTapAddNewTab()
//
//    func didTapRemoveTab(atIndex index: Int)
    
}

class TabsView: UIView{
    
    var delegate: TabsViewDelegate?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabsList: UITableView!
    @IBOutlet weak var lblTabsCount: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        
       self.addSubview(self.contentView)
       self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
        self.contentView.frame = self.frame
        self.tabsList.register(UINib.init(nibName: "TabCell", bundle: .main), forCellReuseIdentifier: "tabCell")
    }
    
    func configureDelegate(){
        self.tabsList.delegate = self
        self.tabsList.dataSource = self
    }
    
    @IBAction func didTapNewTab(_ sender: Any) {
        let webView = WKWebView.init()
        if let url = URL.init(string: "https://google.com"){
            let request = URLRequest.init(url: url)
            webView.load(request)
            
            let tab = Tab.init(webView: webView)
            tab.webView = webView
            
            
            if let tabs = self.delegate?.delegatedView.subviews.map({$0.viewToTab()}), let mainView = self.delegate?.delegatedView{
                //tab.tag = tabs.count
                webView.tag = tabs.count
                webView.frame = mainView.frame
                mainView.bringSubviewToFront(webView)
            }
        }
        self.delegate?.delegatedView.addSubview(webView)
        self.delegate?.delegatedView.bringSubviewToFront(webView)
        self.tabsList.reloadData()
        self.didTapCloseView(self)
        
    }
    
    func generateTag(subviews: [UIView]?) -> Int{
        var biggest: Int = 0
        
        if let subviews = subviews{
            for view in subviews{
                if view.tag > biggest{
                    biggest = view.tag
                }
            }
        }
        
        return biggest + 1
        
    }
    
    @IBAction func didTapCloseView(_ sender: Any) {
        self.superview?.sendSubviewToBack(self)
    }
    
}

extension TabsView: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate?.delegatedView.subviews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tabCell", for: indexPath) as? TabCell, let tabs = self.delegate?.delegatedView.subviews.map({$0.viewToTab()}){
            
            print("Current Tab Amount -> \(tabs.count)")
            print("IndexPath \(indexPath)")
            let tab = Tab.init()
            
            if let webView = delegate?.delegatedView.subviews[indexPath.row] as? WKWebView{
                tab.webView = webView
                //cell.configureWebViewThumbnail(webView: webView)
            }
            
            //tab.tag = indexPath.row
            
            cell.configure(tab: tab, indexPath: indexPath)
            
            
            
            cell.closeTabClosure = {
                
                print("Tags of views: \(self.delegate?.delegatedView.subviews.map({$0.tag}))")
                
                print("will remove tab \(indexPath.item)")
                print("Current tabs (\(tabs.count))| \(tabs)")
                self.delegate?.delegatedView.viewWithTag(indexPath.row)?.removeFromSuperview()
//                self.mainVC?.view.viewWithTag(self.tabs?[indexPath.row].tag ?? 0)?.removeFromSuperview()
//                self.delegate?.didTapRemoveTab(atIndex: indexPath.row)
                self.tabsList.reloadData()
            }

            cell.closeButton.isHidden = tabs.count == 1
            let frame = CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60)
            cell.frame = frame
            return cell
        }else{
            return TabCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Entrou no didSelect")
        print("tds indices \(self.delegate?.delegatedView.subviews.map({$0.tag}))")
        print("Enderecos: \((self.delegate?.delegatedView.subviews as? [WKWebView])?.map({$0.title})))")
        
        self.delegate?.delegatedView.bringSubviewToFront((self.delegate?.delegatedView.subviews[indexPath.row])!)
        self.tabsList.reloadData()
        self.didTapCloseView(self)
//        if let tabView = self.delegate?.delegatedView.viewWithTag(indexPath.row){
//            self.superview?.sendSubviewToBack(self)
//            self.delegate?.delegatedView.bringSubviewToFront(tabView)
//            print("indice selecionado \(indexPath.row)")
//            print("Guia que foi encontrada: \(tabView.tag)")
//            print("Endereco da guia atual: \((tabView as? WKWebView)?.title)")
//        }
    }
    
    
    
 
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: 170, height: 170)
//    }
    
    
    
    
    
    
}
