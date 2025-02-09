//
//  AudioStreamingLayoutApp.swift
//  AudioStreamingLayout
//
//  Created by Sumit on 04/02/25.
//

import SwiftUI

@main
struct AudioStreamingLayoutApp: App {
    var body: some Scene {
        WindowGroup {
            AudioWaveAnimtion(percent: 40).preferredColorScheme(.dark)
        }
    }
}
