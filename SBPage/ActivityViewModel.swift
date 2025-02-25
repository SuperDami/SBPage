// Created by zhejun.chen on 2025/02/24

import Foundation

struct ActivityBar: Identifiable, Equatable {
    var id: String { title }
    let title: String
    let volume: Double
}

@MainActor
class ActivityViewModel: ObservableObject {
    private struct Constants {
        static let secondToNano: Double = 1_000_000_000
    }
    @Published private(set) var activityBars: [ActivityBar] = []
    @Published private(set) var animateBar = false

    private func loadData() {
        activityBars = [
            .init(title: "現在", volume: 0.22),
            .init(title: "3ヶ月", volume: 0.33),
            .init(title: "1年", volume: 0.73),
            .init(title: "2年", volume: 1.0)
        ]
    }

    func onAppear() {
        animateBar = false
        loadData()
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(Constants.secondToNano * 0.1))
            animateBar = true
        }
    }

    func replayAnimation() {
        activityBars = []
        onAppear()
    }
}
