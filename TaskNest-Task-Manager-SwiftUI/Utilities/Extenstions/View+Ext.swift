//
//  NotificationBadge+Ext.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

struct NotifBadgeModifier: ViewModifier {
    var count: Int

    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content
            if self.count > 0 {
                Text("\(self.count)")
                    .foregroundColor(.isDark)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(4)
                    .background(.accent)
                    .clipShape(Circle())
                    .offset(x: 6, y: -6)
            }
        }
    }
}

extension View {
    func notifBadgeExt(count: Int) -> some View {
        self.modifier(NotifBadgeModifier(count: count))
    }

    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }

        return root
    }
}

#Preview {
    Image(systemName: "bell")
        .notifBadgeExt(count: 8)
}
