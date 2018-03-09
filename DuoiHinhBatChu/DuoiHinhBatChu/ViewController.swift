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
    @IBOutlet var imageQuestion: UIImageView!
    
    @IBOutlet weak var answerButton: UIView!
    @IBOutlet weak var hintButton: UIView!
    var round: Int! = 0
    var point: Int! = 0
    let setQuestion: [Question] = [
        Question(answear: "AIMO", image: "aiMo"),
        Question(answear: "TAMTHAT", image: "tamThat")
    ]
    
    
    @IBAction func reset(_ sender: UIButton)
    {
        print("reset tapped")
    }
    
    @IBAction func submit(_ sender: UIButton)
    {
        print("submit tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(round: 0)
    }
    
    func updateUI(round: Int)
    {
        roundLabel.text = "Round \(round)"
        PointLabel.text = "\(point!)"
        imageQuestion.image = UIImage(named: setQuestion[round].answear)
        
        for i in 0..<setQuestion.count
        {
            print(i)
            let button: UIButton = UIButton()
            button.setTitle("T", for: UIControlState.normal)
            button.backgroundColor = UIColor.green
            self.answerButton.addSubview(button)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

