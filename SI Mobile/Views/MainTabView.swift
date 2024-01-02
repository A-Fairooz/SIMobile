
import SwiftUI

struct MainTabView: View {
    
    @StateObject var util: Util
    @StateObject var auth: UserStateViewModel
  
    
    init(util: Util, auth: UserStateViewModel) {
        let t = UITabBar.appearance()
        //TODO
        t.backgroundColor = UIColor.sigreen
        t.barTintColor = UIColor.sigreen
        self._util = StateObject(wrappedValue: util)
        self._auth = StateObject(wrappedValue: auth)
    }
    
    var body: some View {
        
        TabView(selection:$util.viewIndex){
           
//            RRPView(util: util).tabItem{Label("RRP",systemImage:"sterlingsign.circle.fill")}.tag(0).accentColor(.siorange)
//            BatchView(util: util).tabItem{Label("Batch",systemImage:"chart.bar.doc.horizontal.fill")}.tag(1).accentColor(.siorange)
            ProductTabView(util:util).tabItem{Label("Products", systemImage: "magnifyingglass")}.tag(2).accentColor(.siorange)
            if !util.cMode{BERTTabView(util:util).tabItem{Label("BERT", systemImage: "dollarsign.circle.fill")}.tag(3).accentColor(.siorange)}
            //AccountTabView(util: util, auth:auth).tabItem{Label("Settings", systemImage: "person.fill")}.tag(4).accentColor(.siorange)
            SettingsTabView(util:util,auth:auth).tabItem{Label("Settings", systemImage: "gearshape.fill")}.tag(5).accentColor(.siorange)
            
        }
        .accentColor(.white)
       
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(util: Util(), auth: UserStateViewModel())
    }
}
