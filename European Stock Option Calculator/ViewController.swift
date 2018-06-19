//
//  ViewController.swift
//  European Stock Option Calculator
//
//  Created by Bojan Simic on 24.07.16.
//  Copyright © 2016 Bojan Simic. All rights reserved.
//

import UIKit

class ViewController:UIViewController
{   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var optionData = OptionData() // mit optionData. kann jeder Parameter in OptionData() angesprochen werden
    
    // Outlet stellt Verbindung vom UI zum Source her (MVC)
    @IBOutlet weak var stockInput: UITextField!
    @IBOutlet weak var strikeInput: UITextField!
    @IBOutlet weak var volatilityInput: UITextField!
    @IBOutlet weak var expirationInput: UITextField!
    @IBOutlet weak var rateInput: UITextField!
    @IBOutlet weak var optionPriceOnput: UITextField!
    
    @IBOutlet weak var impliedVolOutput: UILabel!
    
    // Greeks
    @IBOutlet weak var putDeltaOutput: UILabel!
    @IBOutlet weak var putGammaOutput: UILabel!
    @IBOutlet weak var putThetaOutput: UILabel!
    @IBOutlet weak var putVegaOutput: UILabel!
    @IBOutlet weak var putRhoOutput: UILabel!
    
    @IBOutlet weak var callDeltaOutput: UILabel!
    @IBOutlet weak var callGammaOutput: UILabel!
    @IBOutlet weak var callThetaOutput: UILabel!
    @IBOutlet weak var callVegaOutput: UILabel!
    @IBOutlet weak var callRhoOutput: UILabel!
    
    @IBOutlet weak var callOutput: UILabel!
    @IBOutlet weak var putOutput: UILabel!
    
    func runCalculation()
    {
        var calcEngine = BlackScholesCalculator()
        var option = OptionPricer(optionInputParameters: optionData, calcEngine: calcEngine)
        
        if tabBarController?.selectedIndex == 0
        {
            var callPrice = option.CallPrice
            var putPrice = option.PutPrice
            callOutput.text = String(format: "%.3f", callPrice)
            putOutput.text = String(format: "%.3f", putPrice)
        }
        else if tabBarController?.selectedIndex == 1
        {
            var impliedVol = option.ImpliedVol
            impliedVolOutput.text = String(format: "%.3f", impliedVol)
        }

        var deltaCallValue = option.deltaCallValue
        var deltaPutValue = option.deltaPutValue
        var gammaValue = option.gammaValue
        var vegaValue = option.vegaValue
        var thetaCallValue = option.thetaCallValue
        var thetaPutValue = option.thetaPutValue
        var rhoCallValue = option.rhoCallValue
        var rhoPutValue = option.rhoPutValue


        callDeltaOutput.text = String(format: "%.3f", deltaCallValue)
        putDeltaOutput.text = String(format: "%.3f", deltaPutValue)
        callGammaOutput.text = String(format: "%.3f", gammaValue)
        putGammaOutput.text = String(format: "%.3f", gammaValue)
        callThetaOutput.text = String(format: "%.3f", thetaCallValue)
        putThetaOutput.text = String(format: "%.3f", thetaPutValue)
        callVegaOutput.text = String(format: "%.3f", vegaValue)
        putVegaOutput.text = String(format: "%.3f", vegaValue)
        callRhoOutput.text = String(format: "%.3f", rhoCallValue)
        putRhoOutput.text = String(format: "%.3f", rhoPutValue)
        
    }
    
