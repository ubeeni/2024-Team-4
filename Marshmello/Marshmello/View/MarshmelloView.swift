//
//  MarshmelloView.swift
//  Marshmello
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer?

struct MarshmelloView: View {
    @Binding var address: String
    @State var isThanks: Bool = false
    @State private var isButtonPressed = false
    @State private var showOnboarding = false
    @StateObject private var locationManager = LocationManager()
    @State private var startDate : Date = Date()
    @State private var currentDate : Date = {
        let stepData = UserDefaults.standard.integer(forKey: "step")
        return Calendar.current.date(byAdding: .second, value: stepData, to: Date())!
    }()
    @State private var showChangeView: Bool = false
    
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
                        Spacer()
                        Spacer()
                        
                        Button(action: {
                            showChangeView.toggle()
                        }, label: {
                            switch CalculateDateSecondDifference(){
                            case 0...10:
                                Image(.icnPinGray)
                            case 11...20:
                                Image(.icnPinYellow)
                            default:
                                Image(.icnPinWhite)
                            }
                            
                            Text("\(address)")
                                .suit(.regular, 16)
                                .multilineTextAlignment(.center)
                                .foregroundStyle({
                                    switch CalculateDateSecondDifference(){
                                    case 0...10:
                                        return Color.firstSecondText
                                    case 11...20:
                                        return Color.secondSecondText
                                    default:
                                        return Color.white
                                    }
                                }())
                        })
                        .sheet(isPresented: $showChangeView, content: {
                            ChangeView(address: $address)
                        })
                        
                        
                        Spacer()
                        
                        Button {
                            showOnboarding = true
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .foregroundStyle({
                                    switch CalculateDateSecondDifference(){
                                    case 0...10:
                                        return Color.firstThanks
                                    case 11...20:
                                        return Color.secondThanks
                                    default:
                                        return Color.white
                                    }
                                }())
                                .frame(width: 25, height: 25)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    Button(action: {
                        isThanks = true
                        HapticManager.shared.notification(type: .success)
                        playSound()
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
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    switch CalculateDateSecondDifference(){
                    case 0...10:
                        ZStack {
                            LottieView(filename: isThanks ? "small fire_g" : "small fire")
                                .frame(width: 200, height: 200)
                            
                            if isThanks {
                                LottieView(filename: "confetti")
                                    .frame(width: 200, height: 200)
                            }
                        }
                    case 11...20:
                        ZStack {
                            LottieView(filename: isThanks ? "middle fire_g" : "middle fire")
                                .frame(width: 200, height: 200)
                            
                            if isThanks {
                                LottieView(filename: "confetti")
                                    .frame(width: 200, height: 200)
                            }
                        }
                    default:
                        ZStack {
                            LottieView(filename: isThanks ? "big fire_g" : "big fire")
                                .frame(width: 200, height: 200)
                            
                            if isThanks {
                                LottieView(filename: "confetti")
                                    .frame(width: 300, height: 200)
                            }
                        }
                    }
                    
                    Image(.firewood)
                        .padding(.bottom, 40)
                }
                
                switch CalculateDateSecondDifference(){
                case 0...10:
                    Image(.marshmello2D1)
                        .padding(.bottom, 30)
                case 11...20:
                    Image(.marshmello2D2)
                        .padding(.bottom, 30)
                default:
                    Image(.marshmello2D3)
                        .padding(.bottom, 30)
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
        .sheet(isPresented: $showOnboarding) {
            GuideView()
        }
    }
    
    func CalculateDateSecondDifference() -> Int{
        if let secondDifference = Calendar.current.dateComponents([.second], from: self.startDate, to: self.currentDate).second{
            UserDefaults.standard.set(secondDifference, forKey: "step")
            return secondDifference
        }
        else{
            return 0
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "gamsa", withExtension: "m4a") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}
