
import Firebase
import Foundation
import SwiftUI

enum UserStateError: String, Error {
    case wrongUsernamePassword = "Username or Password is incorrect"
    case signInError = "There was a problem signing in"
    case signOutError = "There was a problem signing out"
}

// @MainActor
class UserStateViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    @Published var hasError = false
    @Published var errorMessage = ""
    
    @Published var resetState = false
    @Published var resetMessage = ""
    
    @Published var authDur = 59
    
    init(){
        let initLogin = UserDefaults.standard.string(forKey: "lastLogin") ?? ""
        if initLogin.isEmpty{
            setLastLogin()
            self.isLoggedIn = false
            UserDefaults.standard.set(false, forKey: "loggedIn")
        }
        else{
            self.isLoggedIn = loggedIn()
        }
    }
    
    func loggedIn() -> Bool{
        let stillLoggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        if !stillLoggedIn { return false }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let lastLogin = formatter.date(from: UserDefaults.standard.string(forKey: "lastLogin") ?? "")
        
        let diff = Date().timeIntervalSince(lastLogin ?? Date())
        
        if diff < 7200 {
            return true
        } else {
            return false
        }
    }
    
//    func firebaseLogin(email: String, password: String) async -> String {
//        isLoading = true
//
//        do {
//            try await Auth.auth().signIn(withEmail: email, password: password)
//            isLoading = false
//            isLoggedIn = true
//            UserDefaults.standard.set(true, forKey: "loggedIn")
//            setLastLogin()
//            return "OK"
//
//        } catch {
//            isLoading = false
//            errorMessage = error.localizedDescription
//            return errorMessage
//        }
//
//    }
    
//    func firebaseLogout() async {
//        isLoading = true
//        hasError = false
//        do {
//            try Auth.auth().signOut()
//            isLoading = false
//            UserDefaults.standard.set(false, forKey: "loggedIn")
//            isLoggedIn = false
//        } catch {
//            hasError = true
//            errorMessage = error.localizedDescription
//            isLoading = false
//        }
//    }
//
//    func resetPassword(email: String, completion: @escaping (Bool) -> Void) async {
//        if email.isEmpty {
//            resetState = true
//            resetMessage = "No Email Provided"
//            completion(false)
//        }
//        isLoading = true
//        resetState = false
//        do {
//            try await Auth.auth().sendPasswordReset(withEmail: email)
//            isLoading = false
//            resetState = true
//            resetMessage = "If the account exists, password reset instructions will be sent to the email provided"
//            completion(true)
//        } catch {
//            resetMessage = error.localizedDescription
//            resetState = true
//            isLoading = false
//            completion(false)
//        }
//    }
    
    func getUser() -> Firebase.User! {
        Auth.auth().currentUser
    }
    
    func reauthenticate(email: String, password: String, completion: @escaping (String) -> Void) {
        let u = getUser()
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        u?.reauthenticate(with: credential) { result, error in
            if error != nil {
                completion(error!.localizedDescription)
            } else {
                completion("Success!\(result!.description)")
            }
        }
    }
    //
    //    func lastReauthTime() -> Int {
    //        let u = Auth.auth().currentUser
    //
    //        if u == nil {
    //            return 9999
    //        }
    //
    //        let date1 = u!.metadata.lastSignInDate!
    //        let date2 = Date()
    //        let diffs = Calendar.current.dateComponents([.minute], from: date1, to: date2)
    //
    //        return diffs.minute!
    //    }
    
        func changeEmail(newEmail: String, completion: @escaping (String) -> Void) {
            let u = getUser()
            u?.updateEmail(to: newEmail) { error in
                if error != nil {
                    completion(error!.localizedDescription)
                } else {
                    u?.sendEmailVerification { err in
                        if err != nil {
                            completion("Email updated, \(err!.localizedDescription), returning to login screen")
                        } else {
                            completion("Email updated, please check your inbox for a verification email, returning to login screen")
                        }
                    }
                }
            }
        }
    
        func changePassword(newPassword: String, completion: @escaping (String) -> Void) {
            let u = getUser()
            u?.updatePassword(to: newPassword) { error in
                if error != nil {
                    completion(error!.localizedDescription)
                } else {
                    completion("Password changed successfully, returning to login screen")
                }
            }
        }
    
    //    func sendValidationEmail(completion: @escaping (String) -> Void) {
    //        let u = getUser()
    //        if u != nil, !u!.isEmailVerified {
    //            u?.sendEmailVerification { error in
    //                if error != nil {
    //                    completion(error!.localizedDescription)
    //                } else {
    //                    completion("Please check your inbox for the verification link")
    //                }
    //            }
    //        } else if u!.isEmailVerified {
    //            completion("Email is already verified!x")
    //        }
    //    }
}

func setLastLogin() {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    let dt = formatter.string(from: Date())
    UserDefaults.standard.set(String(describing: dt), forKey: "lastLogin")
}
