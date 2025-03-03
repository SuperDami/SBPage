// Created by zhejun.chen on 2025/02/24
import SwiftUI

struct BarChartView: View {
    let activityBars: [ActivityBar]
    let isAnimate: Bool

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let fullBarHeight = geometry.size.height * 0.925
            let scale = geometry.size.height / 325
            let barWidth = totalWidth * 0.17
            let spacing = CGFloat(totalWidth - barWidth * CGFloat(activityBars.count)) / CGFloat(activityBars.count - 1)
            let robotWidthScale = 0.7
            let robotAspect = 1.175
            let robotWidth = totalWidth * robotWidthScale
            let robotHeight = robotWidth / robotAspect
            let titleFontSize: CGFloat = geometry.size.height * 0.03
            ZStack(alignment: .topLeading) {
                HStack(alignment: .top, spacing: 50) {
                    Image("protty")
                        .resizable()
                        .frame(width: robotWidth, height: robotHeight)
                        .offset(x: -robotWidth * 0.2, y: -robotHeight * 0.28)
                }

                HStack(alignment: .bottom, spacing: spacing) {
                    ForEach(activityBars.indices, id: \.self) { i in
                        VStack {
                            Spacer()
                                .frame(maxHeight: .infinity)
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.init(hex: "#58C0FF"),
                                            Color.init(hex: "#1F8FFF")
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width: barWidth, height: isAnimate ? fullBarHeight * activityBars[i].volume : 0)
                                .animation(
                                    isAnimate ? .easeInOut(duration: 0.8).delay(Double(i) * 0.1) : nil,
                                    value: isAnimate
                                )
                                .specificCornerRadius(2 * scale, corners: [.topLeft, .topRight])

                            Text(activityBars[i].title)
                                .font(.system(size: titleFontSize, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    VStack {
        BarChartView(
            activityBars: [
                .init(title: "現在", volume: 0.22),
                .init(title: "3ヶ月", volume: 0.33),
                .init(title: "1年", volume: 0.8),
                .init(title: "2年", volume: 1.0)
            ],
            isAnimate: true
        )
        .frame(width: 270, height: 325)
    }
}
