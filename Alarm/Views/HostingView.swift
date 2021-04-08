//
//  HostingView.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

class HostingView<Content: View>: NSHostingView<Content> {
    override func viewDidMoveToWindow() {
        window?.becomeKey()
    }
}
