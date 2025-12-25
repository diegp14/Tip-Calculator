//
//  ContentView.swift
//  TipCalculator
//
//  Created by Diego Guzman on 23/12/25.
//

import SwiftUI

//^
struct ContentView: View {
    @State private var bill: Int?
    @State private var text: String = ""
    @State private var numPeople: String = "1"
    @State private var propina: String = ""
    @State private var showMessageError: Bool = false
    @State private var showTextField: Bool = false
    
    @State private var result: Double = 0.0
    @State private var resultPerPerson: Double = 0.0
    @State private var tipTotal = 0.0
    @State private var tipPerPerson: Double = 0.0
    
    //let regexNumber = try! Regex("^[0-9]+(\\.[0-9]+)?$")
    let regexNotNumber = try! Regex("[^0-9]")
    let regexNumber = try! Regex("^[0-9]+(\\.[0-9]+)?$")
    var body: some View {
        NavigationStack {
            Text("Calculadora Propinas")
                .font(Font.largeTitle)
            
            Form {
                Section {

                    TextField("Cuenta:", text: $text)
                        .onChange(of: text) { oldValue, newValue in
                            showMessageError = !newValue.contains(regexNumber)
                            print(showMessageError)
                        }
                        .keyboardType(.numbersAndPunctuation)
                    if showMessageError && !text.isEmpty {
                        Label("Error", systemImage: "exclamationmark.circle")
                            .font(.caption)
                            .foregroundStyle(Color.red)
                    }
                    TextField("Num. Personas:", text: $numPeople)
                    
                    Text("Porcentaje:")
                    Button {
                        print("10%")
                        calculateTip(tipPorcentage: 10.0, numPeople: Int(numPeople) ?? 1)
                        
                    } label: {
                        Text("10%").foregroundStyle(.black)
                    }
                    Button {
                        print("15%")
                        calculateTip(tipPorcentage: 15, numPeople: Int(numPeople) ?? 1)
                    } label: {
                        Text("15%").foregroundStyle(.black)
                    }
                    Button {
                        print("25%")
                        calculateTip(tipPorcentage: 25, numPeople: Int(numPeople) ?? 1)
                    } label: {
                        Text("25%").foregroundStyle(.black)
                    }
                    Button {
                       // print("Abrir textfield")
                        showTextField = !showTextField
                        propina = ""
                    } label: {
                        Text("Personalizar")
                            .foregroundStyle(.black)
                    }
                    if showTextField {
                        NumberInput(placeholder: "Propina", regex: regexNumber, propina: $propina){
                            print("onSubmit\(propina)")
                            calculateTip(tipPorcentage: Double(propina) ?? 0, numPeople: Int(numPeople) ?? 1)
                        }
                            
                    }
                    

                }
            }
           
            Section("Resultado:") {
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
        .padding()
    }
    private func calculateTip(tipPorcentage: Double, numPeople: Int) {
        let tip = tipPorcentage / 100.0
        let bill = Double(text) ?? 0.0
        tipTotal = bill * tip
        tipPerPerson = tipTotal / Double(numPeople)
        result = bill + tipTotal
        resultPerPerson = result / Double(numPeople)
        
        
       
    }
}

#Preview {
    ContentView()
}
