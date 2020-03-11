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
    
    //=> Char set 3
    @IBOutlet weak var charSet3_1: UIButton!
    @IBOutlet weak var charSet3_2: UIButton!
    @IBOutlet weak var charSet3_3: UIButton!
    @IBOutlet weak var charSet3_4: UIButton!
    @IBOutlet weak var charSet3_5: UIButton!
    @IBOutlet weak var charSet3_6: UIButton!
    @IBOutlet weak var charSet3_7: UIButton!
    @IBOutlet weak var charSet3_8: UIButton!
    @IBOutlet weak var charSet3_9: UIButton!
    @IBOutlet weak var charSet3_10: UIButton!
    //=> Char num
    @IBOutlet weak var charNum_1: UIButton!
    @IBOutlet weak var charNum_2: UIButton!
    @IBOutlet weak var charNum_3: UIButton!
    @IBOutlet weak var charNum_4: UIButton!
    @IBOutlet weak var charNum_5: UIButton!
    @IBOutlet weak var charNum_6: UIButton!
    @IBOutlet weak var charNum_7: UIButton!
    @IBOutlet weak var charNum_8: UIButton!
    @IBOutlet weak var charNum_9: UIButton!
    @IBOutlet weak var charNum_0: UIButton!
    //=> Char row 1
    @IBOutlet weak var charRow1_1: UIButton!
    @IBOutlet weak var charRow1_2: UIButton!
    @IBOutlet weak var charRow1_3: UIButton!
    @IBOutlet weak var charRow1_4: UIButton!
    @IBOutlet weak var charRow1_5: UIButton!
    @IBOutlet weak var charRow1_6: UIButton!
    @IBOutlet weak var charRow1_7: UIButton!
    @IBOutlet weak var charRow1_8: UIButton!
    @IBOutlet weak var charRow1_9: UIButton!
    @IBOutlet weak var charRow1_10: UIButton!

    
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
        
        collectionView.register(UINib(nibName: "FontCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.showsHorizontalScrollIndicator = false
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let arr_CharRow1 = [
            charRow1_1,
            charRow1_2,
            charRow1_3,
            charRow1_4,
            charRow1_5,
            charRow1_6,
            charRow1_7,
            charRow1_8,
            charRow1_9,
            charRow1_10
        ]
        for item in arr_CharRow1 {
            addShadowButton(item!)
        }
    }
    
    func addShadowButton(_ item: UIButton) {
        item.backgroundColor = .white
        item.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        item.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        item.layer.shadowOpacity = 1.0
        item.layer.shadowRadius = 0.0
        item.layer.masksToBounds = false
        item.layer.cornerRadius = 4.0
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
    
    private func changeFontKeyboards(containerView: UIView, row: [String]) {
        for (index, view) in containerView.subviews.enumerated() {
            if let button = view as? UIButton {
                button.setTitle(row[index], for: .normal)
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
