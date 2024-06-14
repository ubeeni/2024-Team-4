//
//  MarshmelloView.swift
//  Marshmello
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

struct MarshmelloView: View {
    @Binding var address: String
    @State var isThanks: Bool = false
    @State private var isButtonPressed = false
    @StateObject private var locationManager = LocationManager()
    @State private var startDate : Date = Date()
    @State private var currentDate : Date = Date()
    
    var body: some View {
        ZStack {
            switch CalculateDateSecondDifference(){
            case 0...10:
                Color.firstStep.ignoresSafeArea()
            case 11...20:
                Color.secondStep.ignoresSafeArea()
            default:
                Color.thirdStep.ignoresSafeArea()
            }
            
            ZStack(alignment: .center) {
                VStack(spacing: 0) {
                    HStack {
                        Image(.icnPin)
                        
                        Text("\(address)")
                            .suit(.regular, 16)
                            .multilineTextAlignment(.center)
                            .foregroundStyle({
                                switch CalculateDateSecondDifference(){
                                case 0...20:
                                    return Color.firstSecondText
                                default:
                                    return Color.white
                                }
                            }())
                    }
                    .padding(.top, 40)
                    
                    Button(action: {
                        isThanks = true
                    }, label: {
                        Text("감사")
                            .suit(.heavy, 32)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 6)
                            .foregroundStyle(.white)
                            .background(RoundedRectangle(cornerRadius: 100).foregroundStyle({
                                switch CalculateDateSecondDifference(){
                                case 0...10:
                                    return Color.firstThanks
                                case 11...20:
                                    return Color.secondThanks
                                default:
                                    return Color.thirdThanks
                                }
                            }()))
                    })
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    switch CalculateDateSecondDifference(){
                    case 0...10:
                        LottieView(filename: isThanks ? "small fire_g" : "small fire")
                            .frame(width: 200, height: 200)
                    case 11...20:
                        LottieView(filename: isThanks ? "middle fire_g" : "middle fire")
                            .frame(width: 200, height: 200)
                    default:
                        LottieView(filename: isThanks ? "big fire_g" : "big fire")
                            .frame(width: 200, height: 200)
                    }
                    
                    Image(.firewood)
                        .padding(.bottom, 40)
                }
                
                switch CalculateDateSecondDifference(){
                case 0...10:
                    Image(.marshmello2D1)
                        .padding(.bottom, 10)
                case 11...20:
                    Image(.marshmello2D2)
                        .padding(.bottom, 10)
                default:
                    Image(.marshmello2D3)
                        .padding(.bottom, 10)
                }
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
                if (locationManager.calculateDistance() < 25){
                    currentDate = Calendar.current.date(byAdding: .second, value: 1, to: currentDate)!
                }else if (locationManager.calculateDistance() > 25 && CalculateDateSecondDifference() > 0){
                    currentDate = Calendar.current.date(byAdding: .second, value: -1, to: currentDate)!
                }
                
            })
        }
        .onChange(of: isThanks) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                isThanks = false
            }
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
