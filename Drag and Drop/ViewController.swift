//
//  ViewController.swift
//  Drag and Drop
//
//  Created by AKIL KUMAR THOTA on 12/16/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITableViewDragDelegate,UITableViewDropDelegate {
    
    
    let leftTableView = UITableView()
    let rightTableView = UITableView()
    
    var leftArray  = [String](repeating: "left", count: 5)
    var rightArray = [String](repeating: "right", count: 5)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intianSetup()
        
    }
    
    fileprivate func intianSetup() {
        leftTableView.delegate = self
        rightTableView.delegate = self
        
        leftTableView.dataSource = self
        rightTableView.dataSource = self
        
        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        leftTableView.frame = CGRect(x: 0, y: 50, width: 150, height: 400)
        rightTableView.frame = CGRect(x: 150, y: 50, width: 150, height: 400)
        
        leftTableView.dragDelegate = self
        rightTableView.dragDelegate = self
        
        leftTableView.dropDelegate = self
        rightTableView.dropDelegate = self
        
        leftTableView.dragInteractionEnabled = true
        rightTableView.dragInteractionEnabled = true
        
        
        self.view.addSubview(leftTableView)
        self.view.addSubview(rightTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftArray.count
        }
        return rightArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {return UITableViewCell()}
        
        if tableView == leftTableView {
            cell.textLabel?.text = leftArray[indexPath.row]
        }else{
            cell.textLabel?.text = rightArray[indexPath.row]
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item:String!
        if tableView == leftTableView {
            item = leftArray[indexPath.row]
        }else{
            item = rightArray[indexPath.row]
        }
        guard let itemData = item.data(using: .utf8) else {return []}
        let itemProvider = NSItemProvider(item: itemData as NSData, typeIdentifier: kUTTypePlainText as String)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        let destinationIndexPath:IndexPath!
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
            guard let strings = items as? [String] else {return}
            var indexArray = [IndexPath]()
            
            for (index,string) in strings.enumerated() {
                let index = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                if tableView == self.leftTableView {
                    self.leftArray.insert(string, at: index.row)
                } else {
                    self.rightArray.insert(string, at: index.row)
                }
                indexArray.append(index)
            }
            tableView.insertRows(at: indexArray, with: .automatic)
            
        }
        
    }
}

