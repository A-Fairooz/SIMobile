//
//  SGSlider.swift
//  SGTESTING01
//
//  Created by Abdulla Fairooz on 17/08/2023.
//

import SwiftUI
import Sliders

struct SISlider: View {
    
    @Binding var range: ClosedRange<Float>
    let min: Float
    let max: Float
    var body: some View {
        RangeSlider(range:$range, in:min...max, step:1)
            .rangeSliderStyle(
                HorizontalRangeSliderStyle(
                    track: HorizontalRangeTrack(view:Capsule().foregroundColor(Color.sigreen))
                        .background(Color(UIColor.systemGray6)).frame(height:8),
                    lowerThumb:Circle().foregroundColor(.sigreendark)
                    ,upperThumb:Circle().foregroundColor(.sigreendark)))
    }
}
//
//struct SGSlider_Previews: PreviewProvider {
//    @State static var rng: ClosedRange<CGFloat> = 0...100
//    static var previews: some View {
//        SGSlider(range:$rng, min:0, max:100)
//    }
//}
