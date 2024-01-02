
import SwiftUI
import Foundation

struct SICarousel: View {
    @Binding var sku: String?
    @State private var loadPressed: Bool = false
    @State private var imageUrl = "https://scentglobal.com/catalogue/"
    @State private var exts = ["","-1","-2","-4","-5"]
    @State private var images = [String]()
    @State private var index = 0
    
    
    @GestureState private var zoom = 1.0
    var body: some View {
        HStack{
            Spacer()
            if !loadPressed {
                Button(action: { loadPressed.toggle(); checkImages() }) { Text("Load images").foregroundColor(.black).frame(minWidth: 110, minHeight: 40).background(Color(UIColor.systemGray6)).cornerRadius(15) }.padding(10)
            }
            else{
                if images.count <= 0{
                    AsyncImage(url: URL(string: "https://scentglobal.com/catalogue/noimage.png"),
                               content: { image in image.resizable().aspectRatio(contentMode: .fit).frame(minWidth: 50, idealWidth: 150, maxWidth: 200, minHeight: 50, idealHeight: 150, maxHeight: 200) },
                               placeholder: { ProgressView().contentShape(Rectangle()).aspectRatio(contentMode: .fit).frame(minWidth: 50, maxWidth: 100, minHeight: 50, maxHeight: 100).background(Color(UIColor.systemGray4)) })
                    .aspectRatio(1 / 1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                else{
                    PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                        ForEach(self.images, id: \.self) { imageName in
                            AsyncImage(url: URL(string: "https://scentglobal.com/catalogue/\(imageName).jpg"),
                                       content: { image in image.resizable().aspectRatio(contentMode: .fit).frame(minWidth: 50, idealWidth: 150, maxWidth: 200, minHeight: 50, idealHeight: 150, maxHeight: 200) },
                                       placeholder: { ProgressView().contentShape(Rectangle()).aspectRatio(contentMode: .fit).frame(minWidth: 50, maxWidth: 100, minHeight: 50, maxHeight: 100).background(Color(UIColor.systemGray4)) })
                            .scaleEffect(zoom)
                            .gesture(
                                MagnificationGesture()
                                    .updating($zoom){value, gestureState, transaction in
                                        gestureState = value
                                    }
                            )
                        }
                    }
                    .aspectRatio(1 / 1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                }
            }
            Spacer()
        }
        
    }
    
    
    func checkImages() {
        if images.count > 0 || sku!.isEmpty { return }
        
        for ext in exts {
            let url = URL(string: "https://scentglobal.com/catalogue/\(sku! + ext).jpg")!
            var shouldBreak = false
            url.isReachable { success in
                if success {
                    images.append(sku! + ext)
                    images.sort()
                } else {
                    if ext == "" {
                        shouldBreak = true
                        images.sort()
                    }
                    images.sort()
                }
            }
            if shouldBreak {
                images.sort()
                break
            }
        }
        
        images.sort()
    }
}

//struct SGCarousel_Previews: PreviewProvider {
//    static var previews: some View {
//        SGCarousel()
//    }
//}
