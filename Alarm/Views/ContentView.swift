//
//  ContentView.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject
    var contentSizeController: ContentSizeController

    @StateObject
    var alarmController: AlarmController

    @State
    var isAddAlarm = false

    var body: some View {
        Group {
            if !self.isAddAlarm {
                AlarmListView(alarmController: alarmController,
                              isAddAlarm: self.$isAddAlarm)
            } else {
                NewAlarmView(alarmController: alarmController,
                             isAddAlarm: self.$isAddAlarm)
            }
        }
        .background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: ContentSizePreferenceKey.self,
                                value: [geometry.size])
            }
        )
        .onPreferenceChange(ContentSizePreferenceKey.self, perform: contentSizeDidChanged)
        .onReceive(NotificationCenter.default.publisher(for: .menudDidCloseNotification), perform: menuDidClosed)
    }

    // MARK: - Events

    func contentSizeDidChanged(size: [CGSize]) {
        contentSizeController.contentSize = size.first ?? .zero
    }

    func menuDidClosed(notification: Notification) {
        isAddAlarm = false
    }
}
