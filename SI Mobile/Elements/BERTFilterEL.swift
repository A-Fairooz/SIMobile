
import SwiftUI

struct BERTFilterEL: View {
    let text: String
    let view: AnyView
    
    init(_ text: String, _ view: AnyView) {
        self.text = text
        self.view = view
    }
    
    var body: some View {
        HStack{
            Text(text)
            Spacer(minLength: 50)
            view
        }
    }
}


struct BERTFilterTog: View {
    let text: String
    @Binding var isOn: Bool
    
    init(_ text: String, _ isOn: Binding<Bool>) {
        self.text = text
        self._isOn = isOn
    }
    
    var body: some View {
        HStack{
            Text(text)
            Spacer(minLength: 50)
            Toggle("", isOn:$isOn)
        }
    }
}
