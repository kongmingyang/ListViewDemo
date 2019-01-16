//
//  LeftViewCell.swift
//  SwiftAniamtionDemo
//
//  Created by 55it on 2019/1/15.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

class LeftViewCell: UITableViewCell {


    @IBOutlet weak var titltLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//  titltLb.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
      titltLb.backgroundColor = selected ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    
    }
    
}
