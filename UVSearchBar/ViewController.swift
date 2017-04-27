//
//  ViewController.swift
//  UVSearchBar
//
//  Created by Bulat Khabirov on 23.11.16.
//  Copyright © 2016 UveeStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var searchController: UVSearchController!
    @IBOutlet weak var searchView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearch()
    }

    func configureSearch() {
        // Configure search controller and it's search bar with `DefaultSearchBarModel`.
        // You can create such structs to have some global-app style for a search bar written in one place
        // (this is exactly what `DefaultSearchBarModel` lets us do here)
        // as well as having different styles for different screens.
        searchController = UVSearchController(searchResultsController: nil, searchBarFrame: searchView.bounds,
                searchBarViewModel: DefaultSearchBarModel())

        // Don't use standard `delegate` and `searchBar` properties. Use `customSearchBar` and `customDelegate` instead.
        searchController.sourceController = self
        searchController.customSearchBar.placeholder = "Поиск города..."

        searchView.addSubview(searchController.customSearchBar)

        searchController.hidesNavigationBarDuringPresentation = true
    }
}

