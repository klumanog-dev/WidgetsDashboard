//
//  BaseViewController.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 08/01/2024.
//

import Foundation
import UIKit

/**
 * Standard UIViewController. All customization should be done here.
 * This controller should be used accross the app when a view controller is needed.
 */

class BaseViewController: UIViewController {
    
    // MARK: - Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    @objc func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
