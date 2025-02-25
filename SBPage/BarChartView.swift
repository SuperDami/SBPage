// Created by zhejun.chen on 2025/02/24
import SwiftUI

struct BarChartView: View {
    let activityBars: [ActivityBar]
    let isAnimate: Bool

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let fullBarHeight = geometry.size.height - 90
            let spacing = totalWidth * 0.1
            let barWidth = activityBars.count > 0
            ? (totalWidth - spacing * CGFloat(activityBars.count + 1)) / CGFloat(activityBars.count)
            : 0

            ZStack(alignment: .topLeading) {
                HStack(alignment: .top, spacing: 50) {
                    Image("protty")
                        .resizable()
                        .frame(width: 188, height: 160)
                }

                HStack(alignment: .bottom, spacing: spacing) {
                    ForEach(activityBars.indices, id: \.self) { i in
                        VStack {
                            Spacer()
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
                                .specificCornerRadius(2, corners: [.topLeft, .topRight])

                            Text(activityBars[i].title)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.top, 60)
                .padding(.leading, spacing)
            }
        }
    }
}

#Preview {
    VStack {
        BarChartView(
            activityBars: [
                .init(title: "first", volume: 0.2),
                .init(title: "second", volume: 1.0),
                .init(title: "third", volume: 0.8),
                .init(title: "fourth", volume: 1.0)
            ],
            isAnimate: true
        )
        .frame(width: 300, height: 300)
    }
}