    // isValidInput() und allChecksPassed() prüfen, ob Eingabefelder ausgefüllt sind aber kein "." eingegeben wurde (wenn Benutzer nur "." eintippt, crasht die App)
    func isValidInput(currentInput:String) -> Bool
    {
        if Double(currentInput) == nil || currentInput.isEmpty
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func allChecksPassed() -> Bool
    {
        var isValid = true
        var inputSet:Set = [stockInput.text!, strikeInput.text!, volatilityInput.text!, expirationInput.text!, rateInput.text!] // in anderen Programmiersprachen als Set bezeichnet
        for input in inputSet // for-Schliefe...
        {
            if !isValidInput(input) //... prüft, dass alle! Eingabewerte ≠leer und auch ≠"." sind
            {
                isValid = false
            }
        }
        return isValid
    }
    
    @IBAction func stockInput(sender: UITextField)
    {
        /*
         Wenn der Benutzer etwas eingibt, dann wird mit isValidInput() geprüft, ob die Eingabe ≠leer und auch ≠"." ist. Wenn dieser Umstand erfüllt ist, dann wird isValidInput() als Rückgabewert TRUE zurückgeben. Dann wird die Benutzereingabe, die als String vorliegt, in ein Double konvertiert.
         */
        if isValidInput(stockInput.text!)
        {
            optionData.stockPrice = Double(stockInput.text!)!
        }
        if allChecksPassed()
        {
            stockInput.addTarget(self, action: Selector(runCalculation()), forControlEvents: UIControlEvents.EditingChanged)
        }
        /*
            Wenn Benutzer den Wert ändert, wird Methode runCalculation() ausgeführt. Zuvor wird aber mit allChecksPassed() sichergestellt, dass kein Eingabefeld leer ist oder dass es nicht aus "." besteht und erst dann wird die Methode runCalculation() zum Einsatz kommen .
         */
    }
    
    @IBAction func strikeInput(sender: UITextField)
    {
        if isValidInput(strikeInput.text!)
        {
            optionData.strikePrice = Double(strikeInput.text!)!
        }
        if allChecksPassed()
        {
            strikeInput.addTarget(self, action: Selector(runCalculation()), forControlEvents: UIControlEvents.EditingChanged)
        }
    }
    
    @IBAction func volatilityInput(sender: UITextField)
    {
        if isValidInput(volatilityInput.text!)
        {
            optionData.sigma = Double(volatilityInput.text!)!/100
        }
        if allChecksPassed()
        {
            volatilityInput.addTarget(self, action: Selector(runCalculation()), forControlEvents: UIControlEvents.EditingChanged)
        }
    }
    
    @IBAction func expirationInput(sender: UITextField)
    {
        if isValidInput(expirationInput.text!)
        {
            optionData.expirationInYears = Double(expirationInput.text!)!/365
        }
        if allChecksPassed()
        {
            expirationInput.addTarget(self, action: Selector(runCalculation()), forControlEvents: UIControlEvents.EditingChanged)
        }
    }
    
    @IBAction func rateInput(sender: UITextField)
    {
        if isValidInput(rateInput.text!)
        {
            optionData.interestRate = Double(rateInput.text!)!/100
        }
        if allChecksPassed()
        {
            rateInput.addTarget(self, action: Selector(runCalculation()), forControlEvents: UIControlEvents.EditingChanged)
        }
    }
    
//    @IBAction func optionPriceInput(sender: UITextField)
//    {
//        if isValidInput(optionPriceInput.text!)
//        {
//            optionData.price = Double(optionPriceInput.text!)!
//        }
//        if allChecksPassed()
//        {
//            optionPriceInput.addTarget(self, action: Selector(runCalculation()), forControlEvents: UIControlEvents.EditingChanged)
//        }
//    }
    
    /*
     //
     Date Picker Implementation
     //
    */

    @IBOutlet weak var startDateOutput: UILabel!
    @IBOutlet weak var endDateOutput: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var answerFieldTimeDifference: UILabel!
    
    var firstDate:NSDate?
    var lastDate:NSDate?
    
    @IBAction func startButton(sender: AnyObject) // Knopf um Anfangsdatum zu setzen
    {
        firstDate = datePicker.date // das Startdatum das der Benutzer ausgewählt hat, wird in der Variable firstDate gespeichert
        let dateStr = NSDateFormatter.localizedStringFromDate(firstDate!, dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle) // mit NSDateFormatter.localizedStringFromDate() wird nun das aus dem Date Picker ausgelesene Datum übergeben und zugleich mit dateStyle die Datumsschreibweise im MediumStyle festgelegt
        startDateOutput.text = dateStr // ausgewähltes Startdatum wird nun angezeigt
        //calculateDifference() // Aufrufen der Funktion, welche die Differenz zwischen den beiden Daten berechnet
        daysBetweenDates()
    }
    
    @IBAction func expirationButton(sender: AnyObject) // Knopf um das Enddatum zu setzen
    {
        lastDate = datePicker.date // ausgewähltes Enddatum wird der Variable lastDate zugewiesen
        let dateStr = NSDateFormatter.localizedStringFromDate(lastDate!, dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        endDateOutput.text = dateStr // Ausgabe des Enddatum
        //calculateDifference()
        daysBetweenDates()
    }
    
    func daysBetweenDates()
    {
        if var lastDate = lastDate, var firstDate = firstDate // Prüft ob den Variablen 'firstDate' und 'lastDate' auch ein Datum zugewiesen wurde. Ohne diese Zeile würde die App crashen, nachdem man eines der beiden Knöpfe drückt.
        {
            let calendar = NSCalendar.currentCalendar()
            
            let date1 = calendar.startOfDayForDate(firstDate)
            let date2 = calendar.startOfDayForDate(lastDate)
        
            let components = calendar.components([.Day], fromDate: date1, toDate: date2, options: [])
        
            var differenceInDays = components.day
        
            answerFieldTimeDifference.text = String(differenceInDays)
        }
    }
    
    
//    func calculateDifference() // TODO: Wrong output when there is actually a difference of 1 day
//    {
//        if var firstDate = firstDate, var lastDate = lastDate
//        {
//            let dateComponentsFormatter = NSDateComponentsFormatter() // initialisieren von NSDateComponentsFormatter...
//            dateComponentsFormatter.allowedUnits = [NSCalendarUnit.Day] // ...um die Einheit (eine Eigenschaft) festzulegen, in welcher die Differenz angegeben wird (hier: in Tagen) ...
//            
//            var differenceInDays = dateComponentsFormatter.stringFromDate(firstDate, toDate: lastDate) // ...und um dann die Differenz zu berechnen (String)
//            
//            var differenceInDaysWithoutCharD = differenceInDays!.substringToIndex(differenceInDays!.endIndex.predecessor()) // Da die Differenz noch einen Buchstaben enthält (z.B. 730d), muss man ihn entfernen, damit er in ein Int umgewandelt werden kann. Da er immer an letzter Stelle ist, kann man ihn "wegschneiden".
//            
//            var differenceAsInt = Int(differenceInDaysWithoutCharD)
//
//            answerFieldTimeDifference.text = differenceInDays
//            
//            if differenceAsInt > 1
//            {
//                answerFieldTimeDifference.text =  "Time to Maturity is " + differenceInDaysWithoutCharD + " days"
//            }
//            else if differenceAsInt >= 0
//            {
//                answerFieldTimeDifference.text = "Time to Maturity is " + differenceInDaysWithoutCharD + " day"
//            }
//            else if differenceAsInt < 0
//            {
//                answerFieldTimeDifference.text = "" // Wenn schon ein gültiges Datum gewählt wurde und dann beim zweiten Mal etwas Falsches eingegeben wird, dann würde die vorherige Berechnung noch dort stehen. Das Output Feld wird mit dieser Zeile wieder leer.
//                endDateOutput.text = ""
//                lastDate = NSDate()
//                wrongDateInputAlert()
//            }
//        
//        }
//    }
    
    func wrongDateInputAlert() // Pop-Up Fenster das erscheint, wenn der Benutzer eine falsche Eingabe gemacht hat
    {
        var alertController: UIAlertController

        alertController = UIAlertController(title: "Wrong Input", message: "End Date must be set later than Start Date", preferredStyle: UIAlertControllerStyle.Alert)
        
        let receive = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(receive)
        
        self.presentViewController(alertController , animated: true, completion: nil)
    }
    
    @IBAction func doneButton(sender: AnyObject) // action for "Done" button in navigation bar
    {
        if tabBarController?.selectedIndex == 0
        {
            //optionExpirationInput.text = calculatedDifferenceInDays // difference in days is being applied to the input field
            self.navigationController?.popViewControllerAnimated(true)
            // date picker scene should disappear and switch back to Option Input Scene??
        }
        else if tabBarController?.selectedIndex == 1
        {
            //volatilityExpirationInput.text = calculatedDifferenceInDays
            self.navigationController?.popViewControllerAnimated(true)
            // date picker scene should disappear and switch back to Volatility Input Scene??
        }
    }
    
    /*
     //
     Query implementation
     //
    */
    
    @IBAction func queryButton(sender: AnyObject)
    {
        displayQueryAlert()
    }
    
    func displayQueryAlert()
    {
        
        var alertController: UIAlertController
        // Pop Up Dialog
        alertController = UIAlertController(title: "Import Stock Price", message: "Enter Quote to receive real-time Stock Price", preferredStyle: UIAlertControllerStyle.Alert)
        
        // Fügt den Knopf "Cancel" im Pop Up Fenster ein
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(cancel)
        var price = ""
        let receive = UIAlertAction(title: "Recieve", style: UIAlertActionStyle.Default) { (action) in
            //price = self.apiCaller.callJSON("AAPL")
            self.displayResultAlert()
        }
        
        alertController.addAction(receive)
        
        alertController.addTextFieldWithConfigurationHandler( { (textField) -> Void in
            textField.placeholder = "e.g. AAPL" } )
        
        self.presentViewController(alertController , animated: true, completion: nil)
    }
    
    func displayResultAlert()
    {
        var alertController: UIAlertController
        // Zweiter Pop Up Dialog, der dann den Aktienpreis zeigt
        alertController = UIAlertController(title: "Current Stock Price", message: "TODO", preferredStyle: UIAlertControllerStyle.Alert)
        
        // Fügt den Knopf "Copy" im Pop Up Fenster ein
        let receive = UIAlertAction(title: "Copy", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(receive)
            
        self.presentViewController(alertController , animated: true, completion: nil)
    }
    
    //var markit:IAPI
    //var apiCaller:APICaller

    
    //func getJSON(stockQuote:String) -> String
    //{
    //    markit = MarkitAPI()
    //    apiCaller = APICaller(apiInterface: markit)
    //    return apiCaller.callJSON(stockQuote)
    //}
}
    

