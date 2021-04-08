//
//  AlarmController.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

class AlarmController: ObservableObject {
    @AppStorage("alarms")
    var alarmData: Data?

    @Published
    var alarms = [Alarm]()

    init() {
        if let data = alarmData,
           let alarms = try? JSONDecoder().decode([Alarm].self, from: data) {
            self.alarms = alarms
        }
    }

    // MARK: - Managing Alarams

    func add(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.time > alarm.time }) {
            alarms.insert(alarm, at: index)
        } else {
            alarms.append(alarm)
        }

        save()
    }

    func delete(_ alarm: Alarm) {
        NotificationHelper.remove(for: alarm)

        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms.remove(at: index)
        }

        save()
    }

    func save() {
        if let data = try? JSONEncoder().encode(alarms) {
            alarmData = data
        }
    }
}
