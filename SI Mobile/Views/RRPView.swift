
import SwiftUI

struct RRPView: View {
    @StateObject var util: Util
    var body: some View {
        LoadingView(isShowing:$util.loading){
            NavigationStack{
                VStack{
                    Text("Work In Progress").rotationEffect(Angle(degrees: -45)).font(.largeTitle)
                }
            }
        }
    }
}

struct RRPView_Previews: PreviewProvider {
    static var previews: some View {
        RRPView(util: Util())
    }
}
