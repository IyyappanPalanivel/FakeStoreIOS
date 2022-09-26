//
//  CardView.swift
//  FakeStoreIOS
//
//  Created by Apple on 23/09/22.
//

import UIKit

class CardView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCornerAndShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCornerAndShadow()
    }
    
    func setCornerAndShadow(){
//        layer.cornerRadius = 15
//        layer.masksToBounds = true
//        layer.shadowRadius = 10
//        layer.shadowOpacity = 1.0
//        layer.shadowOffset = CGSize(width: 3, height: 3)
//        layer.shadowColor = UIColor.red.cgColor
        layer.cornerRadius = 15
        layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.75)
        layer.shadowRadius = 1.7
        layer.shadowOpacity = 0.45
    }
}
