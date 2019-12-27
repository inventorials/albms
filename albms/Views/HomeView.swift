//
//  HomeView.swift
//  albms
//
//  Created by Armand Raynor on 10/11/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

class HomeView: UIView {

    let homeCollectionView = HomeCollectionView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Albms"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Below are a few albums that I have been listening to lately. Click an album to play it, and if you like what you hear, drag down to add it to your library."
        label.numberOfLines = -1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    let settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AlbmsColors.accentColor
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(HomeViewController.settingsButtonTouched), for: .touchUpInside)
        return button
    }()

    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.0
        return blurView
    }()

    let addToLibaryIcon: UIImageView = {
        let addToLibaryIcon = UIImageView()
        addToLibaryIcon.image = UIImage(named: "add")
        addToLibaryIcon.tintColor =  AlbmsColors.accentColor
        addToLibaryIcon.alpha = 0.0
        return addToLibaryIcon
    }()

    let removeFromLibraryIcon: UIImageView = {
        let removeFromLibraryIcon = UIImageView()
        removeFromLibraryIcon.image = UIImage(named: "cancel")
        removeFromLibraryIcon.tintColor = UIColor.darkGray
        removeFromLibraryIcon.alpha = 0.0
        return removeFromLibraryIcon
    }()

    let addToLibraryShadow = UIView()

    let removeFromLibraryShadow = UIView()

    override init (frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "homeView"
        setupView()
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    private func setupView() {

        addSubview(homeCollectionView)
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            homeCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            homeCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])

        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 70),
            descriptionLabel.bottomAnchor.constraint(equalTo: homeCollectionView.topAnchor)
        ])

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor)
        ])

        addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            settingsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.widthAnchor.constraint(equalToConstant: 50)
        ])

        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurView.centerYAnchor.constraint(equalTo: centerYAnchor),
            blurView.heightAnchor.constraint(equalTo: heightAnchor),
            blurView.widthAnchor.constraint(equalTo: widthAnchor)
        ])

        addSubview(removeFromLibraryIcon)
        removeFromLibraryIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removeFromLibraryIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            removeFromLibraryIcon.centerYAnchor.constraint(equalTo: homeCollectionView.topAnchor, constant: 100),
            removeFromLibraryIcon.widthAnchor.constraint(equalToConstant: 25),
            removeFromLibraryIcon.heightAnchor.constraint(equalToConstant: 25),
        ])

        addSubview(addToLibaryIcon)
        addToLibaryIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToLibaryIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            addToLibaryIcon.centerYAnchor.constraint(equalTo: homeCollectionView.bottomAnchor, constant: -100),
            addToLibaryIcon.widthAnchor.constraint(equalToConstant: 30),
            addToLibaryIcon.heightAnchor.constraint(equalToConstant: 30),
        ])

        addSubview(removeFromLibraryShadow)
        removeFromLibraryShadow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removeFromLibraryShadow.centerXAnchor.constraint(equalTo: centerXAnchor),
            removeFromLibraryShadow.topAnchor.constraint(equalTo: topAnchor, constant: -50),
            removeFromLibraryShadow.widthAnchor.constraint(equalTo: widthAnchor, constant: 100),
            removeFromLibraryShadow.heightAnchor.constraint(equalToConstant: 250),
        ])

        addSubview(addToLibraryShadow)
        addToLibraryShadow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToLibraryShadow.centerXAnchor.constraint(equalTo: centerXAnchor),
            addToLibraryShadow.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 50),
            addToLibraryShadow.widthAnchor.constraint(equalTo: widthAnchor, constant: 100),
            addToLibraryShadow.heightAnchor.constraint(equalToConstant: 150),
        ])

        homeCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "albumCollectionViewCell")
        homeCollectionView.layer.zPosition = 1
        addToLibraryShadow.layer.zPosition = 1
        removeFromLibraryShadow.layer.zPosition = 1
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
