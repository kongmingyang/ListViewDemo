//
//  CollectionViewCell.swift
//  ListViewDemo
//
//  Created by 55it on 2019/1/15.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit
//右侧collectionViewCell的自定义单元格
class CollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var pictureView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化标题文本标签
        titleLabel.frame = CGRect.init(x: 2, y: frame.size.width, width: frame.size.width - 4, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        //初始化产品图片视图
        pictureView.frame = CGRect(x: 8, y: 8, width: frame.size.width - 16, height: frame.size.width - 16)
        pictureView.contentMode = .scaleAspectFit
        contentView.addSubview(pictureView)
    }
    
    func setData(model: ColletionViewModel) {
        titleLabel.text = model.name
        pictureView.image = UIImage(named: model.picture)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
