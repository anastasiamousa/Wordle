//
//  ViewController.swift
//  Wordle
//
//  Created by Anastasia Mousa on 28/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    let answers = ["abuse","adult", "agent", "anger", "apple", "award", "basis", "beach", "birth", "block",
                   "blood", "board","brain","bread","break","brown","buyer","cause","chain","chair","chest",
                   "chief", "child","china","claim","class","clock","coach","coast","court","cover","cream",
                   "crime", "cross","crowd","crown","cycle","dance","death","depth","doubt","draft","drama",
                   "dream", "dress","drink","drive","earth","enemy","entry","error","event","faith","field",
                   "fight", "floor","focus","force","front","fruit","glass","grass","green","daddy","eagle",
                   "early", "faces","heart","royal","trash","label","labor","oasis","packs","sober","sodas",
                   "vacay", "yacht","plain","plane","wired","wings","width","white","virus","urban","twist",
                   "tulip", "torch","youth","yours","walls","steal","split","rumor","roses","pulse","prove",
                   "power", "pants","pilot","other","olive","older","nurse","needs","mixed","maybe","lover",
                   "loser", "lobby","level","kitty","kilos","karts","jeans","issue","input","igloo","ideal",
                   "humor", "house","honey","group","grape","grade","funky","front","fries","fresh","exist"
    ]
    
    var answer = ""
    
    var guesses:[[Character?]] = Array(
                                repeating: Array(repeating: nil, count: 5),
                                count: 6)
    
    let keyboardVC = Wordle.KeyboardViewController()
    let lettersVC = LetterBoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        answer = answers.randomElement() ?? "apple"
        view.backgroundColor = .systemGray6
        addChildren()
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(lettersVC)
        lettersVC.didMove(toParent: self)
        lettersVC.view.translatesAutoresizingMaskIntoConstraints = false
        lettersVC.datasource = self
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

extension ViewController: KeyboardViewControllerDelegate {
    func KeyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        lettersVC.reloadData()
        var stop = false
        
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
    }
}

extension ViewController: LetterBoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap({$0}).count
        guard count == 5
        else {
            return nil
        }
        
        let indexedAnswer = Array(answer)
        guard let letter = guesses[indexPath.section][indexPath.row], indexedAnswer.contains(letter)
        else {
            return nil
        }
        
        if indexedAnswer[indexPath.row] == letter {
            return .systemGreen
        }
        
        return .systemOrange
    }
}

