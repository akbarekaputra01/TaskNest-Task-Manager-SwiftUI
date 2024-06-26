//
//  Image+Ext.swift
//  TaskNest-Task-Manager-SwiftUI
//
//  Created by Akbar Eka Putra on 10/06/24.
//

import SwiftUI

extension Image {
    func outlineButtonExt() -> some View {
        self
            .padding(8)
            .background(Color.clear)
            .foregroundColor(.isDark)
            .clipShape(Circle())
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.isDark.opacity(0.5), lineWidth: 0.5)
            )
    }
}

#Preview {
    Image(systemName: "bell")
        .outlineButtonExt()
}
