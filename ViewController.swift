//
//  ViewController.swift
//  Calculator Swift
//
//  Created by stoian delev on 21.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation: Operation?
    
    
    
    
    enum Operation {
        case add, subtract, multiply, divede
    }
    
    private var resultLable: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 100)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNumberPad()
        
    }
    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.tag = 1
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        holder.addSubview(zeroButton)
        
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x + 1)", for: .normal)
            holder.addSubview(button1)
            button1.tag = x + 2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x + 4)", for: .normal)
            holder.addSubview(button2)
            button2.tag = x + 5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.setTitle("\(x + 7)", for: .normal)
            holder.addSubview(button3)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonSize*5), width: view.frame.size.width - buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitle("Clear ALL", for: .normal)
        holder.addSubview(clearButton)
        
        let operation = ["=", "+", "-", "x", "/" ]
        for x in 0..<5 {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize*CGFloat (x + 1)), width: buttonSize, height: buttonSize))
            button4.setTitleColor(.black, for: .normal)
            button4.backgroundColor = .orange
            button4.setTitle(operation[x], for: .normal)
            holder.addSubview(button4)
            button4.tag = x + 1
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        
        resultLable.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100.0)
        holder.addSubview(resultLable)
        
        
        //Action
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
        
        
        
    }
    
    @objc func clearResult() {
        resultLable.text = "0"
        currentOperation = nil
        firstNumber = 0
        
    }
    
    @objc func zeroTapped() {
        if resultLable.text != "0" {
            if let text = resultLable.text {
                resultLable.text = "\(text)\(0)"
            }
        }}
    
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLable.text == "0" {
            resultLable.text = "\(tag)"
        }else if let text = resultLable.text {
            resultLable.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLable.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLable.text = "0"
            
        }
        
        
        
        if tag == 1 {
            if let operation = currentOperation {
                var secondNumber = 0
                if let text = resultLable.text, let value = Int(text) {
                    secondNumber = value
                }
                
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLable.text = "\(result)"
                    break
                case .subtract:
                    let result = firstNumber - secondNumber
                    resultLable.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLable.text = "\(result)"
                    break
                case .divede:
                    let result = firstNumber / secondNumber
                    resultLable.text = "\(result)"
                    break
                    
                }
            }
        }
        else if tag == 2 {
            currentOperation = .add
        }
        else if tag == 3 {
            currentOperation = .subtract
        }
        else if tag == 4 {
            currentOperation = .multiply
        }
        else if tag == 5 {
            currentOperation = .divede
        }
        
        
    }
    
    
}

