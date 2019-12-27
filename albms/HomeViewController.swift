//
//  HomeViewController.swift
//  albms
//
//  Created by Armand Raynor on 10/11/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    let transition = CircularTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewDidLayoutSubviews() {
        configureShadows()
    }

    private func setupView() {
        homeView.homeCollectionView.dataSource = self
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.homeCollectionViewDelegate = self

        view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    private func configureShadows() {
        let shadowRadius: CGFloat = 25.0
        let width = homeView.addToLibraryShadow.frame.width
        let height = homeView.addToLibraryShadow.frame.height
        let curveAmount: CGFloat = -200

        let addShadowPath = UIBezierPath()
        addShadowPath.move(to: CGPoint(x: 0, y: height))
        addShadowPath.addLine(to: CGPoint(x: width, y: height))
        addShadowPath.addLine(to: CGPoint(x: width, y: curveAmount))
        addShadowPath.addCurve(to: CGPoint(x: shadowRadius, y: curveAmount), controlPoint1: CGPoint(x: width, y: 0 - shadowRadius), controlPoint2: CGPoint(x: 0, y: 0 - shadowRadius))

        homeView.addToLibraryShadow.backgroundColor = .clear
        homeView.addToLibraryShadow.layer.shadowColor = AlbmsColors.accentColor.cgColor
        homeView.addToLibraryShadow.layer.shadowOpacity = 0.5
        homeView.addToLibraryShadow.layer.shadowRadius = shadowRadius
        homeView.addToLibraryShadow.layer.masksToBounds = false
        homeView.addToLibraryShadow.layer.shadowPath = addShadowPath.cgPath
        homeView.addToLibraryShadow.isHidden = false
        homeView.addToLibraryShadow.alpha = 0

        let removeShadowPath = UIBezierPath()
        removeShadowPath.move(to: CGPoint(x: 0, y: 0))
        removeShadowPath.addLine(to: CGPoint(x: width, y: 0))
        removeShadowPath.addLine(to: CGPoint(x: width, y: height - curveAmount))
        removeShadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height - curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))

        homeView.removeFromLibraryShadow.backgroundColor = .clear
        homeView.removeFromLibraryShadow.layer.shadowColor = UIColor.darkGray.cgColor
        homeView.removeFromLibraryShadow.layer.shadowOpacity = 0.5
        homeView.removeFromLibraryShadow.layer.shadowRadius = shadowRadius
        homeView.removeFromLibraryShadow.layer.masksToBounds = false
        homeView.removeFromLibraryShadow.layer.shadowPath = removeShadowPath.cgPath
        homeView.removeFromLibraryShadow.isHidden = false
        homeView.removeFromLibraryShadow.alpha = 0
    }

    func transitionToPlayerViewController() {
        present(PlayerViewController(), animated: true, completion: nil)
    }

    @objc func settingsButtonTouched() {
        let settingsViewController = SettingsViewController()
        settingsViewController.transitioningDelegate = self
        settingsViewController.modalPresentationStyle = .custom
        settingsViewController.settingsViewDelegate = self
        show(settingsViewController, sender: self)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        transitionToPlayerViewController()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionViewCell", for: indexPath as IndexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }

        cell.coverArt.setRounded()
        cell.artistNameLabel.textColor = AlbmsColors.accentColor
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insetWidth = (collectionView.frame.width / 2) - (collectionView.frame.width * 0.3)
        return UIEdgeInsets(top: 0, left: insetWidth, bottom: 0, right: insetWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.6, height: collectionView.frame.height)
    }
}


extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = homeView.settingsButton.center
        transition.circleColor = homeView.settingsButton.backgroundColor!
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = homeView.settingsButton.center
        transition.circleColor = homeView.settingsButton.backgroundColor!
        return transition
    }
}

extension HomeViewController: HomeCollectionViewDelegate {

    func didBeginLongPressAction(_ homeCollectionView: HomeCollectionView, withCell cell: AlbumCollectionViewCell, adjacentCells: [AlbumCollectionViewCell]) {
        UIView.animate(withDuration: 0.25) {
            self.homeView.blurView.alpha = 1.0
            cell.albumTitleLabel.alpha = 0.0
            cell.artistNameLabel.alpha = 0.0
            cell.coverArt.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)

            self.homeView.addToLibaryIcon.alpha = 1.0
            self.homeView.removeFromLibraryIcon.alpha = 1.0

            self.homeView.addToLibaryIcon.center = CGPoint(x: self.homeView.addToLibaryIcon.center.x, y: self.homeView.addToLibaryIcon.center.y + 50)
            self.homeView.removeFromLibraryIcon.center = CGPoint(x: self.homeView.removeFromLibraryIcon.center.x, y: self.homeView.removeFromLibraryIcon.center.y - 50)

            for adjacentCell in adjacentCells {
                adjacentCell.coverArt.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
                adjacentCell.albumTitleLabel.alpha = 0.0
                adjacentCell.artistNameLabel.alpha = 0.0
            }
        }
    }

    func didUpdateLongPressAction(_ homeCollectionView: HomeCollectionView, showAddShadow: Bool, showRemoveShadow: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.homeView.addToLibraryShadow.alpha = showAddShadow ? 1.0 : 0.0
            self.homeView.removeFromLibraryShadow.alpha = showRemoveShadow ? 1.0 : 0.0
        }
    }

    func didEndLongPressAction(_ homeCollectionView: HomeCollectionView, withCell cell: AlbumCollectionViewCell, adjacentCells: [AlbumCollectionViewCell]) {
        UIView.animate(withDuration: 0.25) {
            self.homeView.blurView.alpha = 0.0
            cell.albumTitleLabel.alpha = 1.0
            cell.artistNameLabel.alpha = 1.0
            cell.coverArt.transform = CGAffineTransform.identity

            self.homeView.addToLibraryShadow.alpha = 0.0
            self.homeView.addToLibaryIcon.alpha = 0.0
            self.homeView.removeFromLibraryShadow.alpha = 0.0
            self.homeView.removeFromLibraryIcon.alpha = 0.0

            self.homeView.addToLibaryIcon.center = CGPoint(x: self.homeView.addToLibaryIcon.center.x, y: self.homeView.addToLibaryIcon.center.y - 50)
            self.homeView.removeFromLibraryIcon.center = CGPoint(x: self.homeView.removeFromLibraryIcon.center.x, y: self.homeView.removeFromLibraryIcon.center.y + 50)

            for adjacentCell in adjacentCells {
                adjacentCell.coverArt.transform = CGAffineTransform.identity
                adjacentCell.albumTitleLabel.alpha = 1.0
                adjacentCell.artistNameLabel.alpha = 1.0
            }
        }
    }
}

extension HomeViewController: SettingsViewDelegate {
    func shouldUpdateAccentColors(_ settingsView: SettingsView, withColor color: UIColor) {
        for albumCollectionViewCell in self.homeView.homeCollectionView.visibleCells {
            if let cell = albumCollectionViewCell as? AlbumCollectionViewCell {
                cell.artistNameLabel.textColor = AlbmsColors.accentColor
            }
        }
        homeView.addToLibaryIcon.tintColor = AlbmsColors.accentColor
        homeView.settingsButton.backgroundColor = AlbmsColors.accentColor
        homeView.addToLibraryShadow.layer.shadowColor = AlbmsColors.accentColor.cgColor
    }
}

extension HomeViewController: AlbumTappedDelegate {
    func albumTapped() {
        print("Image tapped")
    }
}
