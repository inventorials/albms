//
//  PlayerViewController.swift
//  albms
//
//  Created by Armand Raynor on 10/11/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    private let playerView = PlayerView()
    private var contentViewControllers: [UIViewController] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.playerTableView.delegate = self
        playerView.playerTableView.dataSource = self

        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    internal func setupChildViewControllers(viewController: UIViewController) {
        contentViewControllers.append(viewController)
        addChildContentViewController(viewController: viewController)
    }

    private func addChildContentViewController(viewController: UIViewController) {
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
}

extension PlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerTableViewCell", for: indexPath) as? PlayerTableViewCell else {
            return UITableViewCell()
        }
        cell.numberLabel.text = "\(indexPath.row + 1)"
        return cell
    }
}

extension PlayerViewController: UITableViewDelegate {

}
