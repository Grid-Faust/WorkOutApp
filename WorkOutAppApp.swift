//
//  WorkOutAppApp.swift
//  WorkOutApp
//
//  Created by Дмитрий Емелин on 21.03.2023.
//

import SwiftUI
import FirebaseCore

@main
struct WorkOutAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("!!! PRINT: - setting Firebase")
    FirebaseApp.configure()
    return true
  }
}

