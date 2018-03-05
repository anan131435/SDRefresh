//
//  UIlabelExtension.swift
//  SDJGRefresh
//
//  Created by 韩志峰 on 2018/2/17.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit
import Foundation
extension UILabel{
    class func refreshLabel() -> UILabel{
        let label = UILabel.init()
        label.textColor = UIColor.blue
        label.textAlignment = .center
        label.autoresizingMask = UIViewAutoresizing.flexibleWidth
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }
    func textWidth() -> CGFloat{
        if let text = self.text {
            let title: NSString = text as NSString
            let size: CGSize = title.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)])
            return size.width
        }else{
            return 0
        }
        
    }
}
