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
        self.tableView.backgroundColor = Sizes.debugColor
        
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memory.count()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Sizes.memoryBlock.cell.height);
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Sizes.memoryBlock.cell.height);
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: UIView = UIView(frame: Sizes.memoryBlock.cell.frame)
        
        let memoryLabel: UILabel = UILabel(frame: Sizes.memoryBlock.cell.frameForLeftColumn)
        let memoryValue: UILabel = UILabel(frame: Sizes.memoryBlock.cell.frameForRightColumn)
        
        memoryLabel.textAlignment = NSTextAlignment.center
        memoryValue.textAlignment = NSTextAlignment.center
        memoryLabel.text = "Address"
        memoryValue.text = "Value"
        
        header.addSubview(memoryLabel)
        header.addSubview(memoryValue)
        header.backgroundColor = Sizes.debugColor
        
        return Util.setBottomBorder(view: header)

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        let memoryLabel: UILabel = UILabel(frame: Sizes.memoryBlock.cell.frameForLeftColumn)
        let memoryValue: UILabel = UILabel(frame: Sizes.memoryBlock.cell.frameForRightColumn)
        
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
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.endMemoryScroll()
    }

    
    func setMemory(memory: Memory) {
        self.memory = memory
    }

}
