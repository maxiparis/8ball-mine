//
//  ViewController.swift
//  8ball-mine
//
//  Created by Maximiliano París Gaete on 7/18/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var typedQuestion: UITextField!
    
    var answers = ["Not today","For sure","Definetely not","Why not?","That would never happen"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerText.isHidden = true
        initializeHideKeyboard()
        setupTextFields()
    }


    @IBAction func askButton(_ sender: UIButton) {
        playSound()
        let randomNumber = Int.random(in: 0...4)
        answerText.isHidden = false
        typedQuestion.text = ""
        answerText.text = answers[randomNumber]
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "buttonSound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
     func initializeHideKeyboard(){
         //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard)
         )
         //Add this tap gesture recognizer to the parent view
         view.addGestureRecognizer(tap)
     }
     @objc func dismissMyKeyboard(){
         //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
         //In short- Dismiss the active keyboard.
         view.endEditing(true)
     }
    
    
    
    
    
    //Set up of the toolbar in the top of the keyboard, with DONE button
    func setupTextFields() {
            let toolbar = UIToolbar()
            let flexSpace = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil)
            let doneButton = UIBarButtonItem(title: "Done",
                                             style: .done,
                                             target: self,
                                             action: #selector(doneButtonTapped))
            
            toolbar.setItems([flexSpace, doneButton], animated: true)
            toolbar.sizeToFit()
            
            //Her put all the UITextFields that will implement it
            typedQuestion.inputAccessoryView = toolbar
        }
        
        @objc func doneButtonTapped() {
            view.endEditing(true)
        }
     
}

