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
    @StateObject private var locationManager = LocationManager()
    @State private var startDate : Date = Date()
    @State private var currentDate : Date = Date()
    
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
                    
                    switch CalculateDateSecondDifference(){
                    case 0...10:
                        LottieView(filename: "fire")
                            .frame(width: 150, height: 150)
                    case 11...20:
                        LottieView(filename: "fire")
                            .frame(width: 200, height: 200)
                    default:
                        LottieView(filename: "fire")
                            .frame(width: 250, height: 250)
                    }
                    
                    Image(.firewood)
                        .padding(.bottom, 40)
                }
                
                Image(.marshmello1)
                    .padding(.bottom, 10)
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
                print(CalculateDateSecondDifference())
                if (locationManager.calculateDistance() < 25){
                    currentDate = Calendar.current.date(byAdding: .second, value: 1, to: currentDate)!
                }else if (locationManager.calculateDistance() > 25 && CalculateDateSecondDifference() > 0){
                    currentDate = Calendar.current.date(byAdding: .second, value: -1, to: currentDate)!
                }
                
            })
        }
    }
    
    func CalculateDateSecondDifference() -> Int{
        if let secondDifference = Calendar.current.dateComponents([.second], from: self.startDate, to: self.currentDate).second{
                return secondDifference
            }
            else{
                return 0
            }
        }
}
