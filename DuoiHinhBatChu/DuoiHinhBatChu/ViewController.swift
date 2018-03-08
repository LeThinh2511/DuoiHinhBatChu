//
//  ViewController.swift
//  DuoiHinhBatChu
//
//  Created by ThinhLe on 3/6/18.
//  Copyright © 2018 ThinhLe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var PointLabel: UILabel!
    
    @IBAction func reset(_ sender: UIButton)
    {
        print("reset tapped")
        roundLabel.text = "round 12"
    }
    
    @IBAction func submit(_ sender: UIButton)
    {
        print("submit tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

