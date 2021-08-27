//
//  Design.swift
//  News
//
//  Created by Naira Bassam on 25/08/2021.
//

import UIKit

extension UIView {
    func design (_ num: Int){
        self.layer.cornerRadius = self.frame.size.height / CGFloat(num)
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.7)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.25
        self.clipsToBounds = true
    }
    
    func roundTopCorners(){
        self.layer.cornerRadius = 25
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

extension UISearchBar {
    func rightBar() {
        self.searchTextPositionAdjustment = UIOffset(horizontal: -10.0, vertical: 0.0)
        let searchTextField = self.searchTextField
        let image:UIImage = UIImage(named: K.searchIcon)!
        let imageView = UIImageView(image: image)
        searchTextField.leftView = nil
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextField.ViewMode.always
        searchTextField.textAlignment = .right
        
    }
}

