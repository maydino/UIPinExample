//
//  AfterPinViewController.swift
//  UIPinExample
//
//  Created by Mutlu Aydin on 12/17/21.
//

import UIKit

class AfterPinViewController: UIViewController {

    let dismissButton : UIButton = {
       
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        setUpUI()

    }
    
    func setUpUI () {
        
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            
            dismissButton.widthAnchor.constraint(equalToConstant: 200),
            dismissButton.heightAnchor.constraint(equalToConstant: 50),
            dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
       
        ])
    }
    
    @objc func dismissButtonTapped() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
