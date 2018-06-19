//
//  Option Pricer.swift
//  European Stock Option Calculator
//
//  Created by Bojan Simic on 25.07.16.
//  Copyright © 2016 Bojan Simic. All rights reserved.
//

import Foundation

public struct OptionData // Strukturen speichern die wichtigsten Variablen
{
    public var stockPrice:Double = 0
    public var strikePrice:Double = 0
    public var sigma:Double = 0
    public var expirationInYears:Double = 0
    public var interestRate:Double = 0
    public var price:Double = 0
}

public class OptionPricer // Anlegen einer öffentlichen Klasse...
{
    public var param = OptionData() //... welche fünf Werte verwaltet (siehe struct OptionData)
    private var calcEngine:IOptionCalculator // mit calcEngine kann man calcCall(), calcPut() und setOptionParameters() (siehe Protokoll) aufrufen
    
    init(optionInputParameters:OptionData, calcEngine:IOptionCalculator) // Intialisieren (man muss kein Objekt erstellen um auf öffentliche Variablen zugreifen zu könne)
    {
        param = optionInputParameters
        self.calcEngine = calcEngine
        self.calcEngine.setOptionParameters(param)
    }
    
    public var CallPrice:Double
    {
        get { return calcEngine.calcCall() } // Getter greift lesend auf das Ergebnis von calcCall() zu
    }
    
    public var PutPrice:Double
    {
        get { return calcEngine.calcPut() } // Getter greift lesend auf das Ergebnis von calcPut() zu
        
    }
    
    public var ImpliedVol:Double
    {
        get { return calcEngine.calcImpliedVol() }
    }
    
    public var deltaCallValue:Double
    {
        get { return calcEngine.calcCallDelta() }
    }
    
    public var deltaPutValue:Double
    {
        get { return calcEngine.calcPutDelta() }
    }
    
    public var gammaValue:Double
    {
        get { return calcEngine.calcGamma() }
    }
    
    public var thetaCallValue:Double
    {
        get { return calcEngine.calcCallTheta() }
    }
    
    public var thetaPutValue:Double
    {
        get { return calcEngine.calcPutTheta() }
    }
    
    public var vegaValue:Double
    {
        get { return calcEngine.calcVega() }
    }
    
    public var rhoCallValue:Double
    {
        get { return calcEngine.calcCallRho() }
    }
    
    public var rhoPutValue:Double
    {
        get { return calcEngine.calcPutRho() }
    }
}