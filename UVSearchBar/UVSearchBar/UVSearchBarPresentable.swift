//
// Created by Bulat Khabirov on 28.04.17.
// Copyright (c) 2017 UveeStudio. All rights reserved.
//

import UIKit

/// A view appearance configuration for the UVSearchBar
protocol UVSearchBarPresentable {
    var searchFont: UIFont { get }
    var searchTextColor: UIColor { get }
    var searchIcon: UIImage { get }
    var searchTextFieldEdgeInsets: UIEdgeInsets { get }
    var searchFieldBackgroundColor: UIColor { get }
    var searchBarBackgroundColor: UIColor { get }
    var searchBarTintColor: UIColor { get }
}
