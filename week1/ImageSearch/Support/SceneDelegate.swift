//
//  SceneDelegate.swift
//  ImageSearch
//
//  Created by Jinwoo Kim on 3/12/21.
//

import UIKit

internal final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    internal var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: windowScene)
        
        let vc: SearchViewController = .init()
        let nvc: UINavigationController = .init(rootViewController: vc)
        vc.loadViewIfNeeded()
        nvc.loadViewIfNeeded()
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
}

