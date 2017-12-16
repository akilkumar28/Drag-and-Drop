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
    
    var leftArray  = [String](repeating: "left", count: 10)
    var rightArray = [String](repeating: "right", count: 10)

    
    
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
        print(222)
    }
}

