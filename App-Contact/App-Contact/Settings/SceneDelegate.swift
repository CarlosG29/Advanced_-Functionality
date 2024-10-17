//
//  SceneDelegate.swift
//  App-Contact
//
//  Created by Carlos Eduardo Gurdian on 14/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .systemTeal
    }
    
    // MARK: - Tab Bar Configuration
    private func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemTeal
        tabBar.viewControllers = [createContactListNavigationController()]
        return tabBar
    }
    
    private func createContactListNavigationController() -> UINavigationController {
        let contactListController = ContactList()
        contactListController.title = "Contacts"
        contactListController.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(systemName: "person.2"), tag: 0)
        return UINavigationController(rootViewController: contactListController)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
