//
//  FoodtrucksApp.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-10-28.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


@main
struct FoodtrucksApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var dbConnection = DatabaseConnection()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dbConnection)
        }
    }
    
}
