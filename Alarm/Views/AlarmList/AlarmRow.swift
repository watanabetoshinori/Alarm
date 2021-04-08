//
//  AlarmRow.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct AlarmRow: View {
    @ObservedObject
    var alarm: Alarm

    @Binding
    var isEditing: Bool

    var deleteAction: (Alarm) -> Void

    var body: some View {
        HStack(spacing: 0) {
            if isEditing {
                Button(action: delete, label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 16, height: 16)
                })
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 8)
            }

            VStack(spacing: 0) {
                HStack {
                    Text(alarm.timeString)
                        .font(.title3)
                        .opacity(alarm.enabled ? 1 : 0.5)
                    Spacer()
                }
                HStack {
                    Text(alarm.label)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                        .opacity(alarm.enabled ? 1 : 0.5)
                        .padding(.leading, 2)
                    Spacer()
                }
            }

            Spacer()

            if !isEditing {
                Toggle(isOn: $alarm.enabled) {}
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
                .padding(.trailing, 2)
                .padding(.leading, 4)
                .padding(.top, 2)
            }
        }
    }

    // MARK: - Events

    func delete() {
        deleteAction(alarm)
    }
}
