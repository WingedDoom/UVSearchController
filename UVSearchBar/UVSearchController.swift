//
//  UVSearchController.swift
//  UVSearchBar
//
//  Created by Bulat Khabirov on 27.11.16.
//  Copyright © 2016 UveeStudio. All rights reserved.
//

import UIKit

class UVSearchController: UISearchController, UISearchBarDelegate
{
    
    
    /// A custom Search bar. Use this intead of `searchBar` property.
    var customSearchBar: UVSearchBar!
    
    /// A custom delegate. Use this instead of `delegate`
    var customDelegate: UVSearchControllerDelegate?
    
    /// A reference to view controller, which hosts the search controller
    var sourceController: UIViewController?
    
    init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarViewModel: UVSearchBarPresentable) {
        super.init(searchResultsController: searchResultsController)
        customSearchBar = UVSearchBar(frame: searchBarFrame, model: searchBarViewModel)
        customSearchBar.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        customDelegate?.didStartSearching()
        searchBar.setShowsCancelButton(true, animated: true)
        sourceController?.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDelegate?.didTapOnSearchButton()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDelegate?.didTapOnCancelButton()
        searchBar.setShowsCancelButton(false, animated: true)
        sourceController?.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchBar.text!.isEmpty {
            self.active = true
        } else {
            self.active = false
        }
        
        customDelegate?.didChangeSearchText(searchText)
    }
}

protocol UVSearchControllerDelegate {
    func didStartSearching()
    func didTapOnSearchButton()
    func didTapOnCancelButton()
    func didChangeSearchText(text: String)
}
