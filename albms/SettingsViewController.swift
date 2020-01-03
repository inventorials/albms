//
//  SettingsViewController.swift
//  albms
//
//  Created by Armand Raynor on 10/14/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    private let settingsView = SettingsView()
    private let defaults = UserDefaults()

    override func viewDidLoad() {
        view.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    @objc func dismissButtonTouched() {
        dismiss(animated: true, completion: nil)
    }

    @objc func appleMusicConnectButtonTouched() {
        if defaults.bool(forKey: "appleMusicAuthorized") == false {
            SKCloudServiceController.requestAuthorization { (status) in // Add NSAppleMusicUsageDescription to plist
                if status == .authorized {
                    self.defaults.set(true, forKey: "appleMusicAuthorized")
                }
            }
        }
    }
}
