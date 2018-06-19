//
//  BlackScholesCalculator.swift
//  European Stock Option Calculator
//
//  Created by Bojan Simic on 29.07.16.
//  Copyright © 2016 Bojan Simic. All rights reserved.
//

import Foundation

class BlackScholesCalculator:IOptionCalculator // Klasse adaptiert Protokoll und muss so die festgelegten Funktionalitäten für sich angepasst implementieren
{
    let pi = M_PI
    let e = M_E
    
    public var param:OptionData
    
    init() // Initialisiert die Klasse BlackScholesCalculator
    {
        param = OptionData()
    }
    
    func setOptionParameters(param:OptionData) 
    {
        self.param = param
    }
    
    private func calcD() -> Double // berechnet den Inputwert d für die kumulierte Verteilungsfunktion der Standard-Normalverteilung N()
    {
        var d1 = (ln(param.stockPrice/param.strikePrice) + (param.interestRate + pow(param.sigma, 2)/2) * param.expirationInYears)
        var d2 = d1/(param.sigma * sqrt(param.expirationInYears)) // aufgesplitet in kleinere Einheiten da es zu komplex zum kompilieren ist (Fehlermeldung)
        // var d = (ln(stockPrice/strikePrice) + (interestRate + pow(sigma, 2)/2) * expirationInYears)/(sigma * sqrt(expirationInYears))
        return d2
    }
    
    func calcCall() -> Double
    {
        var d = calcD()
        var C = param.stockPrice * N(d) - exp(-param.interestRate * param.expirationInYears) * param.strikePrice * N(d - param.sigma * sqrt(param.expirationInYears))
        return C
    }
    
    func calcPut() -> Double
    {
        var d = calcD()
        var P = -param.stockPrice * N(-d) + exp(-param.interestRate * param.expirationInYears) * param.strikePrice * N(param.sigma * sqrt(param.expirationInYears) - d)
        return P
    }
    
    func calcImpliedVol() -> Double
    {
        var s = 0.0 // Function to calcualte implied vol
        //ToDo: Implement implied volatility function calculation
        param.sigma = s
        return s
    }
    
    func calcCallDelta() -> Double
    {
        var d = calcD()
        var delta = N(d)
        return delta
    }
    
    func calcPutDelta() -> Double
    {
        var d = calcD()
        var delta = N(d) - 1
        return delta
    }
    
    func calcGamma() -> Double
    {
        var d = calcD()
        var gamma = (1/(param.stockPrice * param.sigma * sqrt(param.expirationInYears))) * (1/sqrt(2 * pi)) * pow(e, (-(pow(d, 2))/2))
        return gamma
    }
    
    func calcCallTheta() -> Double
    {
        var d = calcD()
        var t1:Double = 1/365 // explizite Typenangabe notwendig, da Compiler sonst annimt, es wäre ein Int
        var t2 = (((param.stockPrice * param.sigma)/(2 * sqrt(param.expirationInYears))) * (1/sqrt(2 * pi)) * pow(e, (-(pow(d, 2)/2))))
        var theta = t1 * (-(t2) - param.interestRate * param.strikePrice * pow(e, -(param.interestRate * param.expirationInYears)) * N(d - param.sigma * sqrt(param.expirationInYears)))
        return theta
    }
    
    func calcPutTheta() -> Double
    {
        var d = calcD()
        var t1:Double = 1/365 // explizite Typenangabe notwendig, da Compiler sonst annimt, es wäre ein Int
        var t2 = (((param.stockPrice * param.sigma)/(2 * sqrt(param.expirationInYears))) * (1/sqrt(2 * pi)) * pow(e, (-(pow(d, 2)/2))))
        var theta = t1 * (-(t2) + param.interestRate * param.strikePrice * pow(e, -(param.interestRate * param.expirationInYears)) * N(-(d - param.sigma * sqrt(param.expirationInYears))))
        return theta
    }
    
    func calcVega() -> Double
    {
        var d = calcD()
        var vega = 0.01 * param.stockPrice * sqrt(param.expirationInYears) * 1/sqrt(2 * pi) * pow(e, (-(pow(d, 2)/2)))
        return vega
    }
    
    func calcCallRho() -> Double
    {
        var d = calcD()
        var rho = 0.01 * param.strikePrice * param.expirationInYears * pow(e, -param.interestRate * param.expirationInYears) * N(d - param.sigma * sqrt(param.expirationInYears))
        return rho
    }
    
    func calcPutRho() -> Double
    {
        var d = calcD()
        var rho = -(0.01) * param.strikePrice * param.expirationInYears * pow(e, -(param.interestRate * param.expirationInYears)) * N(-(d - param.sigma * sqrt(param.expirationInYears)))
        return rho
    }
    
    private func ln(value:Double) -> Double // natürlicher Logarithmus
    {
        return log(value)/log(M_E) // Logarithmusgesetze
    }
    
    func N(x:Double) -> Double
    {
        // Annäherung der Kumulierten Standard-Normalverteilung (Source: http://www.johndcook.com/blog/csharp_phi/ )
        // Konstanten
        let a1:Double = 0.254829592
        let a2:Double = -0.284496736
        let a3:Double = 1.421413741
        let a4:Double = -1.453152027
        let a5:Double = 1.061405429
        let p:Double = 0.3275911
        
        var sign:Int
        
        if (x < 0.0)
        {
            sign = -1
        }
        else
        {
            sign = 1
        }
        
        var z:Double = abs(x) / sqrt(2.0)
        
        // Abramowitz & Stegun, Handbook of Mathematical Functions; Formula 7.1.26
        var t:Double = 1.0 / (1.0 + p*z)
        
        var b1:Double = (a5 * t + a4) * t
        var b2:Double = (b1 + a3) * t
        var b3:Double = (b2 + a2) * t
        var b4:Double = (b3 + a1) * t
        var y:Double = 1.0 - b4 * exp(-z * z)
        // var y:Double = 1.0 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * exp(-z * z)
        
        return (0.5 * (1.0 + Double(sign) * y))
    }

}