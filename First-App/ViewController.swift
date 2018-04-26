//
//  ViewController.swift
//  First-App
//
//  Created by Vigneshwaran C on 11/04/18.
//  Copyright © 2018 Vigneshwaran C. All rights reserved.
//

import UIKit

enum Modes {
    case not_set
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelString = "0"
    var savedNum = 0
    var currentMode: Modes = .not_set
    var lastButtonWasMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressAdd(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeModes(newMode: .subtraction)
    }
    
    @IBAction func multiplication(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    @IBAction func didPressEqual(_ sender: Any) {
        
        guard let intString = Int(labelString) else {
            return
        }

        if lastButtonWasMode || currentMode == .not_set {
            return
        }
        
        if currentMode == .addition {
            savedNum += intString
        } else if currentMode == .subtraction {
            savedNum -= intString
        } else if currentMode == .multiplication {
            savedNum *= intString
        }
        
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        label.text = "0"
        labelString = "0"
        savedNum = 0
        lastButtonWasMode = false
        currentMode = .not_set
    }
    
    @IBAction func didPressNumbers(_ sender: UIButton) {
        let stringLabel: String? = sender.titleLabel?.text
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        labelString = labelString.appending(stringLabel!)
        updateText()
    }
    
    func changeModes(newMode: Modes) {
        if savedNum == 0 {
            return
        }
        
        currentMode = newMode
        lastButtonWasMode = true
    }
    
    func updateText() {
        guard let intString = Int(labelString) else {
            return
        }
        
        if currentMode == .not_set {
            savedNum = intString
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let num = NSNumber(value: intString)
        label.text = formatter.string(from: num)
    }
       
}
