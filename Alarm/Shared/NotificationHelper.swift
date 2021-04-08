//
//  NotificationHelper.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI
import UserNotifications

struct NotificationHelper {
    static func checkStatus(completionHandler: @escaping (UNAuthorizationStatus) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            completionHandler(settings.authorizationStatus)
        }
    }

    static func requestAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print(error)
                return
            }
        }
    }

    static func printPendingNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.getPendingNotificationRequests { requests in
            print(requests)
        }
    }

    static func set(for alarm: Alarm) {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = alarm.label
        content.sound = UNNotificationSound.default

        let components = Calendar.current.dateComponents([.hour, .minute], from: alarm.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print(error)
                return
            }
        }
    }

    static func remove(for alarm: Alarm) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [alarm.id])
    }
}
