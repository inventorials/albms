//
//  SettingsView.swift
//  albms
//
//  Created by Armand Raynor on 10/14/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add An\nAccount."
        label.numberOfLines = -1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        return label
    }()

    let appleMusicConnectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AlbmsColors.appleMusicColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(SettingsViewController.appleMusicConnectButtonTouched), for: .touchUpInside)
        return button
    }()

    let settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(SettingsViewController.dismissButtonTouched), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 150),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ])

        addSubview(appleMusicConnectButton)
        appleMusicConnectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleMusicConnectButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            appleMusicConnectButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            appleMusicConnectButton.heightAnchor.constraint(equalToConstant: 50),
            appleMusicConnectButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -75)
        ])

        addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            settingsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
