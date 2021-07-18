//
//  HistoryManager.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 25/10/20.
//

import Foundation
import UIKit

let favoritesConstant = "SiteEntriesManager.favorites"
let historyConstant = "SiteEntriesManager.history"
class SiteEntriesManager{
    
    private init(){
        print("Nova Instância do Site Entries Manager")
    }
    
    static var instance = SiteEntriesManager()
    
    func getBookmarks() -> [SiteEntry]{
        
        if let favs = UserDefaults.standard.array(forKey: favoritesConstant) as? [SiteEntry]{
            return favs
        }else{
            return []
        }
        
    }
    
    func getHistory() -> [SiteEntry]{
        if let hist = UserDefaults.standard.array(forKey: historyConstant) as? [SiteEntry]{
            return hist
        }else{
            return []
        }
    }
    
    func appendBookmark(bookmark: SiteEntry){
        
        if var favs = UserDefaults.standard.array(forKey: favoritesConstant) as? [SiteEntry]{
            favs.append(bookmark)
            UserDefaults.standard.setValue(favs, forKey: favoritesConstant)
        }else{
            var favs : [SiteEntry] = []
            favs.append(bookmark)
            UserDefaults.standard.setValue(favs, forKey: favoritesConstant)
        }
        
        UserDefaults.standard.synchronize()
    }
    
    func addHistoryEntry(entry: SiteEntry){
        
        if var hist = UserDefaults.standard.array(forKey: historyConstant) as? [SiteEntry]{
            hist.append(entry)
            UserDefaults.standard.setValue(hist, forKey: historyConstant)
        }else{
            var hist : [SiteEntry] = []
            hist.append(entry)
            UserDefaults.standard.setValue(hist, forKey: historyConstant)
        }
        
        UserDefaults.standard.synchronize()
        
    }
    
    
    

}
