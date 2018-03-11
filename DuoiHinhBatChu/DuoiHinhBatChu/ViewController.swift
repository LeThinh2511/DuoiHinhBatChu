//
//  ViewController.swift
//  DuoiHinhBatChu
//
//  Created by ThinhLe on 3/6/18.
//  Copyright © 2018 ThinhLe. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var imageQuestion: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var answerButtonArea: UIView!
    @IBOutlet weak var hintButtonArea: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    var buttonSize: CGFloat
    {
        let widthOfAnswerArea = CGFloat(answerButtonArea.frame.width)
        let size = (widthOfAnswerArea - (numButtonInLine - 1) * buttonMarginX)/numButtonInLine
        buttonMarginX = (widthOfAnswerArea - (size * numButtonInLine)) / (numButtonInLine - 1)
        
        return size
    }
    var numButtonInLine: CGFloat = 8
    var buttonMarginX: CGFloat = 4
    var buttonMarginY: CGFloat = 4
    var losingPoint: Int = 5
    var winningPoint: Int = 10
    
    var round: Int! = 0
    var point: Int! = 10
    let questionSet: [Question] = [
        Question(answer: "AIMO", image: "aiMo"),
        Question(answer: "TAMTHAT", image: "tamThat")
    ]
    
    
    @IBAction func reset(_ sender: UIButton)
    {
        round = 0
        point = 10
        submitButton.setTitle("Submit", for: .normal)
        resultLabel.isHidden = true
        answerButtonArea.isHidden = false
        hintButtonArea.isHidden = false
        updateUI(round: round)
    }
    
    @IBAction func submit(_ sender: UIButton)
    {
        let nameButton: String = sender.currentTitle!
        if (nameButton == "Submit")
        {
            var tempAnswer: String = ""
            for i in questionSet[round].answerArray
            {
                tempAnswer += String(i)
            }
            if (tempAnswer == questionSet[round].answer)
            {
                hintButtonArea.isHidden = true
                resultLabel.isHidden = false
                resultLabel.text = "Congratulation!"
                sender.setTitle("Next", for: .normal)
            }
            else
            {
                hintButtonArea.isHidden = true
                answerButtonArea.isHidden = true
                resultLabel.isHidden = false
                resultLabel.text = "Wrong answer!"
                sender.setTitle("Try again", for: .normal)
                point = point - losingPoint
                if point < 0
                {
                    point = 0
                }
                updateUI(round: round)
            }
        }
        else if (nameButton == "Next")
        {
            if (round < questionSet.count - 1)
            {
                round = round + 1
                point = point + winningPoint
                updateUI(round: round)
                sender.setTitle("Submit", for: .normal)
                hintButtonArea.isHidden = false
                resultLabel.isHidden = true
            }
            else
            {
                answerButtonArea.isHidden = true
                resultLabel.text = "You win!"
            }
        }
        else
        {
            sender.setTitle("Submit", for: .normal)
            hintButtonArea.isHidden = false
            answerButtonArea.isHidden = false
            resultLabel.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI(round: round)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
    }
    
    func updateUI(round: Int)
    {
        roundLabel.text = "Round \(round)"
        pointLabel.text = "\(point!)"
        imageQuestion.image = UIImage(named: questionSet[round].image)
        
        
        
        addButtonToView(targetView: answerButtonArea, charArray: questionSet[round].answerArray,  buttonTag: 1)
        
        addButtonToView(targetView: hintButtonArea, charArray: questionSet[round].hintArray, buttonTag: 2)
        print("Round \(round)")
    }
    
    func addButtonToView(targetView: UIView, charArray: [Character], buttonTag: Int)
    {
        for view in targetView.subviews {
            view.removeFromSuperview()
        }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        for i in 0..<charArray.count
        {
            let nthRow = CGFloat(i)/numButtonInLine
            let roundY = CGFloat(Int(nthRow))
            y = buttonSize * roundY + buttonMarginY * roundY
            
            //set x value if change to new line
            if nthRow == roundY
            {
                var numOfMissButton: CGFloat = CGFloat(charArray.count) - numButtonInLine * (roundY + 1)
                if numOfMissButton >= 0
                {
                    x = 0
                }
                else
                {
                    numOfMissButton = 0 - numOfMissButton
                    x = (numOfMissButton * buttonSize + buttonMarginX * numOfMissButton)/2
                }
            }
            let button: UIButton = UIButton()
            button.frame = CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
            
            let letter: String = String(charArray[i])
            if letter == "."
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = UIColor.lightGray
            }
            else
            {
                button.setTitle(letter, for: UIControlState.normal)
                button.backgroundColor = UIColor.gray
            }
            button.tag = buttonTag
            button.accessibilityValue = String(i)
            targetView.addSubview(button)
            
            button.addTarget(self, action: #selector(ViewController.buttonTouchUpInside), for: .touchUpInside)
            
            x += buttonSize + buttonMarginX
            y = 0
        }
    }
    
    
    @objc func buttonTouchUpInside(sender: UIButton)
    {
        let letter: String = (sender.titleLabel?.text) ?? ""
        let index: Int = Int(sender.accessibilityValue!)!
        
        if sender.tag == 1
        {
            if letter != ""
            {
                //update "answerArray"
                questionSet[round].answerArray[index] = "."
                
                //update "hintArray"
                for i in 0..<questionSet[round].hintArray.count
                {
                    if questionSet[round].hintArray[i] == "."
                    {
                        questionSet[round].hintArray[i] = Character(letter)
                        break
                    }
                }
                updateUI(round: round)
            }
        }
        else if sender.tag == 2
        {
            if letter != "" && !isArrayFull(array: questionSet[round].answerArray)
            {
                //update "hintArea"
                questionSet[round].hintArray[index] = "."
                
                //update "answerArea"
                for i in 0..<questionSet[round].answerArray.count
                {
                    if questionSet[round].answerArray[i] == "."
                    {
                        questionSet[round].answerArray[i] = Character(letter)
                        break
                    }
                }
                updateUI(round: round)
            }
        }
        
    }
    
    func isArrayFull(array: [Character]) -> Bool
    {
        for i in array
        {
            if i == "."
            {
                return false
            }
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

