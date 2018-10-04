//
//  UnitConverterViewController.swift
//  HW3
//
//  Created by CIS Student on 9/23/18.
//  Copyright © 2018 GVSU-357-2018FA. All rights reserved.
//
//  @Author(s): Tyler Bruder, Matt Kennedy
//  @Version: Fall 2018

import UIKit
//Delegate that converts the units and hand them off to be stored / represented in the program
protocol UnitConverterViewControllerDelegate {
    func indicateSelection(fromSelection: String, toSelection: String)
    func getCurrentMode() -> String
}
/*
 *Class that contains contents of the app such as pickers, labels, etc and populates fields with proper
 *unit measurments
 */
class UnitConverterViewController: UIViewController {
    
    var pickerData: [String] = [String]()
    var selection: String = ""
    var delegate: UnitConverterViewControllerDelegate?
    
    @IBOutlet weak var UnitPicker: UIPickerView!
    @IBOutlet weak var From_Label: UILabel!
    @IBOutlet weak var To_Label: UILabel!
    @IBOutlet var pickerScreen: UIView!
    //check if value was entered or selected, and if so leave picker option
    override func viewDidLoad() {
        super.viewDidLoad()
        UnitPicker.isHidden = true
        self.UnitPicker.delegate = self
        self.UnitPicker.dataSource = self
        
        //Determining what measurements place when converting
        var mode: String = ""
        if let del = self.delegate {
            mode = del.getCurrentMode()
            if (mode == "Length") {
                for item in LengthUnit.allCases {
                    self.pickerData.append(item.rawValue)
                }
                From_Label.text = "Meters"
                To_Label.text = "Yards"
            } else if (mode == "Volume") {
                for item in VolumeUnit.allCases {
                    self.pickerData.append(item.rawValue)
                }
                From_Label.text = "Liters"
                To_Label.text = "Gallons"
            }
        }
        
        //Checking for screentaps that will represent different actions based on where the tap occured
        let fromOptionSelect = UITapGestureRecognizer(target: self, action: #selector(UnitConverterViewController.fromSelect))
        From_Label.isUserInteractionEnabled = true
        From_Label.addGestureRecognizer(fromOptionSelect)
        
        let toOptionSelect = UITapGestureRecognizer(target: self, action: #selector(UnitConverterViewController.toSelect))
        To_Label.isUserInteractionEnabled = true
        To_Label.addGestureRecognizer(toOptionSelect)
        
        let screentap = UITapGestureRecognizer(target: self, action: #selector(UnitConverterViewController.tapOffPicker))
        pickerScreen.addGestureRecognizer(screentap)
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* This will set the from_label text to empty, which will be useful when we tap off of a picker.
    * When we tap off the picker, the selection will be assigned to the empty label. */
    @objc func fromSelect(sender:UITapGestureRecognizer){
        From_Label.text = ""
        UnitPicker.isHidden = false
    }
    
    /* This will set the from_label text to empty, which will be useful when we tap off of a picker.
     * When we tap off the picker, the selection will be assigned to the empty label. */
    @objc func toSelect(sender:UITapGestureRecognizer){
        To_Label.text = ""
        UnitPicker.isHidden = false
    }
    
    /*Selected answer is being stored in the program depending on which label blanks.
 * Couldn't figure out how to check the label if the user presses from one to the other, so instead, if either label is blank, just go to default values. */
    @objc
    func tapOffPicker(sender:UITapGestureRecognizer){
        if(From_Label.text == ""){
            From_Label.text = selection
        }
        else if(To_Label.text == ""){
            To_Label.text = selection
        }
        UnitPicker.isHidden = true
    }
    //if a measurement is given, have the view change to enforce a 'calculate' out of the user
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let del = self.delegate {
            var fromUnit: String = From_Label.text!
            var toUnit: String = To_Label.text!
            var mode: String = del.getCurrentMode()
            
            if (fromUnit == "" || toUnit == "") {
                if (mode == "Length") {
                    fromUnit = "Meters"
                    toUnit = "Yards"
                } else {
                    fromUnit = "Liters"
                    toUnit = "Gallons"
                }
            }
            del.indicateSelection(fromSelection: fromUnit, toSelection: toUnit)
        }
    }
}

extension UnitConverterViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selection = self.pickerData[row]
    }
}
