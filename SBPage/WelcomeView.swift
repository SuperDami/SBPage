// Created by zhejun.chen on 2025/02/23

import SwiftUI

struct WelcomeView: View {
    private struct Constants {
        static let backgroundGradientColors = [
            Color.init(hex: "#D5D2FF"),
            Color.init(hex: "#FFFFFF")
        ]
        static let levelupGradientColors = [
            Color.init(hex: "#6FD4FF"),
            Color.init(hex: "#0075FF")
        ]
        static let mainButtonColor = Color.init(hex: "#3BA7FF")
    }

    @ObservedObject private var viewModel: WelcomeViewModel = .init()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: Constants.backgroundGradientColors),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                HStack {
                    // I Prefer to have fix size and padding for this button
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.black, .white)
                            .foregroundColor(.white)
                    }
                    .shadow(color: .black.opacity(0.15), radius: 10, y: 2)
                    .padding(.trailing, 20)
                    .padding(.top, 5)
                }
                Spacer()
            }

            GeometryReader { geometry in
                let contentHeight = geometry.size.height - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom
                let scale = contentHeight / 800.0
                let chartAreaHeight = contentHeight * 0.5
                let chartAreaWidth = chartAreaHeight * 0.83

                let mainTitleSize = 36 * scale
                let subTitleFirstSize = 20 * scale
                let subTitleSecondSize = 30 * scale
                let buttonTitleSize = 16 * scale

                VStack(spacing: 0) {
                    Spacer()
                    Text("Hello\nSpeakBUDDY")
                        .font(.system(size: mainTitleSize, weight: .bold))
                        .lineSpacing(8 * scale)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 85 * scale)

                    BarChartView(
                        activityBars: viewModel.activityBars,
                        isAnimate: viewModel.animateBar
                    )
                    .frame(width: chartAreaWidth, height: chartAreaHeight)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40 * scale)

                    VStack(spacing: 8 * scale) {
                        Text("スピークバディで")
                            .fontWeight(.bold)
                            .font(.system(size: subTitleFirstSize, weight: .semibold))

                        Text("レベルアップ")
                            .font(.system(size: subTitleSecondSize, weight: .heavy))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: Constants.levelupGradientColors,
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                    .padding(.bottom, 25 * scale)

                    Button(action: {}) {
                        Text("プランに登録する")
                            .font(.system(size: buttonTitleSize, weight: .semibold))
                            .padding(.vertical, 16 * scale)
                            .frame(maxWidth: chartAreaWidth * 1.2)
                    }
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    .tint(Constants.mainButtonColor)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(.white)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 10, y: 2)
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

#Preview {
    WelcomeView()
}
