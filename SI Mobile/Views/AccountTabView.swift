//
//  AccountTab.swift
//  SI Mobile
//
//  Created by Abdulla Fairooz on 09/11/2023.
//

import SwiftUI

struct AccountTabView: View {
    @StateObject var util: Util
    @StateObject var auth: UserStateViewModel
    
    
    var body: some View {
        LoadingView(isShowing: $util.loading){
            NavigationStack{
                VStack{
                    SINav(text: "Change Email", destination: AccountEmailChange(util:util, auth:auth))
                    SINav(text: "Change Password", destination: AccountPasswordChange(util: util, auth:auth))
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Account")
                        .foregroundColor(.white)
                }
            }
//            .toolbarBackground(Color.sigreendark, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountTabView(util: Util(), auth: UserStateViewModel())
}
