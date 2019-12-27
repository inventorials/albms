//
//  PlayerView.swift
//  albms
//
//  Created by Armand Raynor on 10/11/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    let playerTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        return tableView
    }()

    let bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = .zero
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return effectView
    }()

    override init (frame: CGRect) {
        super.init(frame: frame)
        setupView()
        registerCells()
    }

    private func setupView() {
        addSubview(bgImage)
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgImage.widthAnchor.constraint(equalTo: widthAnchor),
            bgImage.heightAnchor.constraint(equalTo: heightAnchor)
        ])

        addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurEffectView.widthAnchor.constraint(equalTo: widthAnchor),
            blurEffectView.heightAnchor.constraint(equalTo: heightAnchor)
        ])

        addSubview(playerTableView)
        playerTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            playerTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            playerTableView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    private func registerCells() {
        playerTableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "playerTableViewCell")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
