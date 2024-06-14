//
//  HapticManager.swift
//  Marshmello
//
//  Created by KimYuBin on 6/15/24.
//

import UIKit

final class HapticManager {
    static let shared = HapticManager()
    private init() {}

    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}
