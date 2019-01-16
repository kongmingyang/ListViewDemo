//
//  CollectionViewController.swift
//  ListViewDemo
//
//  Created by 55it on 2019/1/15.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    private let collectionCell = "collectionCell"
    private let  leftCell = "leftCell"
    private let collectionViewHeader = "collectionViewHeader"
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: 80, height: UIScreen.main.bounds.height)
        tableView.rowHeight = 55
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "LeftViewCell", bundle: nil), forCellReuseIdentifier: leftCell)
        
        
        return tableView
    }()
    
    lazy var flowLayout : UICollectionViewFlowLayout = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        //分组头悬停
       flowLayout.sectionHeadersPinToVisibleBounds = true
    let itemWidth = (UIScreen.main.bounds.size.width - 80 - 4 - 4) / 3
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        
        return flowLayout
    }()
    
    
    //右侧collectionView
    
    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 100, y: 84, width: UIScreen.main.bounds.width - 80 - 4, height: UIScreen.main.bounds.height - 64 - 4), collectionViewLayout: self.flowLayout)
    
        collectionView.delegate = self
       collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: collectionCell)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeader)
        return collectionView
    }()
    //左侧tableView数据
    var tableViewData = [String]()
    //右侧collectionView数据
    var collectionViewData = [[ColletionViewModel]]()
    
    var collectionViewIsScrollDown = true
    var collecetionViewLastOffsetY:CGFloat = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        for i in 1..<15 {
            tableViewData.append("分类\(i)")
        }
        for _ in tableViewData {
            var models = [ColletionViewModel]()
            for item in 1..<6{
                models.append(ColletionViewModel(name: "型号\(item)", picture: "1"))
            }
            self.collectionViewData.append(models)

        }
      
        view.addSubview(tableView)
        view.addSubview(collectionView)
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        
    }
    
}
extension CollectionViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: leftCell) as! LeftViewCell
        cell.titltLb.text = tableViewData[indexPath.row]
        return cell
        
    }
    //单元格选中时调用
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //右侧colletion自动滚动到顶部
        collectionViewScrollToTop(section: indexPath.row, animated: true)
        //左侧tableviewg将单元格滚动到顶部
        tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .top, animated: true)
        
    }
    //将右侧collecionView的指定分区自动滚动到最顶端
    func collectionViewScrollToTop(section:Int,animated:Bool) {
        
        let headerRect = collectionViewHeaderFrame(section: section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - collectionView.contentInset.top)
        collectionView.setContentOffset(topOfHeader, animated: animated)
        
    }
    //后获取collectionView的指定分区头的高度
    func collectionViewHeaderFrame(section:Int) -> CGRect {
        let indexPath = IndexPath(item: 0, section: section)
        let attributes = collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        guard let frameForFirstCell = attributes?.frame else {
            return .zero
        }
        return frameForFirstCell
    }
    
    
}

extension CollectionViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
        //获取分区数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData[section].count
    }
    
  func numberOfSections(in collectionView: UICollectionView) -> Int
  {
    return tableViewData.count
    }
    //返回自定义单元格
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell , for: indexPath) as! CollectionViewCell
        let model = collectionViewData[indexPath.section][indexPath.row]
        cell.setData(model: model)
        return cell
        
        
    }
    
   //返回自定义分区头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerveiw = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeader, for: indexPath) as! CollectionViewHeader
        headerveiw.titleLabel.text = tableViewData[indexPath.section]
        
        return headerveiw
        
    }
    
    //分区头尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 30)
        
        
    }
    //分头去即将显示是调用
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if !collectionViewIsScrollDown && (collectionView.isDragging || collectionView.isDecelerating) {
            tableView.selectRow(at: IndexPath(row: indexPath.section, section: 0), animated: true, scrollPosition: .top)
        }
        
    }
    
    //分区头即将消失时调用
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
          //如果是由用户手动滑动屏幕造成的向下滚动，那么左侧表格自动选中该分区对应的下一个分区的分类
        if collectionViewIsScrollDown && (collectionView.isDragging || collectionView.isDecelerating) {
            tableView.selectRow(at: IndexPath(row: indexPath.section + 1, section: 0), animated: true, scrollPosition: .top)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            collectionViewIsScrollDown = collecetionViewLastOffsetY < scrollView.contentOffset.y
            collecetionViewLastOffsetY = scrollView.contentOffset.y
        }
    }
    
}
