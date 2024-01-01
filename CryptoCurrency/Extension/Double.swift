//
//  Double.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation

extension Double {

   
    var CurrencyFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator=true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        
        return formatter
        
        
    }
    
    
    func AsCurrnency6Digit()->String {
        let number = NSNumber(value: self)
        
        return CurrencyFormatter.string(from: number) ?? "$0.0"
        
    }
    
    func asNuberString()->String {
        
        
        return String(format: "%.2f",self )
    }
    
    func asPecetageNumber () ->String {
        
        return asNuberString() + "%"
    }
    
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNuberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNuberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNuberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNuberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNuberString()

        default:
            return "\(sign)\(self)"
        }
    }

    
    
}
