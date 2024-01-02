
import SwiftUI

struct BERTDate: View {
    let text: String
    let key: String
    @Binding var date: Date
    var body: some View {
        DatePicker(text, selection: $date, displayedComponents: [.date]).onChange(of: date, perform: { _ in
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let dt = formatter.string(from: date)
            UserDefaults.standard.set(String(describing: dt), forKey: key)
        })
        .datePickerStyle(DefaultDatePickerStyle())
        .environment(\.locale, Locale(identifier: "en_GB"))
        .id(date)
    }
}
