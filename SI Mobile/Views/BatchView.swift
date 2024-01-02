
import SwiftUI

struct BatchView: View {
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

struct BatchView_Previews: PreviewProvider {
    static var previews: some View {
        BatchView(util:Util())
    }
}
