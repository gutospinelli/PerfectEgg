//
//  ContentView.swift
//  PerfectEgg WatchKit Extension
//
//  Created by Augusto Spinelli on 04/08/20.
//  Copyright © 2020 Augusto Spinelli. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vmEgg: EggVM
    
    @State private var animatedBonusRemaining : Double = 1
    @State private var timeRemaining : Int = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    var body: some View {
        GeometryReader { geometry in
            self.content(for: geometry.size)
        }

    }
    
    @ViewBuilder
    private func content(for size : CGSize) -> some View {
        //2 linhas, conteúdo e botão
        VStack {
            //linha 1: Conteudo
            HStack {
            // 2 colunas, ovos e timer
                //coluna 1: N ovos empilhados (ZStack)
                ZStack {
                    ForEach(vmEgg.cards) { card in
                        HStack {
                            if card.onScreen {
                                card.img.resizable().onTapGesture {
                                    withAnimation(.default) {
                                        self.vmEgg.select(card: card)
                                    }
                                }
                                
                                VStack {
                                    Text("\(self.timeRemaining)")
                                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-self.animatedBonusRemaining*360-90),clockwise: true)
                                        .onAppear {
                                            self.animatedBonusRemaining = card.bonusRemaining
                                            withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                                self.animatedBonusRemaining = 0
                                            }
                                            
                                    }
                                }.onAppear {
                                    self.timeRemaining = card.boilTimeInSeconds
                                }
                            }
                        }
                    }.onReceive(self.timer) { _ in
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        }
                    }
                }
            }
            
            //linha 2: Botao
            Button(action: {
                withAnimation(.easeInOut) {
                    self.vmEgg.reset()
                }
            }, label: {Text("Start Timer")})
        }.foregroundColor(Color.yellow)
    }

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let timer = EggVM()
        return ContentView(vmEgg: timer)
    }
}
