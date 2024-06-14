//
//  MarshmelloView.swift
//  Marshmello
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

struct MarshmelloView: View {
    @Binding var address: String
    
    @State private var isButtonPressed = false
    @State var isHover = false
    
    var body: some View {
        ZStack {
            Color.marshmellow.ignoresSafeArea()
            
            ZStack(alignment: .center) {
                VStack(spacing: 0) {
                    HStack {
                        Image(.icnPin)
                        
                        Text("\(address)")
                            .suit(.regular, 16)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.pinkText)
                    }
                    .padding(.top, 40)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("감사")
                            .suit(.heavy, 32)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 6)
                            .foregroundStyle(.marshmellow)
                            .background(RoundedRectangle(cornerRadius: 100).foregroundStyle(isHover ? .clickedButton : .pinkButton))
                    })
                    .onHover { hover in
                        isHover = hover
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    LottieView(filename: "fire")
                        .frame(width: 250, height: 250)
                    
                    Image(.firewood)
                        .padding(.bottom, 40)
                }
                
                Image(.marshmello1)
                    .padding(.bottom, 10)
            }
            .navigationBarBackButtonHidden()
        }
    }
}
