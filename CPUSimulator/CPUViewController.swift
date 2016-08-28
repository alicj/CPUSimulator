//
//  ViewController.swift
//  CPUSimulator
//
//  Created by Alic on 2016-08-07.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class CPUViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    // TODO with portions
    var registerView = RegisterView(frame: CGRect(x: 450, y: 700, width: 0, height: 0))
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        super.view.addSubview(registerView)
    }

}
