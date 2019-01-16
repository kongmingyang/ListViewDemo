
//
//  ListViewController.swift
//  SwiftAniamtionDemo
//
//  Created by 55it on 2019/1/15.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

class ListViewController: UIViewController{

    let leftCell = "leftCell"
    let rightCell = "rightCell"
    
    //懒加载左侧表格
    lazy var leftTableView : UITableView = {
        
        let leftTableView = UITableView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: -20, width: 80, height: UIScreen.main.bounds.height+20)
        leftTableView.rowHeight =  55;
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.separatorColor = UIColor.clear
        leftTableView.register(UINib.init(nibName: "LeftViewCell", bundle: nil), forCellReuseIdentifier: leftCell)
        return leftTableView
        
        
    }()
    //右侧表格
    lazy var rightTableview : UITableView = {
        let rightTableView = UITableView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.separatorStyle = .none
        rightTableView.frame = CGRect(x: 81, y: -20, width: UIScreen.main.bounds.width-80, height: UIScreen.main.bounds.height+20)
       rightTableView .register(UINib.init(nibName: "RightTableViewCell", bundle: nil), forCellReuseIdentifier: rightCell)
        rightTableView.rowHeight = 80;
        
        return rightTableView
    }()
    
    var leftTableData = [String]()
    var rightTableData = [[RightTableModel]]()
 
    var rightTableisScrollDown = true
    //右侧表格垂直偏移量
    var rightTableLastOffsetY : CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        for i in 1..<15 {
            self.leftTableData.append("分类\(i)")
        }
        for leftItem in leftTableData {
            var models = [RightTableModel]()
            for i in 1 ..< 5{
                models.append(RightTableModel(name: "\(leftItem) - 外卖菜品\(i)", money: String.init(describing: Float(i)), icon:i%2))
                
            }
            self.rightTableData.append(models)
            
        }
        
        view.addSubview(leftTableView)
       view.addSubview(rightTableview)
       leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        
        
    }
    
}

extension ListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return leftTableData.count
        }else{
            return rightTableData[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftCell, for: indexPath) as! LeftViewCell
           cell.titltLb.text = leftTableData[indexPath.row]
            return cell
            
        }else{
            
            let  cell  = tableView.dequeueReusableCell(withIdentifier: rightCell, for: indexPath) as!RightTableViewCell

            let model = self.rightTableData[indexPath.section][indexPath.row]
            cell.setMmodel(model: model)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if leftTableView == tableView {
            return nil
        }
        let headerView = RightTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        headerView.titleLabel.text = leftTableData[section]
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if leftTableView == tableView {
            return 0
        }
        return 50;
    }
    //分区头即将显示时调用
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //如果是右侧表格，且事是由用户手滑动屏幕造成的向上滚动
        //那么左侧表格自动算该分区对应的类
        if (rightTableview == tableView) && !rightTableisScrollDown && (rightTableview.isDragging || rightTableview.isDecelerating){
            leftTableView.selectRow(at: IndexPath(row: section, section: 0), animated: true, scrollPosition: .top)
            
        }
        
    }
    //分区头即将消失时调用
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        //如果是右侧表格，且是是由用户手动画栋屏幕造成的向下滚动
        //那么左侧表格自动选中该分区对应的下一个分区的分类
        if (rightTableview == tableView) && rightTableisScrollDown && (rightTableview.isDragging || rightTableview.isDecelerating) {
            leftTableView.selectRow(at: IndexPath(row: section + 1, section: 0), animated: true, scrollPosition: .top)
        }
        
    }
    //单元格选中时调用
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击的是左侧单元格时
        if leftTableView == tableView {
            rightTableview.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
            leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .top, animated: true)
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = scrollView as! UITableView
        if rightTableview == tableView {
            rightTableisScrollDown = self.rightTableLastOffsetY < scrollView.contentOffset.y
            rightTableLastOffsetY = scrollView.contentOffset.y
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if leftTableView == tableView {
            return  1
        }else{
            return leftTableData.count
        }
    }
    
}
