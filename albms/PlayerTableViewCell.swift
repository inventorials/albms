//
//  PlayerTableViewCell.swift
//  albms
//
//  Created by Armand Raynor on 10/11/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "song title"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            numberLabel.heightAnchor.constraint(equalToConstant: bounds.height - 20),
            numberLabel.widthAnchor.constraint(equalToConstant: bounds.height - 20)
        ])

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: bounds.height - 20)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
