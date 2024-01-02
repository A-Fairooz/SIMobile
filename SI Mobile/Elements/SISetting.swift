
import SwiftUI

struct SISetting: View {
    let text: String
    let view: AnyView
    
    init(_ text: String, _ view: AnyView) {
        self.text = text
        self.view = view
    }
    
    var body: some View {
        HStack{
            Text(text)
            Spacer(minLength: 30)
            view
        }
    }
}
//
//struct SGSetting_Previews: PreviewProvider {
//    static var previews: some View {
//        SGSetting()
//    }
//}
