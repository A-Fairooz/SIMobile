
import SwiftUI
import Firebase
import Foundation

struct ResetPasswordView: View {
    @Binding var isActive: Bool
    @State var email = ""
    @State private var showAlert = false
    @State private var alertText = ""
    @State private var loading = false
    @State private var errorTrig = false
    var body: some View {
        LoadingView(isShowing: $loading){
            NavigationView{
                VStack{
                    SITextField("Email",$email, 300)
                    SIButton(action:{Task{await resetPassword()}}, text:"Submit",width:150)
                }
                .alert(isPresented:$showAlert){
                    Alert(title: Text("Notice"), message: Text(alertText), dismissButton: .default(Text("OK")){if !errorTrig{isActive = false}})
                        
                }
            }
        }
    }
    
    func resetPassword() async {
        loading = true
        errorTrig = false
        if email.isEmpty {
            errorTrig = true
            loading = false
            alertText = "No Email Provided"
            showAlert = true
        }
        
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            errorTrig = false
            loading = false
            alertText = "If the account exists, password reset instructions will be sent to the email provided"
            showAlert = true
            
        } catch {
            errorTrig = true
            loading = false
            alertText = error.localizedDescription
            showAlert = false
        }
    }
}

//struct ResetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetPasswordView()
//    }
//}
