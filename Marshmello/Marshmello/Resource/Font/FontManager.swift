//
//  FontManager.swift
//  Marshmello
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

struct SuitModifier: ViewModifier {
    
    /// SUIT 폰트 이름 열거형
    enum FontWeight: String {
        case thin = "SUIT-Thin"
        case extraLight = "SUIT-ExtraLight"
        case light = "SUIT-Light"
        case regular = "SUIT-Regular"
        case medium = "SUIT-Medium"
        case semiBold = "SUIT-SemiBold"
        case bold = "SUIT-Bold"
        case extraBold = "SUIT-ExtraBold"
        case black = "SUIT-Black"
    }
    
    var weight: FontWeight
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(weight.rawValue, size: size))
    }
}

extension View {
    
    /// SUIT 커스텀 폰트를 적용 후 반환
    func suit(_ weight: SuitModifier.FontWeight, _ size: CGFloat) -> some View {
        modifier(SuitModifier(weight: weight, size: size))
    }
}

