//
//  LottieView.swift
//  Marshmello
//
//  Created by KimYuBin on 6/14/24.
//

import Lottie
import SwiftUI
import UIKit

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    var filename: String
    
    class Coordinator: NSObject {
        var animationView: LottieAnimationView?
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        context.coordinator.animationView = animationView
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        if let animationView = context.coordinator.animationView {
            animationView.animation = LottieAnimation.named(filename)
            animationView.play()
        }
    }
}
