//
//  LocationView.swift
//  Marshmello
//
//  Created by KimYuBin on 6/15/24.
//

import SwiftUI

struct LocationView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var buttonText = "여기"
    @State private var showAddress = false
    @State private var address = ""

    var body: some View {
        ZStack {
            Color.onboarding.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text(showAddress ? "몰입하는 장소가 지금 이 곳이 맞나요?" : "이 곳을 몰입하는 장소로 등록 하시겠어요?")
                    .suit(.semiBold, 16)
                    .foregroundStyle(.text)
                    .padding(.top, 170)
                
                if showAddress {
                    Text(address)
                        .suit(.extraBold, 24)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.title)
                        .padding(.top, 25)
                } else {
                    Text(" ")
                        .suit(.extraBold, 24)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.title)
                        .padding(.top, 25)
                }
                
                if !showAddress {
                    Button(action: {
                        buttonText = "웅"
                        showAddress = true
                        address = locationManager.address ?? ""
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(.rectangle)
                                .frame(width: 200)
                            
                            Text(buttonText)
                                .suit(.heavy, 64)
                                .foregroundStyle(.title)
                        }
                    })
                    .padding(.top, 54)
                } else {
                    NavigationLink(destination: MarshmelloView(address: $address)) {
                        ZStack {
                            Circle()
                                .fill(.rectangle)
                                .frame(width: 200)
                            
                            Text(buttonText)
                                .suit(.heavy, 64)
                                .foregroundStyle(.title)
                        }
                    }
                    .padding(.top, 54)
                }
                
                if !showAddress {
                    Button(action: {
                        locationManager.startUpdatingLocation()
                    }, label: {
                        Text("여기가 아니에요")
                            .suit(.semiBold, 18)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .foregroundStyle(.text)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.rectangle))
                            .hidden()
                    })
                    .padding(.top, 190)
                } else {
                    Button(action: {
                        locationManager.startUpdatingLocation()
                    }, label: {
                        Text("여기가 아니에요")
                            .suit(.semiBold, 18)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .foregroundStyle(.text)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.rectangle))
                    })
                    .padding(.top, 190)
                }
                
            }
            .onAppear {
                locationManager.startUpdatingLocation()
            }
        }
        .navigationBarHidden(true)
    }
}
