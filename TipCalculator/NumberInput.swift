//
//  NumberInput.swift
//  TipCalculator
//
//  Created by Diego Guzman on 25/12/25.
//

import SwiftUI

struct NumberInput: View {
    
    var placeholder: String = ""
    var regex: Regex<AnyRegexOutput>
   
    
    //@State private var text: String = ""
    @Binding var propina: String
    @State private var showMessageError: Bool = false
    let regexNumber = try! Regex("^[0-9]+(\\.[0-9]+)?$")
    
    var onSubmit: () -> Void = { }
    
    
    var body: some View {
        TextField("\(placeholder):", text: $propina)
            .onChange(of: propina) { oldValue, newValue in
                showMessageError = !newValue.contains(regexNumber)
                print(showMessageError)
            }
            .onSubmit {
              onSubmit()
            }
          
            .keyboardType(.numbersAndPunctuation)
        if showMessageError && !propina.isEmpty {
            Label("Error", systemImage: "exclamationmark.circle")
                .font(.caption)
                .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    @Previewable @State  var text: String = ""
    let regexNumber = try! Regex("^[0-9]+(\\.[0-9]+)?$")
    NumberInput( regex: regexNumber, propina:$text )
}
