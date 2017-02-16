//
//  MemoryBlockView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-29.
//  Copyright © 2016 4ZC3. All rights reserved.
//  http://stackoverflow.com/questions/29153135/how-do-i-create-a-ui-tableview-with-multiple-columns-in-xcode

import UIKit

class MemoryBlockView: UIView {
    
    var memoryPositionBlock = UITableView()
    var memoryDataBlock = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        memoryPositionBlock = InitMemoryPositionBlock()
        memoryDataBlock = InitMemoryDataBlock()
        
        memoryDataBlock.separatorColor = UIColor.black
        memoryPositionBlock.separatorColor = UIColor.black
        
        self.addSubview(memoryPositionBlock)
        self.addSubview(memoryDataBlock)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func InitMemoryPositionBlock() -> UITableView {
        let tableView = UITableView(frame: CGRect(
                                    x: self.bounds.origin.x,
                                    y: self.bounds.origin.y,
                                    width: self.bounds.width/2,
                                    height: self.bounds.height))
        return tableView
    }
    func InitMemoryDataBlock() -> UITableView {
        let tableView = UITableView(frame: CGRect(
            x: 1.5*self.bounds.origin.x,
            y: self.bounds.origin.y,
            width: self.bounds.width/2,
            height: self.bounds.height))
        return tableView
    }
}
