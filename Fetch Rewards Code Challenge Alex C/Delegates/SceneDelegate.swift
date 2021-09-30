//
//  SceneDelegate.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/27/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            let VC = CategoryViewController()
            let NC = UINavigationController(rootViewController: VC)
            self.window!.rootViewController = NC
            self.window!.makeKeyAndVisible()
            
            if #available(iOS 13.0, *) {
                self.window!.overrideUserInterfaceStyle = .light
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

