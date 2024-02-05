import Firebase
import SwiftUI

public extension Color {
    //static let sggold = Color("SGGold")
    //static let sggoldpale = Color("SGGoldPale")
    static let siorange = Color("SIOrange")
    static let sigreen = Color("SIGreen")
    static let sigreendark = Color("SIGreenDark")
    static let sigrey = Color("SIGrey")
}

public extension UIColor {
    //static let sggold = UIColor(Color.sggold)
    //static let sggoldpale = UIColor(Color.sggoldpale)
    static let siorange = UIColor(Color.siorange)
    static let sigreen = UIColor(Color.sigreen)
    static let sigreendark = UIColor(Color.sigreendark)
    static let sigrey = UIColor(Color.sigrey)
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().isTranslucent = false
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

    func inExpandingRectangle() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
            self
        }
    }
}


extension Date {
    func convertToTimeZone(initZone: TimeZone, targetZone: TimeZone) -> Date {
        let delta = TimeInterval(targetZone.secondsFromGMT(for: self) - initZone.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
}

extension Date {
    func ukHour() -> Int {
        let localTz = TimeZone.current
        let targetTz = TimeZone(identifier: "Europe/London")!
        let ukTime = Date().convertToTimeZone(initZone: localTz, targetZone: targetTz)
        let hour = Calendar.current.component(.hour, from: ukTime)
        return hour
    }
}


extension URL {
    func isReachable(completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: self)
        request.httpMethod = "HEAD"
        URLSession.shared.dataTask(with: request) { _, response, _ in
            completion((response as? HTTPURLResponse)?.statusCode == 200)
        }.resume()
    }
}




struct AnyKey: CodingKey{
    var stringValue: String
    
    init?(stringValue: String){
        self.stringValue = stringValue
    }
    
    var intValue:Int?{
        return nil
    }
    
    init?(intValue: Int){
        return nil
    }
        
}


struct DecodingStrategy {
    static var lowercase: ([CodingKey])-> CodingKey{
        return {keys -> CodingKey in
            let key = keys.first!
            let modifiedKey = key.stringValue.prefix(1).lowercased() + key.stringValue.dropFirst()
            return AnyKey(stringValue: modifiedKey)!
        }
    }
}
