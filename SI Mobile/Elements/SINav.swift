
import SwiftUI
import Foundation

struct SINav<TargetView: View>: View {
    var text: String
    var destination: TargetView
    var width: CGFloat?
    var body: some View {
        if width != nil{
            NavigationLink(text){destination}
                .frame(width:width!)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.siorange)
                .cornerRadius(10)
        }
        else{
            NavigationLink(text){destination}
                .padding(10)
                .foregroundColor(.white)
                .background(Color.siorange)
                .cornerRadius(10)
        }
    }
}

struct SINavAct<TargetView: View>: View {
    var text: String
    var destination: TargetView
    var width: CGFloat?
    @Binding var isActive: Bool
    var body: some View {
        if width != nil{
            NavigationLink(text, isActive: $isActive){destination}
                .frame(width:width!)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.siorange)
                .cornerRadius(10)
        }
        else{
            NavigationLink(text,isActive: $isActive){destination}
                .padding(10)
                .foregroundColor(.white)
                .background(Color.siorange)
                .cornerRadius(10)
        }
    }
}

//struct SGNav_Previews: PreviewProvider {
//    static var previews: some View {
//        //SGNav()
//    }
//}
