//
//  AppDelegate.swift
//  CafeHunter
//
//  Created by James Valaitis on 23/11/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool
	{
		FBSettings.setDefaultAppID("1517599985149849")
		
		return true
	}
	
	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool
	{
		let wasHandled = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
		
		return wasHandled
	}
}