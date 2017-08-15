 //
//  AppDelegate.swift
//  Groceries
//
//  Created by Greyson Wright on 3/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
		let homeNavController = FatNavigationController(navigationBarClass: FatNavigationBar.self, toolbarClass: nil)
		homeNavController.viewControllers.append(homeViewController)
		
		let inventoryViewController = InventoryViewController(nibName: "InventoryViewController", bundle: nil)
		let inventoryNavController = FatNavigationController(navigationBarClass: FatNavigationBar.self, toolbarClass: nil)
		inventoryNavController.viewControllers.append(inventoryViewController)
		
		let accountViewController = AccountViewController(nibName: "AccountViewController", bundle: nil)
		let accountNavController = FatNavigationController(navigationBarClass: FatNavigationBar.self, toolbarClass: nil)
		accountNavController.viewControllers.append(accountViewController)
		
		let tabBarController = UITabBarController()
		tabBarController.tabBar.isTranslucent = false
		tabBarController.tabBar.tintColor = UIColor.tabBarTint
		tabBarController.tabBar.barTintColor = UIColor.tabBarBackground
		tabBarController.tabBar.layer.borderColor = UIColor.tabBarBackground.cgColor
		if #available(iOS 10.0, *) {
			tabBarController.tabBar.unselectedItemTintColor = UIColor.tabBarUnselectedTint
		} else {
			tabBarController.tabBar.tintColor = UIColor.tabBarUnselectedTint
			tabBarController.tabBar.selectedImageTintColor = UIColor.tabBarTint
		}
		tabBarController.viewControllers = [homeNavController, inventoryNavController, accountNavController]
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
}

