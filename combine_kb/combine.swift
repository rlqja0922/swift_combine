//
//  combine.swift
//  combine_kb
//
//  Created by reborn on 2021/10/15.
//

import SwiftUI
import Combine

struct combine: View {
    @State var Color1 = Color.white
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    var body: some View {
        ZStack{
            VStack{
                Button(action: {
                    combine1()
                }, label: {
                    Text("컴바인")
                        .frame(width: 200, height: 100)
                        .background(Color1)
                })
                Text("timer")
                    .onReceive(timer){time in
                        if self.counter == 5 {
                            Color1 = Color.green
                            self.timer.upstream.connect().cancel()
                        } else {
                        print("timer \(time)")
                        }
                        self.counter += 1
                }
                    .frame(width: 200, height: 100)
                    .background(Color1)
            }
        }
    }
    func combine1() {
        
        let myRange = (0...3)
        let cancellable = myRange.publisher
            .sink(receiveCompletion: {
                print ("completion: \($0)")
                Color1 = Color.red
            },
                  receiveValue: { print ("value: \($0)") })
    }
}

struct combine_Previews: PreviewProvider {
    static var previews: some View {
        combine()
    }
}
