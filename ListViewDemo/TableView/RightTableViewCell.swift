//
//  RightTableViewCell.swift
//  SwiftAniamtionDemo
//
//  Created by 55it on 2019/1/15.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
   
    @IBOutlet weak var moneyLb: UILabel!
    @IBOutlet weak var shopName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
  
        
        
    }
    func setMmodel(model:RightTableModel)  {
        
//        self.icon.image = UIImage.animatedImageNamed(String.init(describing: model.icon), duration: 1)
        self.moneyLb.text = model.money
        self.shopName.text = model.name
    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
        
        
    }
    
}
