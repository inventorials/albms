//
//  AlbumCollectionViewCell.swift
//  albms
//
//  Created by Armand Raynor on 10/11/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

protocol AlbumTappedDelegate {
    func albumTapped()
}

class AlbumCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    var delegate : AlbumTappedDelegate?

    let coverArt: UIImageView = {
        var image = UIImage(named: "placeholder")!
        let imageView = UIImageView(image: image)
        //imageView.convertImageToGrayscale()
        return imageView
    }()

    let dropShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 20)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 10.0
        view.layer.masksToBounds = false
        view.isUserInteractionEnabled = true
        return view
    }()

    let albumTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title Label"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
        label.textColor = AlbmsColors.accentColor
        label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .clear
        contentView.isUserInteractionEnabled = true

        contentView.addSubview(dropShadow)
        dropShadow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropShadow.centerXAnchor.constraint(equalTo: centerXAnchor),
            dropShadow.centerYAnchor.constraint(equalTo: centerYAnchor),
            dropShadow.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            dropShadow.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])

        dropShadow.addSubview(coverArt)
        coverArt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverArt.centerXAnchor.constraint(equalTo: dropShadow.centerXAnchor),
            coverArt.centerYAnchor.constraint(equalTo: dropShadow.centerYAnchor),
            coverArt.widthAnchor.constraint(equalTo: dropShadow.widthAnchor),
            coverArt.heightAnchor.constraint(equalTo: dropShadow.heightAnchor)
        ])

        contentView.addSubview(albumTitleLabel)
        albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            albumTitleLabel.topAnchor.constraint(equalTo: coverArt.bottomAnchor, constant: 40),
            albumTitleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            albumTitleLabel.heightAnchor.constraint(equalToConstant: 25)
        ])

        contentView.addSubview(artistNameLabel)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: albumTitleLabel.bottomAnchor, constant: 5),
            artistNameLabel.widthAnchor.constraint(equalTo: widthAnchor),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
