//
//  ReactiveButton.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ReactiveButton: View {
    var title: String

    var titleColor = Color.black

    var nonactiveColor = Color.clear

    var activeColor = Color.secondary

    var action: () -> Void

    @State
    private var isHovering = false

    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.body)
                .foregroundColor(titleColor)
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
            Spacer()
        }
        .background(isHovering
                        ? activeColor
                        : nonactiveColor)
        .cornerRadius(4)
        .onHover(perform: { hovering in
            self.isHovering = hovering
        })
        .onTapGesture(perform: action)
    }
}
