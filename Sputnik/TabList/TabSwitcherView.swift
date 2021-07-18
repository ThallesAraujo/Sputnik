//
//  TabSwitcherView.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 17/10/20.
//

//import Foundation
//import UIKit
//class TabSwitcherView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//
//    @IBOutlet weak var tabList: UICollectionView!
//    @IBOutlet weak var contentView: UIView!
//    var tabs: [Tab]?
//
//
//    override init(frame: CGRect) {
//            super.init(frame: frame)
//            commonInit()
//        }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.commonInit()
//    }
//
//        func commonInit() {
//            Bundle.main.loadNibNamed("TabSwitcherView", owner: self, options: nil)
//                    guard let content = contentView else { return }
//                    content.frame = self.bounds
//                    content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//                    self.addSubview(content)
//        }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.tabs!.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath) as? TabCell, let tabs = self.tabs{
//            cell.configure(tab: (self.tabs?[indexPath.row])!)
//            let webView = self.tabs![indexPath.row].webView
//            if !(webView.isLoading){
//                cell.configureWebViewThumbnail(webView: webView)
//            }
//            cell.closeTabClosure = {
//                self.tabs?.remove(at: indexPath.row)
//                if (TabManager.instance.getCurrentTabIndex() == indexPath.row){
//
//                    TabManager.instance.setCurrentTabIndex(index: 0)
//                    TabManager.instance.setTabs(tabs: self.tabs!)
//                    var webView = self.tabs![0].webView
////                    webView = self.mainVC!.setupWebView(webView: webView)
////                    self.mainVC?.mainView.subviews[0].removeFromSuperview()
////                    self.mainVC?.mainView.addSubview(webView)
//
//                }
//                if ((TabManager.instance.getCurrentTabIndex()) > indexPath.row){
//                    TabManager.instance.setCurrentTabIndex(index: (TabManager.instance.getCurrentTabIndex()) - 1)
//                }
//                self.tabList.reloadData()
//
//            }
//
//
//
//
//            cell.closeTabButton.isHidden = tabs.count == 1
//
//            print("Listando guias: guia atual é a \(TabManager.instance.getCurrentTabIndex())")
//
//            if (TabManager.instance.getCurrentTabIndex() == indexPath.row){
//                cell.layer.borderWidth = 2
//                cell.layer.borderColor = UIColor.systemGreen.cgColor
//            }
//
//            return cell
//        }else{
//            return TabCell.init()
//        }
//
//    }
//
//
//    @IBAction func didTapAddTab(_ sender: Any) {
//    }
//
//    @IBAction func didTapCloseTabSwitcher(_ sender: Any) {
//    }
//
//
//
//}
//
