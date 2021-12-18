//
//  ViewController.swift
//  UIPinExample
//
//  Created by Mutlu Aydin on 12/17/21.
//

import UIKit
import KeychainSwift

class PinViewController: UIViewController, UITextFieldDelegate {
    
    let keyChain = KeychainSwift()
            
    let pinView: UIView = {
        let view = UIView()
        view.backgroundColor = .pinViewColor
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    let pinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Enter Your Pin"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pinTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 2
        textField.keyboardType = .decimalPad
        textField.placeholder = "Pin..."
        return textField
    }()
    
    let pinButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: UIControl.State.normal)

        button.setTitle("Go!", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deletePin: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: UIControl.State.normal)

        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .white
        
        button.addTarget(self, action: #selector(deletePinPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .favoriteBlue
        
        setUpUI()
        
        if keyChain.get("my pin") == nil {
            pinLabel.text = "Set your pin"
        } else {
            pinLabel.text = "Enter your pin"
        }
        
    }
    
    func setUpUI() {
        
        view.addSubview(pinView)
        
        pinView.addSubview(pinTextField)
        pinView.addSubview(pinLabel)
        pinView.addSubview(pinButton)
        pinView.addSubview(deletePin)

        
        NSLayoutConstraint.activate([
            pinView.widthAnchor.constraint(equalToConstant: 300),
            pinView.heightAnchor.constraint(equalToConstant: 200),
            pinView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            pinView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            pinTextField.centerXAnchor.constraint(equalTo: pinView.centerXAnchor, constant: 0),
            pinTextField.centerYAnchor.constraint(equalTo: pinView.centerYAnchor, constant: 0),
            pinTextField.heightAnchor.constraint(equalToConstant: 50),
            pinTextField.widthAnchor.constraint(equalToConstant: 150),
            
            pinLabel.centerXAnchor.constraint(equalTo: pinView.centerXAnchor, constant: 0),
            pinLabel.topAnchor.constraint(equalTo: pinView.topAnchor, constant: 30),
            pinLabel.heightAnchor.constraint(equalToConstant: 50),
            
            pinButton.centerXAnchor.constraint(equalTo: pinView.centerXAnchor, constant: -40),
            pinButton.topAnchor.constraint(equalTo: pinTextField.bottomAnchor, constant: 10),
            pinButton.heightAnchor.constraint(equalToConstant: 35),
            pinButton.widthAnchor.constraint(equalToConstant: 60),
            
            deletePin.centerXAnchor.constraint(equalTo: pinView.centerXAnchor, constant: 40),
            deletePin.topAnchor.constraint(equalTo: pinTextField.bottomAnchor, constant: 10),
            deletePin.heightAnchor.constraint(equalToConstant: 35),
            deletePin.widthAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    // Pin Button Function
    @objc func buttonPressed (sender: UIButton!) {
        
        let rootVC = AfterPinViewController()
        let afterPinViewController = UINavigationController(rootViewController: rootVC)
        
        if pinTextField.text == keyChain.get("my pin") {
            pinLabel.text = "Correct Pin"
            pinTextField.text = ""
            afterPinViewController.modalPresentationStyle = .fullScreen
            present(afterPinViewController, animated: true)
            
        } else if pinTextField.text != keyChain.get("my pin") && keyChain.get("my pin") != nil {
            pinLabel.text = "You did not enter your pin..."
            pinTextField.text = ""
            print(keyChain.get("my pin")!)
            
        } else if pinTextField.text != "" || pinTextField.text != nil && pinTextField.text != keyChain.get("my pin"){
            pinLabel.text = "Welcome"
            keyChain.set(pinTextField.text!, forKey: "my pin")
            pinTextField.text = ""
            afterPinViewController.modalPresentationStyle = .fullScreen
            present(afterPinViewController, animated: true)
            
        } else if pinTextField.text == keyChain.get("my pin"){
            pinLabel.text = "Correct pin"
            pinTextField.text = ""
            keyChain.set(pinTextField.text!, forKey: "my pin")
            afterPinViewController.modalPresentationStyle = .fullScreen
            present(afterPinViewController, animated: true)
            
        }
        else {
            pinLabel.text = "Wrong pin, try again..."

        }
    }
    
    // Delete Button Function
    @objc func deletePinPressed (sender: UIButton!) {
        
        keyChain.delete("my pin")
        pinLabel.text = "Pin reset"
        pinTextField.text = ""
        
    }
    
}

extension UIColor {
    static let favoriteBlue = UIColor(named: "favoriteBlue")
    static let pinViewColor = UIColor(named: "pinViewColor")
}

