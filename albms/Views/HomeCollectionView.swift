//
//  HomeCollectionView.swift
//  albms
//
//  Created by Armand Raynor on 12/19/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

protocol HomeCollectionViewDelegate: AnyObject {
    func didBeginLongPressAction(_ homeCollectionView: HomeCollectionView, withCell cell: AlbumCollectionViewCell, adjacentCells: [AlbumCollectionViewCell])
        func didUpdateLongPressAction(_ homeCollectionView: HomeCollectionView, showAddShadow: Bool, showRemoveShadow: Bool)
    func didEndLongPressAction(_ homeCollectionView: HomeCollectionView, withCell cell: AlbumCollectionViewCell, adjacentCells: [AlbumCollectionViewCell])
}

class HomeCollectionView: UICollectionView {
    weak var homeCollectionViewDelegate: HomeCollectionViewDelegate?

    private var homeViewControllerImageLocation: CGPoint = .zero
    private var selectedAlbumCollectionViewCell: AlbumCollectionViewCell? = nil
    private var adjacentAlbumCollectionViewCells: [AlbumCollectionViewCell] = []

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }

    convenience init() {
        let layout = SnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: layout)

        self.backgroundColor = .clear
        self.allowsSelection = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = .fast
        self.isUserInteractionEnabled = true

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(homeCollectionViewlongPressHandler(recognizer:)))
        longPressRecognizer.minimumPressDuration = 1.5
        self.addGestureRecognizer(longPressRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func homeCollectionViewlongPressHandler(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        switch recognizer.state {
        case .began:
            guard let indexPath = self.indexPathForItem(at: location) else { return }
            guard let cell: AlbumCollectionViewCell = self.cellForItem(at: indexPath) as? AlbumCollectionViewCell else { return }

            var adjacentCells: [AlbumCollectionViewCell] = []

            let beforeIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if let beforeCell = self.cellForItem(at: beforeIndexPath) as? AlbumCollectionViewCell {
                adjacentCells.append(beforeCell)
            }

            let afterIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if let afterCell = self.cellForItem(at: afterIndexPath) as? AlbumCollectionViewCell {
                adjacentCells.append(afterCell)
            }

            selectedAlbumCollectionViewCell = cell
            homeViewControllerImageLocation = cell.center
            adjacentAlbumCollectionViewCells = adjacentCells
            homeCollectionViewDelegate?.didBeginLongPressAction(self, withCell: cell, adjacentCells: adjacentCells)

            self.beginInteractiveMovementForItem(at: indexPath)
        case .changed:
            var newLocation: CGPoint = .zero
            var showAddShadow = false
            var showRemoveShadow = false
            if let cell = selectedAlbumCollectionViewCell {
                if cell.center.y > homeViewControllerImageLocation.y - 70 && cell.center.y < homeViewControllerImageLocation.y + 70 {
                    // sets boundaries for the cell
                    newLocation = CGPoint(x: homeViewControllerImageLocation.x, y: location.y)
                } else if cell.center.y > homeViewControllerImageLocation.y - 70 {
                    // keeps it from being stuck at the bottom
                    if location.y < cell.center.y {
                        newLocation = CGPoint(x: homeViewControllerImageLocation.x, y: location.y)
                    } else {
                        showAddShadow = true
                    }
                } else if cell.center.y < homeViewControllerImageLocation.y + 70 {
                    // keeps it from being stuck at the top
                    if location.y > cell.center.y {
                        newLocation = CGPoint(x: homeViewControllerImageLocation.x, y: location.y)
                    } else {
                        showRemoveShadow = true
                    }
                }
            }
            if newLocation != .zero {
                self.updateInteractiveMovementTargetPosition(newLocation)
            }
            homeCollectionViewDelegate?.didUpdateLongPressAction(self, showAddShadow: showAddShadow, showRemoveShadow: showRemoveShadow)
        case.ended:
            self.performBatchUpdates({
                self.endInteractiveMovement()
            }, completion: nil)

            if let cell = selectedAlbumCollectionViewCell {
                homeCollectionViewDelegate?.didEndLongPressAction(self, withCell: cell, adjacentCells: adjacentAlbumCollectionViewCells)
            }
        default:
            self.cancelInteractiveMovement()
        }
    }
}
