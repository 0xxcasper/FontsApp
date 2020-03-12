//
//  KeyboardView.swift
//  FontsApp
//
//  Created by admin on 04/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

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
    @IBOutlet weak var btnSpace: UIButton!
    
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
    
    private var capsLockOn = false
    private var currentIndex = 0

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let font = fonts[currentIndex].fonts else { return }
        changeFontKeyboards(containerView: row1, row: font.row1)
        changeFontKeyboards(containerView: row2, row: font.row2)
        changeFontKeyboards(containerView: row3, row: font.row3)

        changeFontKeyboards(containerView: charSetNum, row: font.rowNum)
        
        addShadow(containerView: row1)
        addShadow(containerView: row2)
        addShadow(containerView: row3)

        addShadow(containerView: charSetNum)
        addShadow(containerView: charSet1)
        addShadow(containerView: charSet2)
        addShadow(containerView: charSet3)
        addShadow(containerView: charSet4)
        btnSpace.addShadowButton()
        
        heightAncho.constant = Constant.IS_IPHONEX ? 44 : 41
        
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
            if capsLockOn {
                guard let fontCL = fonts[currentIndex].fontsCL else { return }
                changeFontKeyboards(containerView: row1, row: fontCL.row1)
                changeFontKeyboards(containerView: row2, row: fontCL.row2)
                changeFontKeyboards(containerView: row3, row: fontCL.row3)
            } else {
                guard let font = fonts[currentIndex].fonts else { return }
                changeFontKeyboards(containerView: row1, row: font.row1)
                changeFontKeyboards(containerView: row2, row: font.row2)
                changeFontKeyboards(containerView: row3, row: font.row3)
            }
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
        button.animationTouch()
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        delegate.backSpacePressed()
    }
    
    @IBAction func spacePressed(button: UIButton) {
        button.animationTouch()
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
    
    private func changeFontKeyboards(containerView: UIView, row: [String]) {
        for (index, view) in containerView.subviews.enumerated() {
            if let button = view as? UIButton {
                button.setTitle(row[index], for: .normal)
            }
        }
    }
    
    private func addShadow(containerView: UIView) {
        for (_, view) in containerView.subviews.enumerated() {
            if let button = view as? UIButton {
                button.addShadowButton()
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
}

extension KeyboardView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FontCollectionViewCell
        cell.lblFont.text = fonts[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        guard let font = fonts[indexPath.row].fonts else { return }
        changeFontKeyboards(containerView: row1, row: font.row1)
        changeFontKeyboards(containerView: row2, row: font.row2)
        changeFontKeyboards(containerView: row3, row: font.row3)
        
        changeFontKeyboards(containerView: charSetNum, row: font.rowNum)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
