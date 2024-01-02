
import SwiftUI

struct BrandListView: View {
    @StateObject var util: Util
    @State private var brands = [String]()
    @State private var searchText = ""
    var body: some View {
       
            VStack{
                List{
                    ForEach(searchResults, id:\.self){brand in
                        NavigationLink(brand){
                            ProductListView(util:util, brand:brand)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .onAppear{
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white

                util.loading = true
                API().getBrands(){data in
                    brands = data
                    util.loading = false
                    if brands.isEmpty{
                        util.alertText = "No Brands Found, this is usually caused by a VPN issue, please contact a member of IT"
                        util.showAlert = true
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Brands")
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(Color.sigreendark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return brands
        } else {
            return brands.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct BrandListView_Previews: PreviewProvider {
    static var previews: some View {
        BrandListView(util:Util())
    }
}
