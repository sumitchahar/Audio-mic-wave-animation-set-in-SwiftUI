//
//  ContentView.swift
//  AudioStreamingLayout
//
//  Created by Sumit on 04/02/25.
//

import SwiftUI

enum MicState:String {
    
    case Active
    case NonActive
    case None
}

struct AudioWaveAnimtion: View {
    
   @State private var waveOffset = Angle(degrees: 0)
   
   @State private var isShowingCircule = true
    
   @State private var mic_state:MicState = .NonActive

          let percent: Int
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 3)
                        .fill(LinearGradient(gradient: Gradient(colors: [.white,.init(red: 140.0/255.0, green: 1.0/255.0, blue: 195.0/255.0),.white]), startPoint: .top, endPoint: .bottom))
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.init(red: 140.0/255.0, green: 1.0/255.0, blue: 195.0/255.0)]), startPoint: .top, endPoint: .bottom)
                        )
                        .overlay(
                            WavelayerAnimations(offset: Angle(degrees: self.waveOffset.degrees), percent: mic_state == .Active ? Double(percent)/70 : 0)
                                .fill(LinearGradient(gradient: Gradient(colors: [.init(red: 230.0/255.0, green: 27/255.0, blue: 42.0/255.0), .red,.white,.red,.red]), startPoint: .top, endPoint: .bottom))
                                .clipShape(Circle().scale(0.92))
                        )
                    }
                .frame(width:70,height:70)
                .cornerRadius(70/2)
                .padding()
                .shadow(color: .white,radius: 2.6)
                .opacity(0.7)

                ZStack {
                    Button {
                        switch mic_state {
                        case .Active:
                            mic_state = .NonActive
                        case .NonActive:
                            mic_state = .Active
                        case .None: break
                      }
                    } label: {
                        Image(systemName: mic_state == .Active ?
                              "microphone.fill" : "mic.slash.fill")
                              .resizable()
                              .foregroundStyle(.white)
                              .frame(width:mic_state == .Active ? 26 : 26 ,height:mic_state == .Active ? 28 : 28)
                              .shadow(color: .black,radius: 0.4)
                              .opacity(1.0)
                    }
                }
            }
            .overlay(
                Circle()
                    .stroke(isShowingCircule == true ? .red : .clear,lineWidth: 0.8)
                    .frame(width: 104, height: 104)
                    .phaseAnimator([false, mic_state == .Active ? true : false]) { wwdc24, chromaRotate in
                        wwdc24
                            .hueRotation(.degrees(chromaRotate ? 220 : 0))
                    } animation: { chromaRotate in
                            .easeInOut(duration: 2)
                  }
                    .shadow(color: .white,radius: 0.4)
            )
            .overlay(
                Circle()
                  .stroke(isShowingCircule == true ? .red : .clear,lineWidth: 1.8)
                   .shadow(color:.white, radius: 8)
                    .frame(width: 150, height: 150)
                    .phaseAnimator([false, mic_state == .Active ? true : false]) { wwdc24, chromaRotate in
                        wwdc24
                            .hueRotation(.degrees(chromaRotate ? 420 : 0))
                    } animation: { chromaRotate in
                            .easeInOut(duration: 2)
                    }
            )
        }
        .frame(width: 150, height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [.init(red: 140.0/255.0, green: 1.0/255.0, blue: 195.0/255.0),.init(red: 140.0/255.0, green: 1.0/255.0, blue: 195.0/255.0),.red]), startPoint: .top, endPoint: .bottom)
             .opacity(0.5)
        )
        .cornerRadius(150/2)
        .onAppear {
            withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
         }
     }
 }

#Preview {
    AudioWaveAnimtion(percent: 40).preferredColorScheme(.dark)
}


