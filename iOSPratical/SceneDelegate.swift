//
//  SceneDelegate.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 18/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        
        let tasksCoordinator = TaskListCoordinator(navigationController: navigationController)
        tasksCoordinator.start()
             
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

