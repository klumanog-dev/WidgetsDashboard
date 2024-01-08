//
//  NavigationController.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 08/01/2024.
//

import Foundation
import UIKit

final class NavigationController: UINavigationController {

    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTranslucentNavigationBar()
    }

    func setupTranslucentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                             .font: UIFont.title]
    }
}

// MARK: - Constants -

private extension UIFont {
    static let title: UIFont = systemFont(ofSize: PADDING14)
}
