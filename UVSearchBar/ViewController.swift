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
        print("needed frame - \(searchView.frame)")
        print("screen frame -\(UIScreen.main.bounds)")
        searchController = UVSearchController(searchResultsController: nil, searchBarFrame: searchView.bounds, searchBarViewModel: DefaultSearchBarModel())
        searchController.sourceController = self
        searchController.customSearchBar.placeholder = "Поиск города..."
        searchView.addSubview(searchController.customSearchBar)
        searchController.hidesNavigationBarDuringPresentation = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

