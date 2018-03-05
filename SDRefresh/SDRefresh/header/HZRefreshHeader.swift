
//
//  HZRefreshHeader.swift
//  SDRefresh
//
//  Created by 韩志峰 on 2018/3/3.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import Foundation
import UIKit
class HZRefreshHeader: HZRefreshBaseView {
    class  func headerWithRefreshingBlock(block: @escaping HZRefreshBlock) -> HZRefreshHeader{
        //如果你在外层，是通过EOCRefreshStateHeaderView.headerWithRefreshingBlock
        //父类 *对象 = 子类 alloc init 没问题
        //子类 *对象 = 父类 alloc init 有问题   对象（父类对象）.子类方法  会崩溃
        let refreshHeader: HZRefreshHeader = self.init()
        refreshHeader.refreshingBlock = block
        return refreshHeader
    }
    override func placeSubViews() {
        super.placeSubViews()
        self.hz_height = 50
        self.hz_y = -self.hz_height
    }
    override func scrollViewOffsetDidChange(changes: Dictionary<NSKeyValueChangeKey, Any>) {
        //superView的offset
       let yOffset: CGFloat = self.scrollView.contentOffset.y
        //临界值
        let boundararyOffset: CGFloat = -self.hz_height - self.originalInsets!.top//self.originalInsets这个是scrollView的contentInset初始值
        let  alphaRatio: CGFloat = (-yOffset - self.originalInsets!.top) / (self.hz_height);
        self.pullingPercent = alphaRatio;
        if (self.state == .refreshing) {
            self.alpha = 1;
            return;
            
        }
        self.originalInsets = self.scrollView.contentInset
        if self.scrollView.isDragging{ //scrollView 正在被拖动
            self.alpha = alphaRatio;
            if (self.state == .normal && yOffset <= boundararyOffset) {
                
                self.state = .pulling;
                
            } else if (self.state == .pulling && yOffset > boundararyOffset)  {
                
                self.state = .normal;
                
            }
        }else{//你的superView：也就是scrollVIew停止拖动的时候
            if (self.state == .pulling) {  //此时是释放立即刷新的状态
                self.state = .refreshing;
            }
            self.alpha = alphaRatio;
        }
    }
    override var state: HZRefreshState?{
        didSet{
            if (state == .refreshing) {
                //悬停设置
                UIView.animate(withDuration: 0.2, animations: {
                    self.scrollView.hz_insetT = self.hz_height+self.originalInsets!.top; //
                }, completion: { (finished: Bool) in
                    if (self.refreshingBlock != nil) {
                        self.refreshingBlock!();
                    }
                })
                
            } else if (state == .normal) {
                //恢复默认值，也就是初始值
                UIView.animate(withDuration: 0.4, animations: {
                    self.scrollView.hz_insetT = self.originalInsets!.top;
                })
                
            }
            
        }
        
    }
}
