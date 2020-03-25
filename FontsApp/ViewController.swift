//
//  ViewController.swift
//  FontsApp
//
//  Created by Sang on 3/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var lblFour: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAttruButed(label: lblFirst, bold: "FontsApp", regular: "1. Go to ", regularSecond: " Settings")
        self.setupAttruButed(label: lblSecond, bold: "Keyboards", regular: "2. Select ", regularSecond: "")
        self.setupAttruButed(label: lblThird, bold: "FontsApp", regular: "3. Enable ", regularSecond: "")
        self.setupAttruButed(label: lblFour, bold: "Full Access", regular: "4. Enable ", regularSecond: "")
    }
    
    
    @IBAction func openSetting(_ sender: Any) {
        UIApplication.openAppSettings()
    }
    
    
    func setupAttruButed(label: UILabel, bold: String, regular: String, regularSecond: String = "") {
        
        let regularAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        let regularAttrString = NSMutableAttributedString(string: regular, attributes: regularAttribute)

        let boldAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .heavy)]
        let boldAttrString = NSMutableAttributedString(string: bold, attributes: boldAttribute)

        let regular2Attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        let regular2AttrString = NSMutableAttributedString(string: regularSecond, attributes: regular2Attribute)

        regularAttrString.append(boldAttrString)
        regularAttrString.append(regular2AttrString)
        
        label.attributedText = regularAttrString
    }
    
}

extension UIApplication {
    @discardableResult
    static func openAppSettings() -> Bool {
        guard
            let settingsURL = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsURL)
            else {
                return false
        }

        UIApplication.shared.open(settingsURL)
        return true
    }
}

