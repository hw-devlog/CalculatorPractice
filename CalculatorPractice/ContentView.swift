//
//  ContentView.swift
//  CalculatorPractice
//
//  Created by Hyunwoo Lee on 2023/07/20.
//

import SwiftUI

enum ButtonType:String {
    case first, second, third, forth , fifth, sixth, seventh, eighth, nineth, zero
    case dot, equal, plus, minus, multieply, divide
    case percent, clear, opposite
    
    var buttonDisplayName: String {
        switch self {
        case .first:
            return "1"
        case .second:
            return "2"
        case .third:
            return "3"
        case .forth:
            return "4"
        case .fifth:
            return "5"
        case .sixth:
            return "6"
        case .seventh:
            return "7"
        case .eighth:
            return "8"
        case .nineth:
            return "9"
        case .zero:
            return "0"
        case .dot:
            return "."
        case .equal:
            return "="
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multieply:
            return "X"
        case .divide:
            return "÷"
        case .percent:
            return "%"
        case .clear:
            return "C"
        case .opposite:
            return "+/-"
            
        }
    }
    var backgroundColor: Color {
        switch self {
        case .first, .second, .third, .forth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, .dot:
            return Color("NumberButton")
        case .dot, .equal, .plus, .minus, .multieply, .divide:
            return Color.orange
        case .percent, .clear, .opposite:
            return Color.gray
        }
    }
}

struct ContentView: View {
    
    @State private var secondNumber: String = "0"
    @State var firstNumber: Int = 0
    @State var operatortype: ButtonType = .clear
    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite, .percent, .divide],
        [.seventh, .eighth, .nineth, .multieply],
        [.forth, .fifth, .sixth, .minus],
        [.first, .second, .third, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View{
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(secondNumber)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundColor(.white)
                }
                
                ForEach(buttonData, id: \.self) {line in
                    HStack {
                        ForEach(line, id: \.self) {
                            item in
                            Button{
                                if secondNumber == "0"{
                                    if item == .clear {
                                        secondNumber = "0"
                                        
                                    } else if item == .plus ||
                                                item == .minus ||
                                                item == .multieply ||
                                                item == .divide ||
                                                item == .percent ||
                                                item == .opposite ||
                                                item == .equal{secondNumber = "Error"}
                                    else {
                                        secondNumber =
                                        item.buttonDisplayName
                                    }
                                    
                                } else {
                                    if item == .clear {
                                        secondNumber = "0"}
                                    else if item == .plus{
                                        firstNumber = Int(secondNumber) ?? 0       //숫자를 저장
                                        operatortype = .plus                     //더하기를 한다
                                        secondNumber = "0"                        //남은 숫자를 초기화
                                    }
                                    else if item == .multieply{
                                        firstNumber = Int(secondNumber) ?? 0       //숫자를 저장
                                        operatortype = .multieply                //곱하기를 한다
                                        secondNumber = "0"                        //남은 숫자를 초기화
                                    }
                                    else if item == .minus{
                                        firstNumber = Int(secondNumber) ?? 0       //숫자를 저장
                                        operatortype = .minus                    //빼기를 한다
                                        secondNumber = "0"                        //남은 숫자를 초기화
                                    } else if item == .equal {
                                        if operatortype == .plus {secondNumber = String((Int(secondNumber) ?? 0) + firstNumber)}
                                        else if operatortype == .multieply {secondNumber = String((Int(secondNumber) ?? 0) * firstNumber)
                                        }
                                        else if operatortype == .minus {secondNumber = String(firstNumber - (Int(secondNumber) ?? 0))
                                        }
                                    }
                                    
                                    
                                    else {secondNumber +=
                                        item.buttonDisplayName
                                    }
                                }
                            } label: {
                                Text(item.buttonDisplayName)
                                    .bold()
                                    .frame(width: calculateButtonWidth(button: item),height: calculateButtonheigt(button: item))
                                    .background(item.backgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                                    .font(.system(size: 33))
                            }
                            
                        }
                    }
                }
            }
        }
    }
    private func calculateButtonWidth(button buttonType: ButtonType) -> CGFloat {
        switch buttonType{
        case .zero:
            return ((UIScreen.main.bounds.width - 5*10) / 4) * 2
        default:
            return  (UIScreen.main.bounds.width - 5*10) / 4
        }}
    private func calculateButtonheigt(button: ButtonType) -> CGFloat {
        return  (UIScreen.main.bounds.width - 5*10) / 4
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


