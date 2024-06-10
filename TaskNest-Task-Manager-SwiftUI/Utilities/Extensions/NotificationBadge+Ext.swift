//
//  NotificationBadge+Ext.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

extension View {
  func notifBadgeExt(count: Int) -> some View {
    self.modifier(NotifBadgeModifier(count: count))
  }
}

#Preview{
  Image(systemName: "bell")
    .notifBadgeExt(count: 8)
}
