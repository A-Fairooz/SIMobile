
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
    
    func loginStillValid() -> Bool{
        
        
        
        return true
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
        
}

func setLastLogin() {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    let dt = formatter.string(from: Date())
    UserDefaults.standard.set(String(describing: dt), forKey: "lastLogin")
}
