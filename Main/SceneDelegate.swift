//
//  SceneDelegate.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
//        let welcomeRouter = WelcomeRouter(nav: nav, loginFactory: loginFactory, signUpFactory: signUpFactory)
//        let welcomeViewController = WelcomeViewController.instantiate()
//        welcomeViewController.signUp = welcomeRouter.gotoSignUp
//        welcomeViewController.login = welcomeRouter.gotoLogin
        
        let controller = SearchTwitterViewController.instantiate()
        
        let nav = UINavigationController(rootViewController: controller)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

}

