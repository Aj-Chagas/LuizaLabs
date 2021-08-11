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

        let nav = NavigationController()
        let controller = makeSearchTwitterFactory(router: makeSearchTwitterRouter(nav: nav))
        nav.setRootViewController(controller)

        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

}

