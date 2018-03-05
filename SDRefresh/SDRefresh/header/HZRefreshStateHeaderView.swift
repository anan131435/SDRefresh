
//
//  HZRefreshStateHeaderView.swift
//  SDRefresh
//
//  Created by 韩志峰 on 2018/3/3.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import Foundation
import UIKit
class HZRresheStateHeaderView: HZRefreshHeader {
    lazy var descriptionLable: UILabel = {
        let label = UILabel.refreshLabel()
        return label
    }()
    lazy var lastUpdatedTimeLabel: UILabel = {
        let label = UILabel.refreshLabel()
        return label
    }()
    override func prepare() {
        super.prepare()
        self.addSubview(self.descriptionLable)
        self.addSubview(self.lastUpdatedTimeLabel)
    }
    //就相当于调用了layoutSubViews，改变子view的frame
    override func placeSubViews() {
        super.placeSubViews()
        self.descriptionLable.frame = CGRect.init(x: 0, y: 0, width: self.hz_width, height: self.hz_height / 2)
        self.lastUpdatedTimeLabel.frame = CGRect.init(x: 0, y: self.hz_height / 2, width: self.hz_width, height: self.hz_height / 2)
    }
    private func getTipTitle() -> String{
        
        if let lastDate:Date = UserDefaults.standard.value(forKey: "lastUpdateDate") as? Date{
            let today: Date = Date()
            let calendar: Calendar = Calendar.current
            let comp1 = calendar.dateComponents([.day,.hour,.minute,.year,.month], from: today)
            let comp2 = calendar.dateComponents([.day,.hour,.minute,.year,.month], from: lastDate)
            let formatter = DateFormatter.init()
            if comp1.day == comp2.day{
                formatter.dateFormat = "HH:mm"
            }else if comp1.month == comp2.month{
                formatter.dateFormat = "dd HH:mm"
            }else if comp1.year == comp2.year{
                formatter.dateFormat = "MM-dd HH:mm"
            }else{
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
            }
            return formatter.string(from: lastDate)
        }else{
            return " 暂无刷新纪录"
        }
    }
    override var state: HZRefreshState?{
        didSet{
            if self.state == .normal{
                self.descriptionLable.text = "下拉进行刷新"
                //上次更新的时间
                self.lastUpdatedTimeLabel.text = self .getTipTitle()
            }else if self.state == .refreshing{
                self.descriptionLable.text = "正在刷新...";
            }else if self.state == .pulling{
                self.descriptionLable.text = "松开即将刷新";
            }
        }
    }
}
