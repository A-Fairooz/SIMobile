
import SwiftUI
//import SwiftyGif
import FLAnimatedImage

struct SplashScreen: View {
    @StateObject var auth: UserStateViewModel
    @StateObject var util: Util
    
    @State private var showingLogin = false
    @State private var vis = false
    var body: some View {
        if(!showingLogin){
            VStack{
                Image("S_FINAL_FINAL")
                    .resizable()
                    .frame(width:150, height: 150)
                    .onAppear{
                    withAnimation(Animation.easeOut(duration: 0.6).delay(0)){
                        self.vis = true
                    }
                    withAnimation(Animation.easeOut(duration: 0.6).delay(2.25)){
                        self.vis = false
                    }
                } .opacity(vis ? 1 : 0)
          

                
            }
            
            .onAppear{
                gotoLogin()
            }
        }
        else{
            LoginView(auth:auth, util:util)
        }
        
    }
    func gotoLogin(){
        DispatchQueue.main.asyncAfter(deadline:.now() + 3){
            showingLogin = true
        }
        
    }
}
//
//struct AnimatedGifView: UIViewRepresentable {
//    @State var fileName: String
//
//    func makeUIView(context: Context) -> UIImageView {
//        
//        do{
//            let imageView = UIImageView(gifImage:(try UIImage(gifName: self.fileName)))
//            return imageView
//        }
//        catch{
//            return UIImageView()
//        }
//    }
//
//    func updateUIView(_ uiView: UIImageView, context: Context) {
//        do{
//            uiView.setGifImage(try UIImage(gifName: self.fileName))
//        }
//        catch{
//            print()
//        }
//    }
//}
//
//struct AnimatedUrlGifView: UIViewRepresentable {
//    @Binding var url: URL
//
//    func makeUIView(context: Context) -> UIImageView {
//        let imageView = UIImageView(gifURL: self.url)
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }
//
//    func updateUIView(_ uiView: UIImageView, context: Context) {
//        uiView.setGifFromURL(self.url)
//    }
//}
