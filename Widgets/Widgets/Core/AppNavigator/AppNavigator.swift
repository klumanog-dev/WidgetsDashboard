//
//  AppNavigator.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 04/01/2024.
//

import Foundation
import UIKit

/** Used for loading the app structure at turning points like app launch, login or logout */
final class AppNavigator {
    /** Replaces root view controller with animation */
    
    static var navigationController: NavigationController?
    
    static func setRootViewController(_ rootController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate),
           let window = sceneDelegate.window {
            navigationController = NavigationController(rootViewController: rootController)
            
            if !animated || window.rootViewController == nil {
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
                completion?()
            } else {
                UIView.transition(with: window, duration: 0.25,
                                  options: UIView.AnimationOptions.transitionFlipFromRight, animations: {
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }, completion: {_ in completion?()})
            }
        }
    }
    
    static func loadMainAppStructure() {
        // Add more logic to handle navigation when app launches.
        // Currently, we only need to display the home screen
        displayHomeScreen()
    }
 
    static func displayHomeScreen() {
        let widgetDashboardViewController = WidgetDashboardViewController(viewModel: WidgetDashboardViewModel())
        setRootViewController(widgetDashboardViewController, animated: true)
    }
}
