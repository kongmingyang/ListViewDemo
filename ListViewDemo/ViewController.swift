//
//  ViewController.swift
//  SwiftAniamtionDemo
//
//  Created by 55it on 2019/1/14.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollisionBehaviorDelegate {

    var collisionBehavior : UICollisionBehavior!
    var animator :UIDynamicAnimator!
    var layer : CAShapeLayer!
    var path : UIBezierPath!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let items  = ["控件碰撞","边界碰撞","控件和边界碰撞"]
        
        let balls = NSMutableArray.init()
        
        for item in 0...10 {
            let  ball = UIImageView.init(frame: CGRect(x:Int(arc4random()%160), y: item/3*60+100, width: 40, height: 40))
            ball.backgroundColor = UIColor.init(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
            ball.layer.cornerRadius = 20;
            ball.layer.masksToBounds = true
            self.view .addSubview(ball)
            balls .add(ball)
            
        }
        
        for i in 0...items.count-1 {
            let button = UIButton.init(frame: CGRect(x: i * 60+10, y: 30, width: 50, height: 30))
            button .setTitle(items[i], for: .normal);
            button .addTarget(self, action: #selector(moveAction(btntag:)), for: .touchUpInside)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            self.view .addSubview(button)
        }
        
        
        let animator = UIDynamicAnimator.init(referenceView: self.view)
        self.animator = animator
        
        //碰撞特性
        let collisionBehavior = UICollisionBehavior.init(items: balls as! [UIDynamicItem])
         collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .everything
        collisionBehavior.collisionDelegate = self
      
         self.animator .addBehavior(collisionBehavior)
         self.collisionBehavior = collisionBehavior;
       
    //弹性
        let dynamic = UIDynamicItemBehavior.init(items: balls as! [UIDynamicItem])
        dynamic.allowsRotation = true
        dynamic.elasticity = 0.6
        self.animator .addBehavior(dynamic)
        
        
        
        
        //bezierPath
        
        let path = UIBezierPath.init(ovalIn: CGRect(x: 50, y: 100, width: 200, height: 500))
        path.lineWidth = 1
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
    
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        layer.borderWidth = 1;
        layer.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.strokeColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        self.layer = layer;
        self.path = path;
        self.view.layer .addSublayer(layer)
       

        
    
    }

    @objc func moveAction(btntag:UIButton)  {
       
        self.collisionBehavior.collisionMode = .items
         self.collisionBehavior.addBoundary(withIdentifier:"path" as NSCopying, for: self.path)
//        self.collisionBehavior.addBoundary(withIdentifier: "path" as NSCopying, from: CGPoint.init(x: 100, y: 350), to: CGPoint.init(x: 120, y: 230))
    }
    
    public func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint){
        UIView .animate(withDuration: 1.0) {
           
            item1.center = CGPoint.init(x: 200, y: 300);
            item2.center = CGPoint.init(x: 300, y: 400);
        }
       
    
        print("444444")
        
    }
    
    public func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint){
        print("2222222")
        UIView .animate(withDuration: 1.0) {
            item.center = CGPoint.init(x:  Int(arc4random()%200), y: Int(arc4random()%200));
        }
    }

    
}

