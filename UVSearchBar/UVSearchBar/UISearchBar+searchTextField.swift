//
// Created by Bulat Khabirov on 28.04.17.
// Copyright (c) 2017 UveeStudio. All rights reserved.
//

import UIKit

extension UISearchBar {

    /// This is a computed property, which returns UISearchBar's searchTextField (if finds one)
    var searchTextField: UITextField? {
        func findTextFieldInView(view: UIView) -> UITextField? {
            if let textField = view as? UITextField {
                return textField
            }

            for subview in view.subviews {
                if let textField = findTextFieldInView(view: subview) {
                    return textField
                }
            }

            return nil
        }

        return findTextFieldInView(view: self)
    }
}
