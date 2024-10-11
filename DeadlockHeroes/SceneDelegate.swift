//
//  SceneDelegate.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 05/10/2024.
//

import Swinject
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let tabBarController = UITabBarController()
        let heroesVC = UINavigationController(rootViewController: HeroesListVC())
        heroesVC.navigationBar.standardAppearance = navBarAppearance
        heroesVC.navigationBar.scrollEdgeAppearance = navBarAppearance
        heroesVC.viewControllers.first?.title = "Heroes"
        
        let itemsVC = UINavigationController(rootViewController: ItemsListVC())
        itemsVC.navigationBar.standardAppearance = navBarAppearance
        itemsVC.navigationBar.scrollEdgeAppearance = navBarAppearance
        itemsVC.viewControllers.first?.title = "Items"
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white

        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        heroesVC.tabBarItem = UITabBarItem(title: "Heroes", image: UIImage(systemName: "brain.head.profile.fill"), tag: 0)
        itemsVC.tabBarItem = UITabBarItem(title: "Items", image: UIImage(systemName: "line.3.horizontal.circle"), tag: 1)
        
        tabBarController.viewControllers = [heroesVC, itemsVC]
        
        window?.rootViewController = tabBarController
    }

}

