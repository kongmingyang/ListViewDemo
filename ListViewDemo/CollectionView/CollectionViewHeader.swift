//
//  CollectionViewHeader.swift
//  ListViewDemo
//
//  Created by 55it on 2019/1/15.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
    
     var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置分区头背景色
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 30)
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    
}
