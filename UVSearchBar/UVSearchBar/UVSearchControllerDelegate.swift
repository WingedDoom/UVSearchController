//
// Created by Bulat Khabirov on 28.04.17.
// Copyright (c) 2017 UveeStudio. All rights reserved.
//

import Foundation

/// This is a custom delegate protocol for `UVSearchController`.
/// Please make your classes conform this protocol instead of `UISearchControllerDelegate` protocol
/// and do not use default `delegate` property of UVSearchBar, use `customDelegate` instead.
protocol UVSearchControllerDelegate {
    func didStartSearching()
    func didTapOnSearchButton()
    func didTapOnCancelButton()
    func didChangeSearchText(text: String)
}
