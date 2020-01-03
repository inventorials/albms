//
//  SettingsView.swift
//  albms
//
//  Created by Armand Raynor on 10/14/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

fileprivate class AppleMusicConnectButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .white : .clear
        }
    }
}

class SettingsView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Connect\nYour Account."
        label.numberOfLines = -1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        return label
    }()

    let appleMusicConnectButton: UIButton = {
        let button = AppleMusicConnectButton()
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.setTitle("Connect to Apple Music", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(SettingsViewController.appleMusicConnectButtonTouched), for: .touchUpInside)
        return button
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Albms uses your Apple Music subscription to play albums and add them to your library."
        label.numberOfLines = -1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()

    let settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.imageView?.layer.cornerRadius = 25
        button.imageView?.clipsToBounds = true
        button.imageView?.layer.masksToBounds = true
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

        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: appleMusicConnectButton.bottomAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(equalTo: appleMusicConnectButton.heightAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: appleMusicConnectButton.widthAnchor)
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
