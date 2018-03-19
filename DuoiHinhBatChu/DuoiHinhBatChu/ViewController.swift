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
    @IBOutlet weak var answerButtonArea: UIView!
    @IBOutlet weak var hintButtonArea: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    var answerButtonArray: [MyButton] = []
    var hintButtonArray: [MyButton] = []
    
    var numButtonInLine: CGFloat = 7
    var buttonMarginX: CGFloat = 4
    var buttonMarginY: CGFloat = 4
    var losingPoint: Int = 5
    var winningPoint: Int = 10
    var currentIndex: Int = 0
    var shouldUpdate = true
    var round: Int! = 0
    var point: Int! = 10
    
    var buttonSize: CGFloat
    {
        let widthOfAnswerArea = CGFloat(answerButtonArea.frame.width)
        let size = (widthOfAnswerArea - (numButtonInLine - 1) * buttonMarginX)/numButtonInLine
        buttonMarginX = (widthOfAnswerArea - (size * numButtonInLine)) / (numButtonInLine - 1)
        
        return size
    }
    
    let questionSet: [Question] = [
        Question(answer: "LABAN", image: "laBan"),
        Question(answer: "CUNGCAU", image: "cungCau"),
        Question(answer: "BAOCAO", image: "baoCao"),
        Question(answer: "AIMO", image: "aiMo"),
        Question(answer: "HUNGTHU", image: "hungThu"),
        Question(answer: "OBAMA", image: "obama"),
        Question(answer: "TAMTHAT", image: "tamThat")
    ]
    
    @IBAction func reset(_ sender: UIButton)
    {
        round = 0
        point = 10
        currentIndex = 0
        submitButton.setTitle("Submit", for: .normal)
        shouldUpdate = true
        updateUI(round: round)
        hintButtonArea.isUserInteractionEnabled = true
        answerButtonArea.isUserInteractionEnabled = true
    }
    
    @IBAction func submit(_ sender: UIButton)
    {
        let nameButton: String = sender.currentTitle!
        let alertController = UIAlertController()
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (alertAction: UIAlertAction!) in
            //alertController.dismiss(animated: true, completion: nil)
        }))
        
        if (nameButton == "Submit")
        {
            checkAnswer(round: round, alertController: alertController)
        }
        else if (nameButton == "Next")
        {
            goToNextQuestion(alertController: alertController)
        }
    }
    
    func goToNextQuestion(alertController: UIAlertController)
    {
        currentIndex = 0
        if (round < questionSet.count - 1)
        {
            round = round + 1
            point = point + winningPoint
            shouldUpdate = true
            updateUI(round: round)
            submitButton.setTitle("Submit", for: .normal)
            hintButtonArea.isUserInteractionEnabled = true
            answerButtonArea.isUserInteractionEnabled = true
        }
        else
        {
            alertController.title = "Congratulation!"
            alertController.message = "You win!"
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func checkAnswer(round: Int, alertController: UIAlertController)
    {
        var tempAnswer = [Character]()
        let answer = questionSet[round].answer
        for i in answerButtonArray
        {
            if i.currentTitle != "" 
            {
                tempAnswer.append(Character(i.currentTitle!))
            }
        }
        if (tempAnswer == answer)
        {
            alertController.title = "Congratulation!"
            alertController.message = "Correct answer!"
            self.present(alertController, animated: true, completion: nil)
            submitButton.setTitle("Next", for: .normal)
            answerButtonArea.isUserInteractionEnabled = false
            hintButtonArea.isUserInteractionEnabled = false
        }
        else
        {
            alertController.title = "Oops"
            alertController.message = "Wrong answer!"
            self.present(alertController, animated: true, completion: nil)
            point = point - losingPoint
            if point < 0
            {
                point = 0
            }
            pointLabel.text = "\(point!)"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI(round: round)
    }
    
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI(round: Int)
    {
        if (!self.shouldUpdate)
        {
            return
        }
        roundLabel.text = "Round \(round)"
        pointLabel.text = "\(point!)"
        let question = questionSet[round]
        imageQuestion.image = UIImage(named: question.image)
        
        answerButtonArray = []
        addButtonToView(target: answerButtonArea, data: question.answer,  buttonTag: 1)
        
        hintButtonArray = []
        addButtonToView(target: hintButtonArea, data: question.hint, buttonTag: 2)
        print("Round \(round)")
        shouldUpdate = false
    }
    
    func addButtonToView(target: UIView, data: [Character], buttonTag: Int)
    {
        for view in target.subviews
        {
            view.removeFromSuperview()
        }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        let count = data.count
        
        for i in 0..<count
        {
            (x, y) = computeXY(xValue: x, yValue: y, index: i, totalButton: count)
            
            let button = MyButton()
            button.frame = CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
            if (buttonTag == 2)
            {
                button.setTitle("\(data[i])", for: UIControlState.normal)
            }
            else
            {
                button.setTitle("", for: UIControlState.normal)
            }
            button.backgroundColor = UIColor.lightGray
            button.tag = buttonTag
            button.index = i
            if button.tag == 1
            {
                answerButtonArray.append(button)
            }
            else
            {
                let tempView = UIView()
                tempView.backgroundColor = UIColor.lightGray
                tempView.frame = CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
                target.addSubview(tempView)
                hintButtonArray.append(button)
                button.backgroundColor = UIColor.gray
            }
            
            target.addSubview(button)
            button.addTarget(self, action: #selector(ViewController.buttonTouchUpInside), for: .touchUpInside)
        }
    }
    
    func computeXY(xValue: CGFloat, yValue: CGFloat, index: Int, totalButton: Int) -> (CGFloat, CGFloat)
    {
        var x = xValue
        var y = yValue
        x += buttonSize + buttonMarginX
        y = 0
        
        let nthRow = CGFloat(index)/numButtonInLine
        let roundY = CGFloat(Int(nthRow))
        y = buttonSize * roundY + buttonMarginY * roundY
        
        //changevalue if change to new line
        if nthRow == roundY
        {
            var numOfMissButton: CGFloat = CGFloat(totalButton) - numButtonInLine * (roundY + 1)
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
        return (x, y)
    }
    
    
    @objc func buttonTouchUpInside(sender: MyButton)
    {
        let letter = sender.titleLabel?.text
        
        if sender.tag == 1
        {
            sender.setTitle("", for: .normal)
            sender.titleLabel?.text = ""
            sender.backgroundColor = UIColor.lightGray
            hintButtonArray[sender.returnIndex].isHidden = false
            if (currentIndex > sender.index)
            {
                currentIndex = sender.index
            }
        }
        else if sender.tag == 2
        {
            if currentIndex == answerButtonArray.count
            {
                return
            }
            let currentButton = answerButtonArray[currentIndex]
            currentButton.returnIndex = sender.index
            currentButton.backgroundColor = UIColor.gray
            currentButton.setTitle(letter, for: .normal)
            sender.isHidden = true
            var text = ""
            repeat {
                currentIndex += 1
                if (currentIndex < answerButtonArray.count)
                {
                    text = answerButtonArray[currentIndex].titleLabel?.text ?? ""
                }
            } while (text != ""
                && currentIndex < answerButtonArray.count)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

