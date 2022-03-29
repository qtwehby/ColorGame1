//
//  ViewController.swift
//  ColorGame
//
//  Created by Wehby, Quinton on 9/27/21.
//

import UIKit

extension UIColor {
  
  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#") { cString.removeFirst() }
    
    if cString.count != 6 {
      self.init("ff0000") // return red color for wrong hex input
      return
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}

class ViewController: UIViewController {

    
    
    @IBOutlet weak var hishscoreLabel: UILabel!
    @IBOutlet weak var backroundSquare: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var button1O: UIButton!
    @IBOutlet weak var button2O: UIButton!
    @IBOutlet weak var button3O: UIButton!
    @IBOutlet weak var button4O: UIButton!
    @IBOutlet weak var button5O: UIButton!
    @IBOutlet weak var button6O: UIButton!
    @IBOutlet weak var button7O: UIButton!
    @IBOutlet weak var button8O: UIButton!
    @IBOutlet weak var button9O: UIButton!
    @IBOutlet weak var button10O: UIButton!
    @IBOutlet weak var button11O: UIButton!
    @IBOutlet weak var button12O: UIButton!
    @IBOutlet weak var button13O: UIButton!
    @IBOutlet weak var button14O: UIButton!
    @IBOutlet weak var button15O: UIButton!
    @IBOutlet weak var button16O: UIButton!
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    var differentColorHex = ""
    var differentColorHexInt = 0
    var correctButton = 0
    var difficulty = 77
    var level = 0
    var testOdd = 0
    var last2Digits = ""
    var last2DigitsInt = 0
    
    var globalColorHex = ""
    var z = 0
    var y = 0
    var time1 = 0.0
    var resetRecord = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        if defaults.double(forKey: "highscore") == 0 {
            defaults.set(99.99, forKey: "highscore")
        }
        
        hishscoreLabel.text = "Fastest time: \( defaults.double(forKey: "highscore"))"
        
        
        playAgainButton.isHidden = true
        incorrectLabel.isHidden = true
        let randomColor = Int.random(in: 0...16777115)

        let randomColorHex = String(randomColor, radix: 16)
        setColors(colorHex: randomColorHex)
    } //16711680 - 16732160
    
