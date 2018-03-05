
//
//  UIScrollViewRefreshExtension.swift
//  SDJGRefresh
//
//  Created by 韩志峰 on 2018/2/17.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

extension UIScrollView{
    var refreshHeader: HZRefreshHeader?{
        set{
            self.refreshHeader?.removeFromSuperview()
            self.insertSubview(newValue!, at: 0)
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "HZRefreshBaseHeader".hashValue)
            objc_setAssociatedObject(self, key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "HZRefreshBaseHeader".hashValue)
            return objc_getAssociatedObject(self, key) as? HZRefreshHeader
        }
    }
    /*
    var refreshFooter: HZRefreshFooter?{
        set{
            self.refreshFooter?.removeFromSuperview()
            self.insertSubview(newValue!, at: 0)
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "HZRefreshFooter".hashValue)
            objc_setAssociatedObject(self, key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "HZRefreshFooter".hashValue)
            return objc_getAssociatedObject(self, key) as? HZRefreshFooter
        }
    }
     */
}
