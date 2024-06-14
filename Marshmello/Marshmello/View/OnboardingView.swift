//
//  OnboardingView.swift
//  Marshmello
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    private let totalPages = 5
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.onboarding.ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button(action: {
                            if currentPage > 0 {
                                currentPage -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.text)
                                .frame(width: 28, height: 28)
                                .padding(.horizontal, 25)
                        }
                        .opacity(currentPage > 0 ? 1 : 0)
                        
                        Spacer()
                        
                        NavigationLink {
                            LocationView()
                        } label: {
                            Text("건너뛰기")
                                .suit(.semiBold, 18)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.text)
                                .frame(width: 87, height: 38)
                        }
                        .padding(.horizontal, 23)
                    }
                    
                    CustomProgressView(currentPage: currentPage, totalPages: totalPages)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 17)
                    
                    Spacer()
                    
                    onboardingContent(for: currentPage)
                    
                    Spacer()
                    
                    if currentPage < totalPages - 1 {
                        Button(action: {
                            currentPage += 1
                        }, label: {
                            Text("다음")
                                .suit(.bold, 20)
                                .padding(.horizontal, 155)
                                .padding(.vertical, 20)
                                .foregroundStyle(.button)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.rectangle))
                        })
                        .padding(.bottom, 20)
                    } else {
                        NavigationLink(destination: LocationView()) {
                            Text("완료")
                                .suit(.bold, 20)
                                .padding(.horizontal, 155)
                                .padding(.vertical, 20)
                                .foregroundStyle(.button)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.rectangle))
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    private func onboardingContent(for page: Int) -> some View {
        switch page {
        case 0:
            Image(.onboarding1)
            Text("마쉬멜로우는 우리의 삶입니다.")
                .suit(.semiBold, 18)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.top, 28)
        case 1:
            Image(.onboarding2)
            HStack(spacing: 0) {
                Text("불은 우리의 몰입")
                    .suit(.semiBold, 18)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.top, 28)
                
                Text("(노동)")
                    .suit(.semiBold, 18)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.text2)
                    .padding(.top, 28)
                
                Text(" 입니다.")
                    .suit(.semiBold, 18)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.top, 28)
            }
            
        case 2:
            Image(.onboarding3)
            Text("몰입 장소에서 불이 켜지고,\n몰입 시간에 따라 불의 크기가 변화합니다.")
                .suit(.semiBold, 18)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.top, 28)
        case 3:
            Image(.onboarding4)
            Text("불을 키워 마쉬멜로우를 구워보세요.")
                .suit(.semiBold, 18)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.top, 28)
        case 4:
            Image(.onboarding5)
            Text("너무 오래 구우면 마쉬멜로우가 타버려요.")
                .suit(.semiBold, 18)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.top, 28)
        default:
            EmptyView()
        }
    }
}

struct CustomProgressView: View {
    var currentPage: Int
    var totalPages: Int
    
    var body: some View {
        HStack(spacing: 7) {
            ForEach(0..<totalPages, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(index <= currentPage ? Color.white : Color.progressBar)
                    .frame(width: 63, height: 8)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    OnboardingView()
}
