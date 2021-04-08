//
//  AlarmListView.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI
import LaunchAtLogin

struct AlarmListView: View {
    @ObservedObject
    var alarmController: AlarmController

    @Binding
    var isAddAlarm: Bool

    @State
    var isEditing = false

    @State
    var permissionNotAllowed = false

    @ObservedObject
    private var launchAtLogin = LaunchAtLogin.observable

    // MARK: - Views

    var headerSection: some View {
        Section {
            HStack {
                Text("Alarm")
                    .font(.headline)

                Spacer()

                if !alarmController.alarms.isEmpty {
                    HeaderButton(title: isEditing ? "Done" : "Edit") {
                        withAnimation {
                            self.isEditing.toggle()
                        }
                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 6)

            Divider()
        }
    }

    var permissionAlertSection: some View {
        Section {
            PermissionAlertRow(title: "Notifications disabled",
                               message: "Open the system settings and allow notifications for this app.")
            Divider()
        }
    }

    var listSection: some View {
        Section {
            if !alarmController.alarms.isEmpty {
                ForEach(alarmController.alarms, id: \.id) { alarm in
                    AlarmRow(alarm: alarm,
                             isEditing: $isEditing,
                             deleteAction: alarmController.delete)
                        .padding(.vertical, 4)
                }
            } else {
                HStack {
                    Text("Np Alarm")
                        .font(.body)
                        .foregroundColor(Color.secondary)

                    Spacer()
                }
                .padding(.vertical, 8)
            }

            Divider()
        }
    }

    var actionSection: some View {
        Section {
            ToggleActionRow(isEnabled: .constant(false),
                            imageName: "plus.circle.fill",
                            title: "Add Alarm",
                            action: add)

            ToggleActionRow(isEnabled: $launchAtLogin.isEnabled,
                            imageName: "person.circle.fill",
                            title: "Launch at login") {
                launchAtLogin.isEnabled.toggle()
            }

            ToggleActionRow(isEnabled: .constant(false),
                            imageName: "moon.circle.fill",
                            title: "Quit Alarm",
                            action: quit)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            headerSection
                .padding(.horizontal, 14)

            if permissionNotAllowed {
                permissionAlertSection
                    .padding(.top, 4)
                    .padding(.horizontal, 14)
            } else {
                listSection
                    .padding(.top, 4)
                    .padding(.horizontal, 14)
            }

            actionSection
                .padding(.top, 4)
                .padding(.horizontal, 4)
        }
        .onReceive(NotificationCenter.default.publisher(for: .menuWillOpenNotification), perform: { _ in
            self.checkNotificationStatus()
        })
        .onReceive(NotificationCenter.default.publisher(for: .menudDidCloseNotification), perform: { _ in
            self.isEditing = false
        })
    }

    // MARK: - Events

    func add()  {
        isEditing = false
        isAddAlarm = true
    }

    func delete(_ alarm: Alarm) {
        alarmController.delete(alarm)
    }

    func quit() {
        NSApplication.shared.terminate(self)
    }

    func checkNotificationStatus() {
        NotificationHelper.checkStatus { status in
            switch status {
            case .notDetermined:
                NotificationHelper.requestAuthorization()
            case .denied:
                self.permissionNotAllowed = true
            default:
                self.permissionNotAllowed = false
            }
        }
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        let alarmController = AlarmController()
        AlarmListView(alarmController: alarmController,
                      isAddAlarm: .constant(true))
            .frame(width: 240, height: 180)
    }
}