    func startTimer() {
        z = 1

        if y == 0 {
            self.addTime()
            }
        y = 1
    }
    func addTime() {

        if z == 1 {
            addTime2()
        }
        
    }
    func addTime2() {
        //z = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0095) {
            self.addTime()
            }
        time1 = time1 + 0.01
        if Int(100*time1) % 10 == 0 {
            timeLabel.text = "Time: \(Double(floor(100*time1)/100))0"
        } else {
            timeLabel.text = "Time: \(Double(floor(100*time1)/100))"
        }
    }
    func endTimer() {
        z = 0
        y = 0
    }
    func resetTimer() {
        time1 = 0
    }
    
    func setColors(colorHex: String) {
        
        globalColorHex = colorHex
        
        if colorHex.count == 5 {
            globalColorHex = "0" + colorHex
        }
        if colorHex.count == 4 {
            globalColorHex = "00" + colorHex
        }
        checkForRed(colorHex: globalColorHex)
        checkForGreen(colorHex: globalColorHex)
        
        difficulty -= 7
        if difficulty == 0 {
            endTimer()

            levelLabel.text = "You win!"
            
            let defaults = UserDefaults.standard
            let oldscore = defaults.double(forKey: "highscore")
            defaults.set(99.99, forKey: "highscore")
            
            if time1 < oldscore {
            defaults.set(Double(floor(100*time1)/100), forKey: "highscore")
                hishscoreLabel.text = "Fastest time: \( defaults.double(forKey: "highscore"))"
            }
            
            playAgainButton.isHidden = false
            return
        }
        level += 1
        levelLabel.text = "Level \(String(level))"
        button1O.backgroundColor = UIColor(globalColorHex)
        button2O.backgroundColor = UIColor(globalColorHex)
        button3O.backgroundColor = UIColor(globalColorHex)
        button4O.backgroundColor = UIColor(globalColorHex)
        button5O.backgroundColor = UIColor(globalColorHex)
        button6O.backgroundColor = UIColor(globalColorHex)
        button7O.backgroundColor = UIColor(globalColorHex)
        button8O.backgroundColor = UIColor(globalColorHex)
        button9O.backgroundColor = UIColor(globalColorHex)
        button10O.backgroundColor = UIColor(globalColorHex)
        button11O.backgroundColor = UIColor(globalColorHex)
        button12O.backgroundColor = UIColor(globalColorHex)
        button13O.backgroundColor = UIColor(globalColorHex)
        button14O.backgroundColor = UIColor(globalColorHex)
        button15O.backgroundColor = UIColor(globalColorHex)
        button16O.backgroundColor = UIColor(globalColorHex)
        
        let x = Int.random(in: 1...16)
        differentColorHexInt = Int(globalColorHex, radix: 16)! //base ten of colorHex
        //print("diffColor \(differentColorHexInt)")
        differentColorHexInt = differentColorHexInt + difficulty //changes color
        differentColorHex = String(differentColorHexInt, radix: 16)//sets back to base 16
        
        last2Digits = String(differentColorHex.suffix(2))
        last2DigitsInt = Int(last2Digits, radix: 16)!
        if last2DigitsInt <= difficulty {
            differentColorHexInt = Int(globalColorHex, radix: 16)! //base ten of colorHex
            //print("diffColor \(differentColorHexInt)")
            differentColorHexInt = differentColorHexInt - (difficulty) //changes color
            differentColorHex = String(differentColorHexInt, radix: 16)
        }
        if differentColorHex.count == 5 {
            differentColorHex = "0" + differentColorHex
        }
        if differentColorHex.count == 4 {
            differentColorHex = "00" + differentColorHex
        }
        print("Color Hex: \(globalColorHex)")
        print("Different Hex: \(differentColorHex)")
        switch x {
            case 1: button1O.backgroundColor = UIColor(differentColorHex)
            case 2: button2O.backgroundColor = UIColor(differentColorHex)
            case 3: button3O.backgroundColor = UIColor(differentColorHex)
            case 4: button4O.backgroundColor = UIColor(differentColorHex)
            case 5: button5O.backgroundColor = UIColor(differentColorHex)
            case 6: button6O.backgroundColor = UIColor(differentColorHex)
            case 7: button7O.backgroundColor = UIColor(differentColorHex)
            case 8: button8O.backgroundColor = UIColor(differentColorHex)
            case 9: button9O.backgroundColor = UIColor(differentColorHex)
            case 10: button10O.backgroundColor = UIColor(differentColorHex)
            case 11: button11O.backgroundColor = UIColor(differentColorHex)
            case 12: button12O.backgroundColor = UIColor(differentColorHex)
            case 13: button13O.backgroundColor = UIColor(differentColorHex)
            case 14: button14O.backgroundColor = UIColor(differentColorHex)
            case 15: button15O.backgroundColor = UIColor(differentColorHex)
            case 16: button16O.backgroundColor = UIColor(differentColorHex)
            default: print("error 101")
        }
        correctButton = x
        print(x)
        
        
        //.background(UIColor(colorHex))
    }
    
    func checkForRed(colorHex: String) {
        
        var newColorHex = ""
        
        let blueHex = String(colorHex.suffix(2))
        let greenHex = (String(colorHex.suffix(4))).prefix(2)
        let redHex = colorHex.prefix(2)
        
        let blueDecimal = Int(blueHex, radix: 16)!
        let greenDecimal = Int(greenHex, radix: 16)!
        let redDecimal = Int(redHex, radix: 16)!
        
        if 4*(redDecimal/5) > (blueDecimal + greenDecimal) && redDecimal > 140 && blueDecimal < 80 && greenDecimal < 80{
            newColorHex = "10" + String(colorHex.suffix(4))
            print("Old color hex: \(colorHex)  New color hex: \(newColorHex)")
            globalColorHex = newColorHex
        }
        print("Red: \(redDecimal) Green: \(greenDecimal) Blue: \(blueDecimal)")
    }
    
    func checkForGreen(colorHex: String) {
        
        var newColorHex = ""
        
        let blueHex = String(colorHex.suffix(2))
        let greenHex = (String(colorHex.suffix(4))).prefix(2)
        let redHex = colorHex.prefix(2)
        
        let blueDecimal = Int(blueHex, radix: 16)!
        let greenDecimal = Int(greenHex, radix: 16)!
        let redDecimal = Int(redHex, radix: 16)!
        
        if 4*(greenDecimal/5) > (blueDecimal + redDecimal) && greenDecimal > 140 && blueDecimal < 80 && redDecimal < 80{
            newColorHex = String(colorHex.prefix(2)) + "10" + String(colorHex.suffix(2))
            print("Old color hex: \(colorHex)  New color hex: \(newColorHex)")
            globalColorHex = newColorHex
        }
        //print("Red: \(redDecimal) Green: \(greenDecimal) Blue: \(blueDecimal)")
    }
    
    func checkCorrect(buttonNum: Int) {
        startTimer()
        let defaults = UserDefaults.standard
        if buttonNum == 11 {
            resetRecord += 1
            if resetRecord == 9 {
                defaults.set(99.99, forKey: "highscore")
                hishscoreLabel.text = "Fastest time: \( defaults.double(forKey: "highscore"))"
            }
        } else {
            resetRecord -= 1
        }
        if buttonNum == correctButton {
            let randomColor = Int.random(in: 0...16777115)
           
            let randomColorHex = String(randomColor, radix: 16)
            setColors(colorHex: randomColorHex)
        } else {
            incorrectLabel.isHidden = false
            endTimer()
            backroundSquare.backgroundColor = UIColor(globalColorHex)
            level = 0
            difficulty = 77
            playAgainButton.isHidden = false
        }
    }
    
   

    @IBAction func playAgain(_ sender: Any) {
        
        resetTimer()
        /*let defaults = UserDefaults.standard
        defaults.set(100, forKey: "highscore")*/
        timeLabel.text = "Time: \(time1)"
        backroundSquare.backgroundColor = .white
        difficulty = 77
        level = 0
        let randomColor = Int.random(in: 0...16777115)
      
        let randomColorHex = String(randomColor, radix: 16)
        setColors(colorHex: randomColorHex)
        playAgainButton.isHidden = true
        incorrectLabel.isHidden = true
    }
    @IBAction func button1(_ sender: Any) {
        checkCorrect(buttonNum: 1)
    }
    @IBAction func button2(_ sender: Any) {
        checkCorrect(buttonNum: 2)
    }
    @IBAction func button3(_ sender: Any) {
        checkCorrect(buttonNum: 3)
    }
    @IBAction func button4(_ sender: Any) {
        checkCorrect(buttonNum: 4)
    }
    @IBAction func button5(_ sender: Any) {
        checkCorrect(buttonNum: 5)
    }
    @IBAction func button6(_ sender: Any) {
        checkCorrect(buttonNum: 6)
    }
    @IBAction func button7(_ sender: Any) {
        checkCorrect(buttonNum: 7)
    }
    @IBAction func button8(_ sender: Any) {
        checkCorrect(buttonNum: 8)
    }
    @IBAction func button9(_ sender: Any) {
        checkCorrect(buttonNum: 9)
    }
    @IBAction func button10(_ sender: Any) {
        checkCorrect(buttonNum: 10)
    }
    @IBAction func button11(_ sender: Any) {
        checkCorrect(buttonNum: 11)
    }
    @IBAction func button12(_ sender: Any) {
        checkCorrect(buttonNum: 12)
    }
    @IBAction func button13(_ sender: Any) {
        checkCorrect(buttonNum: 13)
    }
    @IBAction func button14(_ sender: Any) {
        checkCorrect(buttonNum: 14)
    }
    @IBAction func button15(_ sender: Any) {
        checkCorrect(buttonNum: 15)
    }
    @IBAction func button16(_ sender: Any) {
        checkCorrect(buttonNum: 16)
    }
    
    //this is new to the git
    //hopefully only on the second branch
}

