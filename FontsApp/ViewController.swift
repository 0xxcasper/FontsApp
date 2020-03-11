//
//  ViewController.swift
//  FontsApp
//
//  Created by Sang on 3/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func openSetting(_ sender: Any) {
        UIApplication.openAppSettings()
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

