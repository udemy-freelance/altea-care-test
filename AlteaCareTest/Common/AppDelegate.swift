//
//  AppDelegate.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import UIKit
import IQKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        
        let view = HomeViewController()
        let presenter = HomePresenter(view: view, service: HomeService())
        view.presentor = presenter
        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: view)
        window?.makeKeyAndVisible()
        
        return true
    }
}
