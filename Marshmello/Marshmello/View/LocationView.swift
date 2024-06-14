//
//  LocationView.swift
//  Marshmello
//
//  Created by KimYuBin on 6/15/24.
//

import SwiftUI

struct LocationView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var buttonText = "등록하기"
    @State private var showAddress = false
    @State private var address = ""
    
    var body: some View {
        ZStack {
            Color.button.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text(showAddress ? "몰입하는 장소가 지금 이 곳이 맞나요?" : "현재 위치한 곳을\n몰입하는 장소로 등록 하시겠어요?")
                    .suit(.semiBold, 18)
                    .multilineTextAlignment(.center)
                    .frame(width: 267, height: 52)
                    .foregroundStyle(.rectangle)
                    .padding(.top, 54)
                
                if showAddress {
                    Text(address)
                        .suit(.heavy, 24)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.rectangle)
                        .padding(.top, 135)
                } else {
                    Text(" ")
                        .suit(.heavy, 24)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.rectangle)
                        .padding(.top, 135)
                }
                
                Image(.icnMap)
                    .padding(.top, 24)
                
                Spacer()
                
                if !showAddress {
                    Button(action: {
                        locationManager.startUpdatingLocation()
                    }, label: {
                        Text("여기가 아니에요")
                            .suit(.semiBold, 18)
                            .foregroundStyle(.rectangle)
                            .hidden()
                    })
                } else {
                    Button(action: {
                        locationManager.startUpdatingLocation()
                        HapticManager.shared.notification(type: .success)
                    }, label: {
                        Text("여기가 아니에요")
                            .suit(.semiBold, 18)
                            .foregroundStyle(.rectangle)
                    })
                }
                
                if !showAddress {
                    Button(action: {
                        buttonText = "맞아요"
                        showAddress = true
                        address = locationManager.address ?? ""
                        HapticManager.shared.notification(type: .success)
                    }, label: {
                        Text(buttonText)
                            .suit(.bold, 20)
                            .padding(.horizontal, 137)
                            .padding(.vertical, 20)
                            .foregroundStyle(.button)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.rectangle))
                        }
                    )
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                } else {
                    NavigationLink(destination: MarshmelloView(address: $address)) {
                        Text(buttonText)
                            .suit(.bold, 20)
                            .padding(.horizontal, 146)
                            .padding(.vertical, 20)
                            .foregroundStyle(.button)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.rectangle))
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
                
            }
            //.padding(.horizontal, 20)
            .onAppear {
                locationManager.startUpdatingLocation()
            }
        }
        .navigationBarHidden(true)
    }
}
