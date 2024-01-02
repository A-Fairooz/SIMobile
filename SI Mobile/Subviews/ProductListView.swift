
import SwiftUI

struct ProductListView: View {
    @StateObject var util: Util
    let brand: String
    @State private var products = [ZPRODMIN]()
    @State private var searchText = ""
    var body: some View {
        
        VStack{
            List{
                ForEach(prodResults, id: \.sku){product in
                    NavigationLink(product.description ?? "N/A", destination:ProductDetailsView(util: util, searchTrigger: true, skuSearch: product.sku!))
                }
            }
        }
        .searchable(text: $searchText)
        .onAppear{
            util.loading = true
            API().getBrandProds(brand: brand, inStockOnly: util.inStockOnly ){data in
                products = data
                util.loading = false
            }
        }
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("\(brand) Products")
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(Color.sigreendark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    var prodResults: [ZPRODMIN] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { $0.description!.lowercased().contains(searchText.lowercased()) }
        }
    }

    
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(util: Util(), brand:"")
    }
}
