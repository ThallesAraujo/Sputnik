//
//  MainVC.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 02/10/20.
//

import UIKit
import WebKit

class MainViewController: UIViewController, WKUIDelegate, UITextFieldDelegate, WKNavigationDelegate {
    

    @IBOutlet weak var mainBar: UIView!
    @IBOutlet weak var statusBarOverlayHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainBottomBarBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var tabsView: TabsView!
    
    
    //MARK: Action Buttons
    
    @IBOutlet weak var prevPageButton: UIButton!
    
    @IBOutlet weak var optionsButton: UIButton!
    
    @IBOutlet weak var tabsPageBtn: UIButton!
    
    @IBOutlet weak var nextPageBtn: UIButton!
    
    @IBOutlet weak var searchUrlTextField: CustomTextField!
    
    @IBOutlet weak var pageLoadingProgressView: UIProgressView!
    
    private var estimatedProgressObserver: NSKeyValueObservation?
    private var urlObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabsView.delegate = self
        
        
        if let url = URL.init(string: "https://google.com"){
            
            
            
            var webView = WKWebView.init(frame: self.mainView.frame)
            webView = self.setupWebView(webView: webView)
            let request = URLRequest.init(url: url)
            webView.load(request)
            let currentTab = WKWebView.init()
            self.mainView.addSubview(webView)
            self.setupObservers()
            
            let tab = Tab.init(webView: currentTab)
            tab.tag = self.mainView.subviews.count + 1
            
            self.addBlurredStatusBar()
            self.statusBarOverlayHeight.constant = UIHelper.getStatusBarHeight()
            currentTab.load(request)
            //self.updateView(tabIndex: 0)
            
//            let entry = SiteEntry.init(url: String.init(describing:  webView.url?.absoluteString), siteName: String.init(describing: webView.title), siteFaviconUrl: "\(String(describing: webView.url?.absoluteString))/favicon")
//            
//            SiteEntriesManager.instance.addHistoryEntry(entry: entry)
            
        }
        
        if let navigation = self.navigationController{
            navigation.setNavigationBarHidden(true, animated: false)
        }
        
        
        
        self.configureObjcSelectors()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabsView.configureDelegate()
    }


   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.searchUrlTextField.resignFirstResponder()
        
        guard var searchOrUrl = textField.text else{
            return true
        }
        
        if searchOrUrl.contains("."){
            if !(searchOrUrl.starts(with: "http")){
                searchOrUrl = "https://\(searchOrUrl)"
            }
        }else{
            let terms = searchOrUrl.replacingOccurrences(of: " ", with: "+")
            searchOrUrl = "https://www.google.com/search?q=\(terms)"
            print("URL Final de busca -> \(searchOrUrl)")
        }
        
        
        
        guard let url = URL.init(string: searchOrUrl) else{
            return true
        }
        
        
        
        let request = URLRequest.init(url: url)
        var webPage = WKWebView.init(frame: self.mainView.frame)
        webPage = self.setupWebView(webView: webPage)
        webPage.load(request)
        if self.mainView.subviews.count > 0{
            self.mainView.subviews[0].removeFromSuperview()
        }
        self.mainView.addSubview(webPage)
        self.mainView.setNeedsDisplay()
        self.setupObservers()
        let tab = Tab.init(webView: webPage)
        
        return true
        
    }
    
    private func setupEstimatedProgressObserver() {
        if let webView = self.mainView.subviews[0] as? WKWebView{
            estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webPage, _ in
                
                let progresso = Float(webPage.estimatedProgress)
                
                self?.pageLoadingProgressView.isHidden = (progresso < 0 || progresso == 1.0)
                
                self?.pageLoadingProgressView.progress = Float(webPage.estimatedProgress)
                
                if (progresso > 0){
                    
                   
                    

                }
            }
        }
    }
    
    
    func setupChangedUrl(){
        
        if let webView = self.mainView.subviews[0] as? WKWebView{
            self.urlObserver = webView.observe(\.url, changeHandler: {webPage, newURL in
                
                
                
               
                   
                    let currentTab = Tab.init(webView: webPage)
                    currentTab.url = webPage.url
                    
                   
                    self.searchUrlTextField.text = currentTab.url?.absoluteString
                
            })
        }
    }
    
    
    
    
    @objc func goToActionsMenu(_ sender: Any){
        self.performSegue(withIdentifier: "goToOptionsMenu", sender: self)
    }
    
    func setupWebView(webView: WKWebView) -> WKWebView {
        
        webView.navigationDelegate = self
        
        let statusBarHeight = UIHelper.getStatusBarHeight()
        
        let insets = UIEdgeInsets.init(top: statusBarHeight, left: 0, bottom: 100, right: 0)
        
        webView.scrollView.contentInset = insets
        
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.setValue(insets, forKey: "_obscuredInsets")
        webView.setValue(true, forKey: "_haveSetObscuredInsets")
        
        return webView
    }
    
    func setupObservers(){
        self.setupChangedUrl()
        self.setupEstimatedProgressObserver()
    }
    
    
    func configureObjcSelectors(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification){
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        self.mainBottomBarBottomMargin.constant = keyboardSize.height + 5
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        self.mainBottomBarBottomMargin.constant = 10
    }
    
    @IBAction func didTapNextPage(_ sender: Any) {
        
//        if let webView = self.mainView.subviews[TabManager.instance.getCurrentTabIndex() - 1] as? WKWebView{
//            webView.goForward()
//        }
        
    }
    
    @IBAction func didTapPreviousPage(_ sender: Any) {
        
//        if let webView = self.mainView.subviews[TabManager.instance.getCurrentTabIndex() - 1] as? WKWebView{
//            webView.goBack()
//        }
        
    
    }
    
   func didTapReloadPage(_ sender: Any) {
        //self.updateView(tabIndex: TabManager.instance.getCurrentTabIndex())
    }
    
    
    func updateView(tabIndex: Int){
        if let webView = self.mainView.subviews[tabIndex] as? WKWebView{
            self.mainView.bringSubviewToFront(webView)
        }
    }
    
    
    @IBAction func didTapShowTabs(_ sender: Any) {
        
        self.view.bringSubviewToFront(self.tabsView)
        
    }
    
    
    
    

    
}
extension MainViewController: TabsViewDelegate{
    
    var delegatedView: UIView{
        return self.mainView
    }
    
}
