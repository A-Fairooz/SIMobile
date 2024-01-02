
import SwiftUI

struct SITextField: View {
    let title: String
    var text: Binding<String>
    let maxWidth: CGFloat?
    private let pad:CGFloat = 5
    init(_ title: String, _ text: Binding<String>, _ maxWidth: CGFloat? = nil) {
        self.title = title
        self.text = text
        self.maxWidth = maxWidth
    }
    
    var body: some View {
        if maxWidth != nil{
            TextField(title, text:text)
                .padding(pad)
                .textFieldStyle(.roundedBorder)
                //.background(Color(UIColor.systemGray6))
                .frame(width: maxWidth)
                .cornerRadius(5)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                
            
            
        }
        else{
            TextField(title, text:text)
                .padding(pad)
                .textFieldStyle(.roundedBorder)
                //.background(Color(UIColor.systemGray6))
                .cornerRadius(5)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
        }
    }
}
struct SISecureField: View {
    let title: String
    var text: Binding<String>
    let maxWidth: CGFloat?
    private let pad: CGFloat = 5
    init(_ title: String, _ text: Binding<String>, _ maxWidth: CGFloat? = nil) {
        self.title = title
        self.text = text
        self.maxWidth = maxWidth
    }
    
    var body: some View {
        if maxWidth != nil{
            SecureField(title, text:text)
                .padding(pad)
            //.background(Color(UIColor.systemGray6))
                .textFieldStyle(.roundedBorder)
                .frame(width: maxWidth)
                .cornerRadius(5)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            
        }
        else{
            SecureField(title, text:text)
                .padding(pad)
                .textFieldStyle(.roundedBorder)
            //.background(Color(UIColor.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            
        }
    }
}
//
//struct SGTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        SGTextField()
//    }
//}
