//
//  SettingsViewController.swift
//  albms
//
//  Created by Armand Raynor on 10/14/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func shouldUpdateAccentColors(_ settingsView: SettingsView, withColor color: UIColor)
}

class SettingsViewController: UIViewController {

    private let settingsView = SettingsView()

    weak var settingsViewDelegate: SettingsViewDelegate?

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
        updateAccentColor(toColor: AlbmsColors.appleMusicColor)
    }

    private func updateAccentColor(toColor color: UIColor) {
        AlbmsColors.accentColor = color
        UIView.animate(withDuration: 0.5) {
            self.settingsView.backgroundColor = AlbmsColors.accentColor
        }
        settingsViewDelegate?.shouldUpdateAccentColors(settingsView, withColor: color)
    }
}
