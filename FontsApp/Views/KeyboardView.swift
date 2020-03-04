//
//  KeyboardView.swift
//  FontsApp
//
//  Created by admin on 04/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

struct Font {
    var row1: [String]
    var row2: [String]
    var row3: [String]
    
    var rowNum: [String]
    var rowCharset1: [String]
    var rowCharset2: [String]
    var rowCharset3: [String]
    var rowCharset4: [String]
}

struct CustomFont {
    var name: String!
    var fonts: Font!
    var fontsCL: Font!
    
    init(name: String, font: Font, fontCL: Font) {
        self.name = name
        self.fonts = font
        self.fontsCL = fontCL
    }
}

var fonts =
    [CustomFont(name: "System-Regular",
                font: Font(row1: ["Ⓠ","Ⓦ","Ⓔ","Ⓡ","Ⓣ","Ⓨ","Ⓤ","Ⓘ","Ⓞ","Ⓟ"],
                            row2: ["Ⓐ","Ⓢ","Ⓓ","Ⓕ","Ⓖ","Ⓗ","Ⓙ","Ⓚ","Ⓛ"],
                            row3: ["Ⓩ","Ⓧ","Ⓒ","Ⓥ","Ⓑ","Ⓝ","Ⓜ"],
                            rowNum: [①②③④⑤⑥⑦⑧⑨ 0],
                            rowCharset1: [],
                            rowCharset2: [],
                            rowCharset3: [],
                            rowCharset4: []),
                fontCL: Font(row1: ["Ⓠ","Ⓦ","Ⓔ","Ⓡ","Ⓣ","Ⓨ","Ⓤ","Ⓘ","Ⓞ","Ⓟ"],
                             row2: ["Ⓐ","Ⓢ","Ⓓ","Ⓕ","Ⓖ","Ⓗ","Ⓙ","Ⓚ","Ⓛ"],
                             row3: ["Ⓩ","Ⓧ","Ⓒ","Ⓥ","Ⓑ","Ⓝ","Ⓜ"],
                             rowNum: [],
                             rowCharset1: [],
                             rowCharset2: [],
                             rowCharset3: [],
                             rowCharset4: [])]

protocol KeyboardViewDelegate: class {
    func nextKeyboardPressed()
    func keyPressed(string: String)
    func backSpacePressed()
    func spacePressed()
    func returnPressed()
}

class KeyboardView: BaseViewXib {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnCaplock: UIButton!
    
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    
    @IBOutlet weak var charSetNum: UIView!
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!
    
    @IBOutlet weak var charSet3: UIView!
    @IBOutlet weak var charSet4: UIView!
        
    @IBOutlet var heightAncho: NSLayoutConstraint!
    
    weak var delegate:KeyboardViewDelegate!
    
    private var capsLockOn = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.register(UINib(nibName: "FontCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.showsHorizontalScrollIndicator = false
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func nextKeyboardPressed(button: UIButton) {
        delegate.nextKeyboardPressed()
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        if button.titleLabel!.text == "CL" {
            capsLockOn = !capsLockOn
            
            changeCaps(containerView: row1)
            changeCaps(containerView: row2)
            changeCaps(containerView: row3)
        } else if button.titleLabel!.text == "#+=" {
            charSet1.isHidden = true
            charSetNum.isHidden = true
            
            charSet3.isHidden = false
            charSet4.isHidden = false
             button.setTitle("123", for: .normal)
        } else if button.titleLabel!.text == "123" {
            charSet1.isHidden = false
            charSetNum.isHidden = false
            
            charSet3.isHidden = true
            charSet4.isHidden = true
             button.setTitle("#+=", for: .normal)
        }
    }
    
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        delegate.keyPressed(string: string ?? "")
        self.animationTouch(button: button)

    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        delegate.backSpacePressed()
    }
    
    @IBAction func spacePressed(button: UIButton) {
        delegate.spacePressed()
    }
    
    @IBAction func returnPressed(button: UIButton) {
        delegate.returnPressed()
    }
    
    @IBAction func charSetPressed(button: UIButton) {
        if button.titleLabel!.text == "123" {
            row1.isHidden = true
            row2.isHidden = true
            row3.isHidden = true
            
            charSetNum.isHidden = false
            charSet1.isHidden = false
            charSet2.isHidden = false
            
            btnCaplock.setTitle("#+=", for: .normal)
            button.setTitle("ABC", for: .normal)
        } else if button.titleLabel!.text == "ABC" {
            row1.isHidden = false
            row2.isHidden = false
            row3.isHidden = false
            
            charSetNum.isHidden = true
            charSet1.isHidden = true
            charSet2.isHidden = true
            charSet4.isHidden = true
            
            btnCaplock.setTitle("CL", for: .normal)
            button.setTitle("123", for: .normal)
        }
    }
    
    private func changeFontKeyboards(containerView: UIView, font: UIFont) {
        for view in containerView.subviews {
            if let button = view as? UIButton, let titleLbl = button.titleLabel {
                titleLbl.font = font
            }
        }
    }
    
    private func changeCaps(containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercased()
                    button.setTitle("\(text)", for: .normal)
                } else {
                    let text = buttonTitle!.lowercased()
                    button.setTitle("\(text)", for: .normal)
                }
            }
        }
    }
    
    private func animationTouch(button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(translationX: 0, y: -30)
            button.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.7)
            }, completion: {(_) -> Void in
                button.transform = .identity
        })
    }
}

extension KeyboardView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FontCollectionViewCell
        cell.lblFont.font = fonts[indexPath.row].font
        cell.lblFont.text = fonts[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let font = fonts[indexPath.row].font else { return }
        changeFontKeyboards(containerView: row1, font: font)
        changeFontKeyboards(containerView: row2, font: font)
        changeFontKeyboards(containerView: row3, font: font)
        
        changeFontKeyboards(containerView: charSetNum, font: font)
        changeFontKeyboards(containerView: charSet1, font: font)
        changeFontKeyboards(containerView: charSet2, font: font)
        changeFontKeyboards(containerView: charSet4, font: font)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
