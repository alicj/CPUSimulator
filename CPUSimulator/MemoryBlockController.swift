//
//  MemoryBlockController.swift
//  CPUSimulator
//
//  Created by Alic on 2017-02-15.
//  Copyright © 2017 4ZC3. All rights reserved.
//  
//  UITableView with multiple columns
//  http://stackoverflow.com/q/29153135/2780428
//  UITableView scroll events
//  http://stackoverflow.com/a/41379479/2780428
//  Detect UITableView bounce event
//  http://stackoverflow.com/a/18192041/2780428

import UIKit

protocol MemoryBlockDelegate {
    func onMemoryScroll()
    func endMemoryScroll()
}

class MemoryBlockController: UITableViewController {
    
    var memory: Memory = Memory()
    var delegate: MemoryBlockDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: Sizes.memoryBlock.frame)
        self.tableView.bounces = false
        self.tableView.backgroundColor = Sizes.debugColor

//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memory.count()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        let memoryLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: cell.frame.height))
        let memoryValue: UILabel = UILabel(frame: CGRect(x: 75, y: 0, width: 75, height: cell.frame.height))
        
        memoryLabel.textAlignment = NSTextAlignment.center
        memoryValue.textAlignment = NSTextAlignment.center
        memoryLabel.text = String(indexPath.row)
        memoryValue.text = String(memory.get(pointer: indexPath.row))
        
        cell.addSubview(memoryLabel)
        cell.addSubview(memoryValue)

        return cell
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.onMemoryScroll()
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.endMemoryScroll()
    }

    
    func setMemory(memory: Memory) {
        self.memory = memory
    }

}
