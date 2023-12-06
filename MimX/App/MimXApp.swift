//
//  MimXApp.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import SwiftUI
import CoreData
import FirebaseCore

@main
struct MimXApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, FavouriteVideosContainer().persistentContainer.viewContext)
                .environmentObject(SettingsViewModel())
                
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
