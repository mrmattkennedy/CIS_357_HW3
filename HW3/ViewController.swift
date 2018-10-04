//
//  ViewController.swift
//  HW3
//
//  Created by user145690 on 9/23/18.
//  Copyright © 2018 GVSU-357-2018FA. All rights reserved.
//
//@Author(s): Tyler Bruder, Matt Kennedy
//@Version: Fall 2018
//

import UIKit
/*
 *Class that is responsible for seeing what mode is currently in use and small functionality with picking
 *units. Creates references to necessary labels and buttons, and creates actions for the buttons.
 */
class ViewController: UIViewController, UnitConverterViewControllerDelegate {
    var currentMode: String = "Length"
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var firstInput: DecimalMinusTextField!
    @IBOutlet weak var secondInput: DecimalMinusTextField!
    @IBOutlet weak var modeBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var firstUnit: UILabel!
    @IBOutlet weak var secondUnit: UILabel!
    //Decide what mode is currently being used
    @IBAction func modePressed(_ sender: Any) {
        if (currentMode == "Length") {
            currentMode = "Volume"
            firstUnit.text = "Liters"
            secondUnit.text = "Gallons"
        } else {
            currentMode = "Length"
            firstUnit.text = "Meters"
            secondUnit.text = "Yards"
        }
        
    }
    //Reset text field when the clear button is pressed
    @IBAction func clearBtnPressed(_ sender: Any) {
        firstInput.text = ""
        secondInput.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard when tapping outside of text fields.
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }
    //Dismissed keyboard upon the completion of entering data
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    //Calculate units dependant on which is entered as data
    @IBAction func calculateBtnPressed(_ sender: Any) {
        //Check if both first and last are empty
        if ((self.firstInput.text?.isEmpty)! && (self.secondInput.text?.isEmpty)!) {
            return
        } else if (!(self.firstInput.text?.isEmpty)! && (self.secondInput.text == "")) {
            if (currentMode == "Length") {
                var firstConv: LengthUnit = LengthUnit.Meters
                var secondConv: LengthUnit = LengthUnit.Meters
                //converting length
                if (self.firstUnit.text == "Meters") {
                    firstConv = LengthUnit.Meters
                } else if (self.firstUnit.text == "Yards") {
                    firstConv = LengthUnit.Yards
                } else if (self.firstUnit.text == "Miles") {
                    firstConv = LengthUnit.Miles
                }
                
                if (self.secondUnit.text == "Meters") {
                    secondConv = LengthUnit.Meters
                } else if (self.secondUnit.text == "Yards") {
                    secondConv = LengthUnit.Yards
                } else if (self.secondUnit.text == "Miles") {
                    secondConv = LengthUnit.Miles
                }
                
                
                let conv = LengthConversionKey(toUnits: secondConv, fromUnits: firstConv)
                let firstVal = Double(self.firstInput.text!)
                //var debugInfo: String = self.firstUnit.text! + ", " + self.secondUnit.text! + ", " + String(lengthConversionTable[conv]!)
                //debugLabel.text = debugInfo
                
                self.secondInput.text = String(lengthConversionTable[conv]! * firstVal!)
            } else if (currentMode == "Volume") {
                var firstConv: VolumeUnit = VolumeUnit.Liters
                var secondConv: VolumeUnit = VolumeUnit.Liters
                //converting volume
                if (self.firstUnit.text == "Liters") {
                    firstConv = VolumeUnit.Liters
                } else if (self.firstUnit.text == "Gallons") {
                    firstConv = VolumeUnit.Gallons
                } else if (self.firstUnit.text == "Quarts") {
                    firstConv = VolumeUnit.Quarts
                }
                
                if (self.secondUnit.text == "Liters") {
                    secondConv = VolumeUnit.Liters
                } else if (self.secondUnit.text == "Gallons") {
                    secondConv = VolumeUnit.Gallons
                } else if (self.secondUnit.text == "Quarts") {
                    secondConv = VolumeUnit.Quarts
                }
                
                
                let conv = VolumeConversionKey(toUnits: secondConv, fromUnits: firstConv)
                let firstVal = Double(self.firstInput.text!)
                self.secondInput.text = String(volumeConversionTable[conv]! * firstVal!)
            }
        } else if (!(self.secondInput.text?.isEmpty)! && (self.firstInput.text == "")) {
            if (currentMode == "Length") {
                var firstConv: LengthUnit = LengthUnit.Meters
                var secondConv: LengthUnit = LengthUnit.Meters
                
                if (self.firstUnit.text == "Meters") {
                    firstConv = LengthUnit.Meters
                } else if (self.firstUnit.text == "Yards") {
                    firstConv = LengthUnit.Yards
                } else if (self.firstUnit.text == "Miles") {
                    firstConv = LengthUnit.Miles
                }
                
                if (self.secondUnit.text == "Meters") {
                    secondConv = LengthUnit.Meters
                } else if (self.secondUnit.text == "Yards") {
                    secondConv = LengthUnit.Yards
                } else if (self.secondUnit.text == "Miles") {
                    secondConv = LengthUnit.Miles
                }
                
                
                let conv = LengthConversionKey(toUnits: firstConv, fromUnits: secondConv)
                let firstVal = Double(self.secondInput.text!)
                //var debugInfo: String = self.firstUnit.text! + ", " + self.secondUnit.text! + ", " + String(lengthConversionTable[conv]!)
                //debugLabel.text = debugInfo
                
                self.firstInput.text = String(lengthConversionTable[conv]! * firstVal!)
            } else if (currentMode == "Volume") {
                var firstConv: VolumeUnit = VolumeUnit.Liters
                var secondConv: VolumeUnit = VolumeUnit.Liters
                
                if (self.firstUnit.text == "Liters") {
                    firstConv = VolumeUnit.Liters
                } else if (self.firstUnit.text == "Gallons") {
                    firstConv = VolumeUnit.Gallons
                } else if (self.firstUnit.text == "Quarts") {
                    firstConv = VolumeUnit.Quarts
                }
                
                if (self.secondUnit.text == "Liters") {
                    secondConv = VolumeUnit.Liters
                } else if (self.secondUnit.text == "Gallons") {
                    secondConv = VolumeUnit.Gallons
                } else if (self.secondUnit.text == "Quarts") {
                    secondConv = VolumeUnit.Quarts
                }
                
                
                let conv = VolumeConversionKey(toUnits: firstConv, fromUnits: secondConv)
                let firstVal = Double(self.secondInput.text!)
                self.firstInput.text = String(volumeConversionTable[conv]! * firstVal!)
            }
        } else {
            firstInput.text = ""
            secondInput.text = ""
            return
        }
        dismissKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Used for the UnitConverterViewController. Delegate in that class accesses this function to check what view is currently in use. */
    func getCurrentMode() -> String {
        return currentMode
    }
    
    /* Called from delegate in UnitConverterViewController. Sets the current units to convert to/from. */
    func indicateSelection(fromSelection: String, toSelection: String) {
        firstUnit.text = fromSelection
        secondUnit.text = toSelection
    }
    
    /* Works for the segue. Sets self as the delegate for the destination. */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UnitConverterViewController {
            dest.delegate = self
        }
    }
}
