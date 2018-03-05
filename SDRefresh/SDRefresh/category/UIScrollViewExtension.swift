//
//  UIScrollViewExtension.swift
//  SDJGRefresh
//
//  Created by 韩志峰 on 2018/2/17.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

extension UIScrollView{
   
    /// top:UIEdgeInsets
    var hz_insetT: CGFloat{
        set{
            var  inset: UIEdgeInsets = self.contentInset;
            inset.top = newValue;
            self.contentInset = inset;
        }
        get {
            return self.contentInset.top
        }
    }
    /// bottom:UIEdgeInsets
    var hz_insetB: CGFloat{
        set {
            var inset: UIEdgeInsets = self.contentInset
            inset.bottom = newValue
            self.contentInset = inset
         }
        get {
            return self.contentInset.bottom
        }
    }
    /// left :UIEdgeInsets
    var hz_insetL: CGFloat{
        set {
            var inset: UIEdgeInsets = self.contentInset
            inset.left = newValue
            self.contentInset = inset
        }
        get{
            return self.contentInset.left
        }
    }
    /// right:UIEdgeInsets
    var hz_insetR: CGFloat{
        set {
            var inset: UIEdgeInsets = self.contentInset
            inset.right = newValue
            self.contentInset = inset
        }
        get{
            return self.contentInset.right
        }
    }
    /// contentWidth 内容宽度
    var hz_contentWidth: CGFloat{
        set {
            var contentSize: CGSize = self.contentSize
            contentSize.width = newValue
            self.contentSize = contentSize
        }
        get{
            return self.contentSize.width
        }
    }
    /// contentHeight 内容高度
    var hz_contentH: CGFloat{
        set{
            var contentSize: CGSize = self.contentSize
            contentSize.height = newValue
            self.contentSize = contentSize
        }
        get{
            return self.contentSize.height
        }
    }
    //contentOffset: CGPoint 纵坐标偏移量
    var hz_offsetY: CGFloat{
        set{
            var offset: CGPoint = self.contentOffset
            offset.y = newValue
            self.contentOffset = offset
        }
        get{
            return self.contentOffset.y
        }
    }
    /// contentOffset: CGPoint 横坐标偏移量
    var hz_offsetX: CGFloat{
        set{
            var offset: CGPoint = self.contentOffset
            offset.x = newValue
            self.contentOffset = offset
        }
        get {
            return self.contentOffset.x
        }
    }
    
}

