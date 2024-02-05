//
//  SGTESTING01App.swift
//  SGTESTING01
//
//  Created by Abdulla Fairooz on 31/07/2023.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        FirebaseApp.configure()
        return true
    }
}


@main
struct SIMobileApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var util: Util
    @StateObject private var auth: UserStateViewModel
    
    
    
    
    @State var updateText = ""
    @State var updateAlert = false
    
  
    init(){
        //FirebaseApp.configure()
        _util = StateObject(wrappedValue: Util())
        _auth = StateObject(wrappedValue: UserStateViewModel())
     }
    var body: some Scene {
        WindowGroup {
            if(auth.isLoggedIn){
                MainTabView(util: util, auth:auth) .alert(isPresented: $util.showAlert){
                    Alert(title:Text("Alert"), message: Text(util.alertText), dismissButton: .default((Text("OK"))))
                }.preferredColorScheme(.light)
            }
            else{
                SplashScreen(auth:auth, util:util) .alert(isPresented: $util.showAlert){
                    Alert(title:Text("Alert"), message: Text(util.alertText), dismissButton: .default((Text("OK"))))
                }.preferredColorScheme(.light)
            }
        }
    }
}
