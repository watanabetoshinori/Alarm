//
//  NewAlarmView.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct NewAlarmView: View {
    @ObservedObject
    var alarmController: AlarmController

    @Binding
    var isAddAlarm: Bool

    @State
    var date = Date().addingTimeInterval(300) // 5 minutes

    @State
    var selectedLabel = 0

    // MARK: - Views

    var headerSection: some View {
        Section {
            HStack {
                Text("New Alarm")
                    .font(.headline)
                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 6)

            Divider()
        }
    }

    var timeSection: some View {
        Section {
            HStack {
                Text("Time")

                Spacer()

                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(StepperFieldDatePickerStyle())
                .font(.body)
                .labelsHidden()
                .fixedSize()
            }
            .padding(8)
        }
    }

    var labelSection: some View {
        Section {
            HStack {
                VStack {
                    Text("Label")
                    Spacer()
                }

                Spacer()

                Picker(selection: $selectedLabel, label: Text("")) {
                    ForEach(AlarmLabel.allCases, id: \.self) { label in
                        Text(label.string).tag(label.rawValue)
                    }
                }
                .labelsHidden()
                .pickerStyle(InlinePickerStyle())
                .fixedSize()
            }
            .padding(8)

            Divider()
        }
    }

    var actionSection: some View {
        Section {
            ReactiveButton(title: "Save",
                              titleColor: Color.white,
                              nonactiveColor: Color.accentColor,
                              activeColor: Color.accentColor.opacity(0.5),
                              action: save)

            ReactiveButton(title: "Cancel",
                           titleColor: Color.primary.opacity(0.8),
                           nonactiveColor: Color.secondary.opacity(0.5),
                           activeColor: Color.secondary.opacity(0.2),
                           action: cancel)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            headerSection
                .padding(.horizontal, 14)

            timeSection
                .padding(.top, 4)
                .padding(.horizontal, 14)

            labelSection
                .padding(.vertical, 4)
                .padding(.horizontal, 14)

            actionSection
                .padding(.top, 4)
                .padding(.bottom, 4)
                .padding(.horizontal, 14)
        }
    }

    // MARK: - Events

    func save() {
        let alarmLabel = AlarmLabel(rawValue: selectedLabel) ?? .alarm
        let alarm = Alarm(time: date,
                          label: alarmLabel.string,
                          enabled: true)

        alarmController.add(alarm)

        isAddAlarm = false
    }

    func cancel() {
        isAddAlarm = false
    }
}

struct NewAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        let alarmController = AlarmController()
        NewAlarmView(alarmController: alarmController, isAddAlarm: .constant(true))
            .frame(width: 240, height: 280)
    }
}
