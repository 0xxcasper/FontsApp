//
//  KeyboardViewController.swift
//  FontKeyboard
//
//  Created by admin on 04/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    var keyboardView = KeyboardView()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let inputView = inputView else { return }
        inputView.addSubview(keyboardView)
        
        keyboardView.delegate = self
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          keyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
          keyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
          keyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
          keyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
        ])
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("", comment: ""), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        self.nextKeyboardButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        self.nextKeyboardButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 46).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}

extension KeyboardViewController: KeyboardViewDelegate
{
    func nextKeyboardPressed() {
        advanceToNextInputMode()
    }
    
    func keyPressed(string: String) {
        (textDocumentProxy as UIKeyInput).insertText(string)
    }
    
    func backSpacePressed() {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    func spacePressed() {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    func returnPressed() {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
}
