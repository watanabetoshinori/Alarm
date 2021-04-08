//
//  Alarm.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import Foundation
import SwiftUI

enum AlarmLabel: Int, CaseIterable {
    case alarm = 0
    case meetings
    case task

    var string: String {
        switch self {
        case .alarm: return "Alarm"
        case .meetings: return "Meetings"
        case .task: return "Task"
        }
    }
}

class Alarm: Codable, Identifiable, ObservableObject {
    var id = UUID().uuidString

    var time = Date()

    var label = ""

    @Published
    var enabled = false {
        didSet {
            if enabled {
                NotificationHelper.set(for: self)
            } else {
                NotificationHelper.remove(for: self)
            }
        }
    }

    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm"
        return dateFormatter.string(from: time)
    }

    // MARK: - Initializing class

    internal init(id: String = UUID().uuidString, time: Date = Date(), label: String = "", enabled: Bool = false) {
        self.id = id
        self.time = time
        self.label = label
        self.enabled = enabled
    }

    // MARK: - Codable

    enum CodingKeys: CodingKey {
        case id
        case time
        case label
        case enabled
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        time = try container.decode(Date.self, forKey: .time)
        label = try container.decode(String.self, forKey: .label)
        enabled = try container.decode(Bool.self, forKey: .enabled)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(time, forKey: .time)
        try container.encode(label, forKey: .label)
        try container.encode(enabled, forKey: .enabled)
    }
}
