//
//  ViewController.swift
//  Wordle
//
//  Created by Anastasia Mousa on 28/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    let keyboardVC = KeyboardViewController()
    let lettersVC = LetterBoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addChildren()
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(lettersVC)
        lettersVC.didMove(toParent: self)
        lettersVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lettersVC.view)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            lettersVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lettersVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lettersVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lettersVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            lettersVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

