//
//  GuideView.swift
//  Marshmello
//
//  Created by KimYuBin on 6/15/24.
//

import SwiftUI

struct GuideView: View {
    @State private var currentPage = 0
    private let totalPages = 5
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.onboarding.ignoresSafeArea()
                
                VStack {
                    Text("\(currentPage + 1)/\(totalPages)")
                        .suit(.bold, 20)
                        .foregroundStyle(.white)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    onboardingContent(for: currentPage)
                    
                    Spacer()
                    
                    if currentPage < totalPages - 1 {
                        Button(action: {
                            currentPage += 1
                            HapticManager.shared.notification(type: .success)
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
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("완료")
                                .suit(.bold, 20)
                                .padding(.horizontal, 155)
                                .padding(.vertical, 20)
                                .foregroundStyle(.button)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.rectangle))
                        })
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
