//
//  HZRefreshNormalHeaderView.swift
//  SDRefresh
//
//  Created by 韩志峰 on 2018/3/3.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class HZRefreshNormalHeaderView: HZRresheStateHeaderView {
    lazy var arrowImageView: UIImageView = {
        let arrowView = UIImageView.init()
        arrowView.image = UIImage.init(named: "arrow")
        return arrowView
    }()
    lazy var loadView: UIActivityIndicatorView = {
        let indicaterView = UIActivityIndicatorView()
        indicaterView.tintColor = UIColor.lightGray
        return indicaterView
    }()
    override func prepare() {
        super.prepare()
        self.addSubview(self.arrowImageView)
        self.addSubview(self.loadView)
        self.loadView.isHidden = true
    }
    override func placeSubViews() {
        super.placeSubViews()
        let finalTextWidth: CGFloat = self.descriptionLable.textWidth() > self.lastUpdatedTimeLabel.textWidth() ? self.descriptionLable.textWidth() : self.lastUpdatedTimeLabel.textWidth()
        self.arrowImageView.hz_size = (self.arrowImageView.image?.size)!
        self.arrowImageView.center = CGPoint(x:(self.hz_width - finalTextWidth) / 4, y:self.hz_height / 2);
        self.loadView.hz_size = (self.arrowImageView.image?.size)!;
        self.loadView.center =  CGPoint(x:(self.hz_width - finalTextWidth) / 4, y:self.hz_height / 2);
    }
    override var state: HZRefreshState?{
        didSet{
            if self.state == .pulling{
                //1、角度为正，顺时针；角度为负，逆时针
                //3、基本按照最短路径来，如果顺时针、逆时针角度一样的，按顺时针来
                UIView.animate(withDuration: 0.2, animations: {
                    self.arrowImageView.transform = CGAffineTransform.init(rotationAngle: (CGFloat(0.0001 - Double.pi)))
                })
            }else if self.state == .normal{
                self.loadView.stopAnimating()
                UIView.animate(withDuration: 0.25, animations: {
                    self.arrowImageView.transform = CGAffineTransform.identity;
                }, completion: { (finish: Bool) in
                    self.arrowImageView.isHidden = false;
                    self.loadView.isHidden = true;
                })
            }else if self.state == .refreshing{
                self.arrowImageView.isHidden = true;
                self.loadView.isHidden = false;
                self.loadView.startAnimating()
            }
        }
    }
}
