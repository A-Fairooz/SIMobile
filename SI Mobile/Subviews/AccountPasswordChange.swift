//
//  AccountPasswordChange.swift
//  SI Mobile
//
//  Created by Abdulla Fairooz on 09/11/2023.
//

import SwiftUI

struct AccountPasswordChange: View {
    
    @StateObject var util: Util
    @StateObject var auth: UserStateViewModel
    @State private var currentEmail = ""
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var newPasswordConfirmation = ""
    private let maxAttempts = 5
    @State private var attempts = 0
    @State private var showConfirmDialog = false
    @State private var isVerified = false
    var body: some View {
        LoadingView(isShowing: $util.loading){
            
            VStack{
                Spacer()
                Text("Change Email")
                SITextField("Current Email", $currentEmail)
                SISecureField("Current Password", $currentPassword).textContentType(.password)
                SISecureField("New Password", $newPassword)
                SISecureField("Confirm New Password", $newPasswordConfirmation)
                SIButton(action:{verifyCreds()}, text:"Confirm")
                Spacer()
                
            }.padding(15)
                .confirmationDialog("Are you sure you want to change your password?", isPresented: $showConfirmDialog){
                    Button("Confirm"){applyChange()}
                    
                }
            
        }
    }
    
    func verifyCreds(){
        var valid = false
        var resultText = ""
        if !isVerified{
            
            auth.reauthenticate(email: currentEmail, password: currentPassword){result in
                resultText = result
                valid = result.uppercased().contains("SUCCESS") ? true : false
                isVerified = valid
            }
        }
        else{
            valid = true
            isVerified = valid
        }
        
        
        if valid{
            verifyNewDetails()
        }
        else{
            attempts = attempts + 1
            util.alertText = "\(resultText), attempts remaining: \(maxAttempts - attempts)"
            util.showAlert = true
        }
        
        if attempts >= maxAttempts{
            //Exit
        }
        
    }
    
    func verifyNewDetails(){
        if newPassword != newPasswordConfirmation{
            util.alertText = "Passwords do not match"
            util.showAlert = true
        }
        else{
            showConfirmDialog = true
        }
    }
    
    
    
    func applyChange(){
        auth.changePassword(newPassword: newPassword){result in
            if result.lowercased().contains("success"){
                util.alertText = result
                auth.isLoggedIn = false
            }
            else{
                util.alertText = result
            }
           
            util.showAlert = true
        }
      
      
    }
    
}

#Preview {
    AccountPasswordChange(util: Util(), auth: UserStateViewModel())
}
