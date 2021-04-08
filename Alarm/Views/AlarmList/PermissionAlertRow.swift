//
//  PermissionAlertRow.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct PermissionAlertRow: View {
    var title: String

    var message: String

    @State
    private var isHovering = false

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .foregroundColor(Color.orange)
                .frame(width: 16, height: 16)

            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .font(.title3)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                HStack {
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                        .padding(.leading, 2)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }
            .padding(.leading, 8)

            Spacer()
        }
        .padding(.leading, 4)
        .background(isHovering
                        ? Color.secondary.opacity(0.2)
                        : Color.clear)
        .cornerRadius(4)
        .onHover(perform: { hovering in
            self.isHovering = hovering
        })
        .onTapGesture {
            // Open notification settings
            NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Notifications.prefPane"))
        }
    }
}
