
import SwiftUI

struct BERTHead: View {
    @Binding var request: BERTRequestItem
    private let spacing: CGFloat = 15
    var body: some View {
        VStack(alignment:.center, spacing:20){
            Text("Parameters").font(.headline)
            HStack(spacing:spacing){
                BERTParam(text: "EUR", placeholder: "Required", value: $request.EURRate, keyboard: .decimalPad)
                BERTParam(text: "USD", placeholder: "Required", value: $request.USDRate,  keyboard: .decimalPad)
                BERTParam(text: "Land%", placeholder: "Required", value: $request.LandedCostPercent,  keyboard: .numberPad)
            }
            HStack(spacing:spacing){
                BERTParam(text: "UPC", placeholder: "Optional", value: $request.Barcode)
                BERTParam(text: "Term", placeholder: "Optional", value: $request.SearchTerm)
                BERTParam(text: "Supplier", placeholder: "Optional", value: $request.Supplier)
            }
            HStack(spacing:spacing){
                BERTDate(text: "Start", key: "sStartDate", date: $request.StartDate)
                BERTDate(text: "End", key: "sEndDate", date: $request.EndDate)
            }
        }
    }
    
}

struct BERTHead_Previews: PreviewProvider {
    static var previews: some View {
        BERTHead(request: .constant(BERTRequestItem()))
    }
}
