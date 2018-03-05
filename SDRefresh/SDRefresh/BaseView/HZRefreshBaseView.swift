
//
//  HZRefreshBaseView.swift
//  SDRefresh
//
//  Created by 韩志峰 on 2018/3/3.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit
import Foundation
enum HZRefreshState: uint {
    case normal = 1 ///闲置状态
    case refreshing
    case pulling
    case noMoreData
    case willRefresh
}
/// 下拉刷新和上拉加载的闭包回调
typealias HZRefreshBlock = () -> Void
class HZRefreshBaseView: UIView {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
//    lazy var refreshingBlock: HZRefreshBlock = {
//
//    }()
    var refreshingBlock: HZRefreshBlock?
    var pullingPercent: CGFloat = 0
    var originalInsets: UIEdgeInsets?
    var state: HZRefreshState?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
        self.state = .normal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func placeSubViews(){
        
    }
    func scrollViewOffsetDidChange(changes:Dictionary<NSKeyValueChangeKey,Any>) {
        
    }
    func scrollViewGestureStateDidChange(changes:Dictionary<NSKeyValueChangeKey,Any>) {
        
    }
    func scrollViewContentSizeDidChange(changes:Dictionary<NSKeyValueChangeKey,Any>) {
        
    }
    func beginRefresh(){
        if self.window == nil{
            self.state = .willRefresh
            return
        }
        DispatchQueue.main.async {
            self.state = .refreshing
        }
    }
    func endRefresh(){
        UserDefaults.standard.setValue(Date(), forKey: "lastUpdateDate")
        DispatchQueue.main.async {
            self.state = .normal
        }
    }
    func prepare(){
        self.backgroundColor = UIColor.red
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.placeSubViews()
        if self.state == .willRefresh{
            DispatchQueue.main.async(execute: {
                self.state = .refreshing
            })
        }
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: superview)
        self.superview?.removeObserver(self, forKeyPath: "contentOffset")
        self.superview?.removeObserver(self, forKeyPath: "contentSize")
        if let scrollView = newSuperview as? UIScrollView{
            scrollView.panGestureRecognizer.removeObserver(self, forKeyPath: "state")
            self.scrollView = scrollView
            self.originalInsets = self.scrollView.contentInset
            self.scrollView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
            self.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
            self.scrollView.panGestureRecognizer.addObserver(self, forKeyPath: "state", options: NSKeyValueObservingOptions.new, context: nil)
            self.hz_width = self.scrollView.hz_width
            self.hz_x = 0
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset"{
            if let changes = change{
                self.scrollViewOffsetDidChange(changes: changes)
            }
        }else if keyPath == "state"{
            if let changes = change{
                self.scrollViewGestureStateDidChange(changes: changes)
            }
        }else if keyPath == "contentSize"{
            if let changes = change{
                self.scrollViewContentSizeDidChange(changes: changes)
            }
        }
    }
    
}
