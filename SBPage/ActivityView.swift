// Created by zhejun.chen on 2025/02/23

import SwiftUI

struct ActivityView: View {
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

    @ObservedObject private var viewModel: ActivityViewModel = .init()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: Constants.backgroundGradientColors),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Close button could replay animation
            VStack {
                HStack {
                    Spacer()
                    Button(action: viewModel.replayAnimation) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.black, .white)
                            .foregroundColor(.white)
                    }
                    .shadow(color: .black.opacity(0.15), radius: 10, y: 2)
                    .padding(.trailing, 20)
                }
                Spacer()
            }

            VStack(spacing: 25) {
                Text("Hello\nSpeakBUDDY")
                    .font(.system(size: 36, weight: .bold))
                    .lineSpacing(8)
                    .padding(.top, 40)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)

                BarChartView(
                    activityBars: viewModel.activityBars,
                    isAnimate: viewModel.animateBar
                )
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 40)
                .padding(.bottom, 5)

                VStack {
                    Text("スピークバディで")
                        .fontWeight(.bold)
                        .font(.system(size: 20, weight: .semibold))

                    Text("レベルアップ")
                        .font(.system(size: 30, weight: .bold))
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

                Spacer()

                Button(action: {}) {
                    Text("プランに登録する")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .tint(Constants.mainButtonColor)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(.white)
                )
                .shadow(color: .black.opacity(0.2), radius: 10, y: 2)
                .padding(.horizontal, 40)
                .padding(.bottom, 54)
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

#Preview {
    ActivityView()
}
