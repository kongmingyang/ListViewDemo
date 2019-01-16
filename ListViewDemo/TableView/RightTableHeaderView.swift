
//
//  RightTableHeaderView.swift
//  SwiftAniamtionDemo
//
//  Created by 55it on 2019/1/15.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

class RightTableHeaderView: UIView {

    var titleLabel : UILabel!
    
 
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabel = UILabel.init()
        titleLabel.frame = CGRect(x:10, y: 0, width: 200, height: 39)
        titleLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
       addSubview(titleLabel)
        let line = UIView.init()
        line.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        line.frame = CGRect(x: 0, y: 39, width: UIScreen.main.bounds.width, height: 1)
        addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
