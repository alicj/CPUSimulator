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
    
    var registerView = RegisterView(frame: CGRect(x: 450, y: 700, width: 560, height: 240))
    var aluView = ALUView(frame: CGRect(x: 450, y: (700 + 240), width: 560, height: 240))
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        super.view.addSubview(registerView)
        super.view.addSubview(aluView)
    }

}
