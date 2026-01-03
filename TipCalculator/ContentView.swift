//
//  ContentView.swift
//  TipCalculator
//
//  Created by Diego Guzman on 23/12/25.
//

import SwiftUI

//^
struct ContentView: View {
    
    @FocusState private var billFocus: Bool
    @State private var bill: String = ""
    @State private var numPeople: String = ""
    @State private var tip: String = ""
    @State private var showMessageError: Bool = false
    @State private var showTextField: Bool = false
    
    @State private var result: Double = 0.0
    @State private var resultPerPerson: Double = 0.0
    @State private var tipTotal = 0.0
    @State private var tipPerPerson: Double = 0.0
    @State private var showResults: Bool = false
    
    //let regexNumber = try! Regex("^[0-9]+(\\.[0-9]+)?$")
    let regexNotNumber = try! Regex("[^0-9]")
    let regexNumber = try! Regex("^[0-9]+(\\.[0-9]+)?$")
    
    var body: some View {
        NavigationStack {
            Text("Calculadora Propinas")
                .font(Font.largeTitle)
            Form {
                Section {
                    TextField("Cuenta:", text: $bill)
                        .focused($billFocus)
                        .onChange(of: bill) { oldValue, newValue in
                            showMessageError = !newValue.contains(regexNumber)
                            print(showMessageError)
                        }
                        .keyboardType(.numbersAndPunctuation)
                    if showMessageError && !bill.isEmpty {
                        Label("Error", systemImage: "exclamationmark.circle")
                            .font(.caption)
                            .foregroundStyle(Color.red)
                    }
                    TextField("Num. Personas:", text: $numPeople)
                    VStack {
                        Text("Porcentaje:")
                            .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                        HStack {
                            VStack {
                                Button {
                                    print("10%")
                                    tip = "10"
                                    calculateTip(tipPorcentage: 10.0, numPeople: Int(numPeople) ?? 1)
                                    showResults = true
                                    
                                } label: {
                                    Text("10%").foregroundStyle(.black)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .buttonStyle(.glassProminent)
                            }
                            VStack {
                                Button {
                                    print("15%")
                                    tip = "15"
                                    calculateTip(tipPorcentage: 15, numPeople: Int(numPeople) ?? 1)
                                    showResults = true
                                } label: {
                                    Text("15%").foregroundStyle(.black)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .buttonStyle(.glassProminent)
                            }
                            VStack {
                                Button {
                                    print("25%")
                                    tip = "25"
                                    calculateTip(tipPorcentage: 25, numPeople: Int(numPeople) ?? 1)
                                    showResults = true
                                } label: {
                                    Text("25%").foregroundStyle(.black)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .buttonStyle(.glassProminent)
                            }
                        }
                      
                    }
                   
                    
                    Button {
                       // print("Abrir textfield")
                        showTextField = !showTextField
                        tip = ""
                    } label: {
                        Text("Personalizar")
                            .foregroundStyle(.black)
                    }
                    if showTextField {
                        NumberInput(placeholder: "Propina", regex: regexNumber, propina: $tip){
                            print("onSubmit\(tip)")
                            calculateTip(tipPorcentage: Double(tip) ?? 0, numPeople: Int(numPeople) ?? 1)
                            showResults = true
                        }
                    }
                }
            }
            if showResults{
                Section() {
                    VStack {
                        Button {
                           //
                            bill = ""
                            tip = ""
                            numPeople = ""
                            showResults = false
                            billFocus = true
                            showTextField = false
                            
                        } label: {
                            Label("Nuevo calculo", systemImage: "arrow.clockwise.circle.fill")
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.vertical)
                    HStack{
                        Text("Propina Seleccionada:")
                        Text(tip + "%")
                    }
                    HStack{
                        Text("Propina Total:")
                        Text("\(tipTotal.formatted())")
                    }
                    HStack{
                        Text("Propina por persona:")
                        Text("\(tipPerPerson.formatted())")
                    }
                    HStack{
                        Text("Cuenta Total:")
                        Text("\(result.formatted())")
                    }
                    HStack{
                        Text("Cuenta por persona:")
                        Text("\(resultPerPerson.formatted())")
                    }
                   
                }
            }
                
           
           
        }
        .padding()
    }
    private func calculateTip(tipPorcentage: Double, numPeople: Int) {
        let tip = tipPorcentage / 100.0
        let bill = Double(bill) ?? 0.0
        tipTotal = bill * tip
        tipPerPerson = tipTotal / Double(numPeople)
        result = bill + tipTotal
        resultPerPerson = result / Double(numPeople)
        
        
       
    }
}

#Preview {
    ContentView()
}
