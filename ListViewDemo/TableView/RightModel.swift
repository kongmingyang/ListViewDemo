//
//  RightModel.swift
//  SwiftAniamtionDemo
//
//  Created by 55it on 2019/1/15.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

struct RightTableModel{
    var icon : Int?
    var name : String?
    var  money : String?
    init(name:String,money:String,icon:Int) {
        self.name = name
        self.icon = icon
        self.money = money
    }
}
