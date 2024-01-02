
import SwiftUI

struct SIButton: View{
    var action: () -> Void
    var text: String = ""
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    private let pad: CGFloat = 10
    var body: some View {
        if(width != nil && height != nil){
            Button(action: action){Text(text).frame(width:width, height: height).padding(pad)}
                .foregroundColor(.white)
                .background(Color.siorange)
                .cornerRadius(10)
             
        }
        else if(width == nil && height != nil){
            Button(action: action){Text(text).frame(height: height).padding(pad)}
                .foregroundColor(.white)
                .background(Color.siorange)
                .cornerRadius(10)
                
                
        }
        else if (width != nil && height  == nil){
            Button(action: action){Text(text).frame(width:width).padding(pad)}
                .foregroundColor(.white)
                .background(Color.siorange)
                .cornerRadius(10)
             
                
        }
        else{
            Button(action: action){Text(text).padding(pad)}
                .foregroundColor(.white)
                .background(Color.siorange)
                .cornerRadius(10)
                
        }
        
        
    }
}
