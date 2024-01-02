
import SwiftUI
import Foundation
import Firebase

struct SettingsTabView: View {
    @StateObject var util: Util
    @StateObject var auth: UserStateViewModel
    @State private var confirmLogout = false
        
    var body: some View {
        VStack{
            List{
                SISetting("Only show products in stock", AnyView(Toggle("",isOn:$util.inStockOnly).onChange(of: util.inStockOnly){_ in updateSettings()}))
                
                SISetting("Keep BERT End Date to current day", AnyView(Toggle("",isOn:$util.bertEndToday).onChange(of: util.bertEndToday){_ in updateSettings()}))
                
                SISetting("Save BERT Parameters", AnyView(Toggle("",isOn:$util.saveBERT).onChange(of: util.saveBERT){_ in updateSettings()}))
                
                SISetting("Customer Mode", AnyView(Toggle("",isOn:$util.cMode).onChange(of: util.cMode){_ in updateSettings()}))
                
                HStack{
                    Spacer()
                    SIButton(action:{confirmLogout = true}, text:"Logout")
                    Spacer()
                }
            }
        }.alert(isPresented: $confirmLogout){
            Alert(title:Text("Notice"),message:Text("Are you sure you want to logout?"), primaryButton: .destructive(Text("Logout")){Task{await firebaseLogout()}}, secondaryButton: .default(Text("Cancel")))}
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("Settings")
                    .foregroundColor(.white)
            }
        }
//        .toolbarBackground(Color.sigreendark, for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//        .navigationBarTitleDisplayMode(.inline)
    }
    
    func updateSettings(){
        SetBoolValue(util.inStockOnly, "inStockOnly")
        SetBoolValue(util.bertEndToday, "bertEndToday")
        SetBoolValue(util.saveBERT, "saveBERT")
        SetBoolValue(util.cMode, "cMode")
    }
    
    func SetBoolValue(_ value: Bool, _ key: String ){
        UserDefaults.standard.set(value, forKey: key)
    }
        
    func firebaseLogout() async {
        util.loading = true
        do {
            try Auth.auth().signOut()
            util.loading = false
            UserDefaults.standard.set(false, forKey: "loggedIn")
            auth.isLoggedIn = false
        }
        catch {
            util.loading = false
            util.alertText = error.localizedDescription
            util.showAlert = true
        }
    }
}
