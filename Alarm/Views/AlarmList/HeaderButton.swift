//
//  HeaderButton.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct HeaderButton: View {
    var title: String

    var action: () -> Void

    @State
    private var isHovering = false

    var body: some View {
        Text(title)
            .font(.body)
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
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
