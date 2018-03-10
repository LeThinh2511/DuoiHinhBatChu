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
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var imageQuestion: UIImageView!
    
    @IBOutlet weak var answerButtonArea: UIView!
    @IBOutlet weak var hintButtonArea: UIView!
    
    var buttonSize: CGFloat
    {
        var widthOfAnswerArea = CGFloat(answerButtonArea.frame.width)
        var size = (widthOfAnswerArea - (numButtonInLine - 1) * buttonMarginX)/numButtonInLine
        buttonMarginX = (widthOfAnswerArea - (size * numButtonInLine)) / (numButtonInLine - 1)
        
        return size
    }
    var numButtonInLine: CGFloat = 8
    var buttonMarginX: CGFloat = 4
    var buttonMarginY: CGFloat = 4
    
    var round: Int! = 0
    var point: Int! = 0
    let questionSet: [Question] = [
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI(round: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI(round: Int)
    {
        roundLabel.text = "Round \(round)"
        pointLabel.text = "\(point!)"
        imageQuestion.image = UIImage(named: questionSet[round].image)
        
        addButtonToView(targetView: answerButtonArea, numOfChar: questionSet[round].answear.count)
        
        addButtonToView(targetView: hintButtonArea, numOfChar: questionSet[round].hint.count)
        
    }
    
    func addButtonToView(targetView: UIView, numOfChar: Int)
    {
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        for i in 0..<numOfChar
        {
            let nthRow = CGFloat(i)/numButtonInLine
            let roundY = CGFloat(Int(nthRow))
            y = buttonSize * roundY + buttonMarginY * roundY
            
            //set x = 0 if change to new line
            if nthRow == roundY
            {
                x = 0
            }
            let button: UIButton = UIButton()
            button.frame = CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
            button.setTitle("T", for: UIControlState.normal)
            button.backgroundColor = UIColor.lightGray
            targetView.addSubview(button)
            
            x += buttonSize + buttonMarginX
            
            y = 0
        }
        
    }
    
    func buttonTappedEvent(sender: UIButton)
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

