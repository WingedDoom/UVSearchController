//
//  UVSearchBar.swift
//  UVSearchBar
//
//  Created by Bulat Khabirov on 23.11.16.
//  Copyright © 2016 UveeStudio. All rights reserved.
//

import UIKit


/**
 UVSearchBar is a customizable version of UISearchBar. It inherits UISearchBar, so
 all the UISearchBar functionality and protocols should work, adding more customizing abilities
*/
@IBDesignable class UVSearchBar: UISearchBar {
    // MARK: - Properties
    @IBInspectable var textFieldFont: UIFont = UIFont.systemFontOfSize(20)
    @IBInspectable var textFieldTextColor: UIColor = UIColor.blackColor()
    @IBInspectable var searchIcon: UIImage? = UIImage(named: "searchIcon")
    @IBInspectable var textFieldEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 16,
                                                                        left: 16,
                                                                        bottom: 16,
                                                                        right: 16)
    @IBInspectable var textFieldBackgroundColor: UIColor = UIColor.whiteColor()
    
    /// A custom cancel button
    var cancelButton: UIButton {
        if let button = self.viewWithTag(315) as? UIButton {
            return button
        } else {
            let button = UIButton(type: .System)
            button.setTitle(NSBundle(identifier: "com.apple.UIKit")?.localizedStringForKey("Cancel", value: "", table: nil), forState: .Normal)
            button.sizeToFit()
            button.addTarget(self, action: #selector(self.cancelButtonTapped),
                             forControlEvents: .TouchUpInside)
            button.tag = 315
            button.frame.origin = CGPoint(x: frame.width - 8 - button.frame.width,
                                          y: frame.height/2 - button.frame.height/2)
            button.tintColor = self.tintColor
            return button
        }
    }
    
    
    // MARK: - Custom drawing
    override func drawRect(rect: CGRect) {
        defer {
            super.drawRect(rect)
        }
        
        guard let searchTextField = self.searchTextField else {
            print("Couldn't find search text field of the search bar! Perhaps the API changed?")
            return
        }
        
        let insets = textFieldEdgeInsets
        let textFieldFrame = CGRect(x: insets.right,
                                    y: insets.top,
                                    width: frame.width - insets.left - insets.right,
                                    height: frame.height - insets.top - insets.bottom)
        
        searchTextField.frame = textFieldFrame
        searchTextField.textColor = textFieldTextColor
        searchTextField.font = textFieldFont
        searchTextField.backgroundColor = textFieldBackgroundColor
        if let icon = searchIcon {
            searchTextField.leftView = UIImageView(image: icon)
        }
    }
    
    // MARK: - Configuretion with View Model
    func configure(withViewModel model: UVSearchBarPresentable) {
        self.textFieldFont = model.searchFont
        self.searchIcon = model.searchIcon
        self.textFieldTextColor = model.searchTextColor
        self.textFieldEdgeInsets = model.searchTextFieldEdgeInsets
        self.searchTextField?.backgroundColor = model.searchFieldBackgroundColor
        self.backgroundColor = model.searchBarBackgroundColor
        self.tintColor = model.searchBarTintColor
        
        self.searchBarStyle = .Minimal
    }
    
    
    // MARK: - Initialization
    init(frame: CGRect, model: UVSearchBarPresentable) {
        super.init(frame: frame)
        self.frame = frame
        configure(withViewModel: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        configure(withViewModel: DefaultSearchBarModel())
    }
    
    
    // MARK: - Overridden cancel button
    override func setShowsCancelButton(showsCancelButton: Bool, animated: Bool) {
        let duration = animated ? 0.3 : 0
        let cancelButton = self.cancelButton
        
        let movedRightTransform = CGAffineTransformMakeTranslation(cancelButton.frame.width, 0)
        
        cancelButton.transform = showsCancelButton ? movedRightTransform : CGAffineTransformIdentity
        cancelButton.alpha = showsCancelButton ? 0.25 : 1
        
        if showsCancelButton && !self.subviews.contains(cancelButton)  { self.addSubview(cancelButton) }
        
        UIView.animateWithDuration(duration, animations: {
            let adjustingAmount = cancelButton.frame.width
            let textField = self.searchTextField
            let insets = self.textFieldEdgeInsets
            let baseWidth = self.frame.width - insets.left - insets.right
            
            if showsCancelButton {
                textField?.frame.size.width = baseWidth - adjustingAmount - 8
                cancelButton.transform = CGAffineTransformIdentity
                cancelButton.alpha = 1
            } else {
                textField?.frame.size.width = baseWidth
                cancelButton.transform = movedRightTransform
                cancelButton.alpha = 0.25
            }
        }, completion: { success in
            if !showsCancelButton {
                cancelButton.removeFromSuperview()
            }
        })
    }
    
    func cancelButtonTapped() {
        self.delegate?.searchBarCancelButtonClicked?(self)
    }
}

struct DefaultSearchBarModel: UVSearchBarPresentable {
    var searchFont: UIFont {
        return UIFont.systemFontOfSize(20)
    }
    
    var searchTextColor: UIColor {
        return UIColor.blackColor()
    }
    
    var searchIcon: UIImage {
        return UIImage(named: "searchIcon")!
    }
    var searchTextFieldEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    var searchFieldBackgroundColor: UIColor {
        return UIColor.grayColor()
    }
    
    var searchBarBackgroundColor: UIColor {
        return UIColor.whiteColor()
    }
    
    var searchBarTintColor: UIColor {
        return UIColor.blackColor()
    }
}

protocol UVSearchBarPresentable {
    var searchFont: UIFont { get }
    var searchTextColor: UIColor { get }
    var searchIcon: UIImage { get }
    var searchTextFieldEdgeInsets: UIEdgeInsets { get }
    var searchFieldBackgroundColor: UIColor { get }
    var searchBarBackgroundColor: UIColor { get }
    var searchBarTintColor: UIColor { get }
}


// MARK: - Neccessary extensions
extension UISearchBar {
    
    /// This is a computed property, which returns UISearchBar's searchTextField (if finds one)
    var searchTextField: UITextField? {
        func findTextFieldInView(view: UIView) -> UITextField? {
            if let textField = view as? UITextField {
                return textField
            }
            
            for subview in view.subviews {
                if let textField = findTextFieldInView(subview) {
                    return textField
                }
            }
            
            return nil
        }
        
        return findTextFieldInView(self)
    }
}
