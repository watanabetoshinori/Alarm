//
//  ToggleActionRow.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ToggleActionRow: View {
    @Binding
    var isEnabled: Bool

    var imageName: String

    var title: String

    var action: () -> Void

    @State
    private var isHovering = false

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 16, height: 16)
                .padding(.horizontal, 6)
                .foregroundColor(isEnabled ? Color.accentColor : Color.secondary.opacity(0.8))
            Text(title)
                .padding(.vertical, 4)
                .font(.body)
            Spacer()
        }
        .background(isHovering
                        ? Color.secondary.opacity(0.2)
                        : Color.clear)
        .cornerRadius(4)
        .onHover(perform: { hovering in
            self.isHovering = hovering
        })
        .onTapGesture(perform: action)
    }
}
