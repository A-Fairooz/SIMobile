
import SwiftUI
import Firebase
import Foundation

struct LoginView: View {
    @StateObject var auth: UserStateViewModel
    @StateObject var util: Util
    @State private var email = ""
    @State private var password = ""
    @State private var loading = false
    @State private var resetActive = false
    @State private var rememberMe = false
    @State private var vis = false
    @State private var updateText = ""
    @State private var updateAlert = false
    
    var body: some View {
        LoadingView(isShowing: $auth.isLoading){
            NavigationView{
                VStack{
                    Image("SCENTINTERNATIONAL_FINAL_FINAL")
                        .resizable()
                        .scaledToFit()
                        .frame(width:150, height: 150)
                    SITextField("Email", $email, 300)
                    SISecureField("Password", $password, 300)
                    SIButton(action:{Task{await login()}}, text:"Login", width: 150)
                    SINavAct(text: "Reset Password", destination: ResetPasswordView(isActive: $resetActive, email: email ), width:150, isActive: $resetActive)
                    
                    HStack{
                        Text("Remember me")
                        Toggle(isOn:$rememberMe){}
                            .frame(width:50)
                    .toggleStyle( .switch)
                    .onChange(of: rememberMe){dat in
                        UserDefaults.standard.set(dat,forKey: "rememberMe")
                        if dat == false {UserDefaults.standard.set("",forKey: "storedEmail")}
                    }
                        
                    }.frame(width:220)
                }
                .onAppear{
                    withAnimation(Animation.easeOut(duration: 0.5).delay(0)){
                        self.vis = true
                    }
                }.opacity(vis ? 1 : 0)
            }.onAppear{
                rememberMe = UserDefaults.standard.bool(forKey: "rememberMe")
                if rememberMe{
                    email = UserDefaults.standard.string(forKey: "storedEmail") ?? ""
                }
                
                API().checkForUpdate(){ result in
                    if result != "Up To Date" && !result.lowercased().contains("error"){
                        updateText = result
                        updateAlert = true
                    }
                    else{
                        updateText = ""
                        updateAlert = false
                    }
                    
                    
                }
            }
            .alert("Update", isPresented: $updateAlert, actions: {
                let updateUrl = URL(string: API().updateUrl)
                Button("Update", action:{UIApplication.shared.open(updateUrl!)})
                Button("Cancel", role:.cancel, action:{})
            }) {Text(updateText)}
        }
    }
    func login() async{
        auth.isLoading = true
        if rememberMe{
            UserDefaults.standard.set(email,forKey: "storedEmail")
        }
        do {
            
                try await Auth.auth().signIn(withEmail: email, password: password)
                auth.isLoading = false
                auth.isLoggedIn = true
                UserDefaults.standard.set(true, forKey: "loggedIn")
                setLastLogin()
                
            
            
        } catch {
            auth.isLoading = false
            util.alertText = error.localizedDescription
            util.showAlert = true
        }
    }
}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(auth: UserStateViewModel())
//    }
//}
