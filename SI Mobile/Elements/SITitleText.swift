
import SwiftUI

struct SITitleText: View {
    var title: String?
    var text: String?
    
    init(_ title: String? = nil,_ text: String? = nil) {
        self.title = title
        self.text = text
    }
    
    
    var body: some View {
        HStack{
            Text("\(title ?? ""):").textSelection(.disabled)
            Spacer(minLength:50)
            Text(text ?? "").multilineTextAlignment(.trailing).textSelection(.enabled)
        }
    }
}


