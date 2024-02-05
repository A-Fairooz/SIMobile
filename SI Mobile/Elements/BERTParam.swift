
import SwiftUI

struct BERTParam: View {
    let text: String
    let placeholder: String
    @Binding var value: String
    @State var keyboard: UIKeyboardType = .default
    var body: some View {
        VStack{
            Text("\(text):")
            TextField(placeholder, text:$value)
                .padding(5)
                .cornerRadius(5)
                .background(Color(.systemGray6))
                .keyboardType(keyboard)
        }
    }
}
//
//#Preview{
//    BERTParam(text:"Test",placeholder: "Placeholder", value:.constant("Value"))
//}

struct BERTParam_Previews: PreviewProvider {
    static var previews: some View {
       BERTParam(text:"Test",placeholder: "Placeholder", value:.constant("Value"))
    }
}
