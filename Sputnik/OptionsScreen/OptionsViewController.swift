//
//  OptionsViewController.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 25/10/20.
//

import UIKit

let bookmarkCellID = "BookmarkCell"
let historyCellID = "HistoryCell"
let noBookmarkCellID = "NoBookmarkCell"

class OptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var historyList: UITableView!
    @IBOutlet weak var bookmarkList: UICollectionView!
    
    var bookmarks: [SiteEntry]?
    var history: [SiteEntry]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookmarks = SiteEntriesManager.instance.getBookmarks()
        self.history = SiteEntriesManager.instance.getHistory()
    }
    
    @IBAction func didTapReloadPage(_ sender: Any) {
    }
    
    
    
    //MARK: -History
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: historyCellID) as? HistoryCell{
            
            if let hist = self.history?[indexPath.row]{
                cell.siteName.text = hist.siteName
                cell.siteUrl.text = hist.url
                //todo - setar imagem
            }
            
            return cell
        }else{
            return UITableViewCell.init()
        }
    }
    
    //MARK: -Bookmarks
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookmarks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookmarkCellID, for: indexPath) as? BookmarkCell{
            
            if let fav = self.bookmarks?[indexPath.row]{
                
                cell.siteName.text = fav.siteName
                
                //todo: setar imagem
            }
            
            return cell
        }else{
            return UICollectionViewCell.init()
        }
    }
    
    

}
