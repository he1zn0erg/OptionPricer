//
//  IOptionCalculator.swift
//  European Stock Option Calculator
//
//  Created by Bojan Simic on 29.07.16.
//  Copyright © 2016 Bojan Simic. All rights reserved.
//

import Foundation

protocol IOptionCalculator // Protokoll, das vorgibt, welche Methoden implementiert werden müssen
{
    func calcCall() -> Double
    func calcPut() -> Double
    func calcImpliedVol() -> Double
    func setOptionParameters(parameter:OptionData)
    func calcCallDelta() -> Double
    func calcPutDelta() -> Double
    func calcGamma() -> Double
    func calcCallTheta() -> Double
    func calcPutTheta() -> Double
    func calcVega() -> Double
    func calcCallRho() -> Double
    func calcPutRho() -> Double
}