// Created by zhejun.chen on 2025/02/24
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

extension View {
    func specificCornerRadius(_ radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(
            .rect(
                topLeadingRadius: corners.contains(.topLeft) || corners == .allCorners ? radius : 0,
                bottomLeadingRadius: corners.contains(.bottomLeft) || corners == .allCorners ? radius : 0,
                bottomTrailingRadius: corners.contains(.bottomRight) || corners == .allCorners ? radius : 0,
                topTrailingRadius: corners.contains(.topRight) || corners == .allCorners ? radius : 0
            )
        )
    }
}
