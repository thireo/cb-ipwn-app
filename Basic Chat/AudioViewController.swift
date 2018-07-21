//
//  AudioViewController.swift
//  Basic Chat
//
//  Created by Andreas Thirsbro on 09/07/2018.
//  Copyright © 2018 Vanguard Logic LLC. All rights reserved.
//

import UIKit
import CoreBluetooth

class AudioViewController: UIViewController, CBPeripheralManagerDelegate, UITextViewDelegate, UITextFieldDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        //
    }
    

    @IBOutlet weak var bandOne: UISlider!
    @IBOutlet weak var bandTwo: UISlider!
    @IBOutlet weak var bandThree: UISlider!
    @IBOutlet weak var bandFour: UISlider!
    @IBOutlet weak var bandFive: UISlider!
    @IBOutlet weak var bandSix: UISlider!
    @IBOutlet weak var bandSeven: UISlider!
    
    var peripheralManager: CBPeripheralManager?
    var peripheral: CBPeripheral!
    
    
    var bandOneValue: Int!
    var bandTwoValue: Int!
    var bandThreeValue: Int!
    var bandFourValue: Int!
    var bandFiveValue: Int!
    var bandSixValue: Int!
    var bandSevenValue: Int!
    
    @IBOutlet weak var bandOneText: UITextField!
    @IBOutlet weak var bandTwoText: UITextField!
    @IBOutlet weak var bandThreeText: UITextField!
    @IBOutlet weak var bandFourText: UITextField!
    @IBOutlet weak var bandFiveText: UITextField!
    @IBOutlet weak var bandSixText: UITextField!
    @IBOutlet weak var bandSevenText: UITextField!
    
    @IBAction func bandOneChanged(_ sender: UISlider) {
        self.bandOneText.text = "63Hz: \(Int(sender.value))"
        bandOneValue = Int(sender.value)
        //var uartModuleViewController = UartModuleViewController();
        //uartModuleViewController.writeValue(data: "PRTTRSH0 \(currentValue)")
    }
    @IBAction func bandTwoChanged(_ sender: UISlider) {
        self.bandTwoText.text = "160Hz: \(Int(sender.value))"
        bandTwoValue = Int(sender.value)
    }
    @IBAction func bandThreeChanged(_ sender: UISlider) {
        self.bandThreeText.text = "400Hz: \(Int(sender.value))"
        bandThreeValue = Int(sender.value)
    }
    @IBAction func bandFourChanged(_ sender: UISlider) {
        self.bandFourText.text = "1kHz: \(Int(sender.value))"
        bandFourValue = Int(sender.value)
    }
    @IBAction func bandFiveChanged(_ sender: UISlider) {
        self.bandFiveText.text = "2.5Hz: \(Int(sender.value))"
        bandFiveValue = Int(sender.value)
    }
    @IBAction func bandSixValue(_ sender: UISlider) {
        self.bandSixText.text = "6kHz: \(Int(sender.value))"
        bandSixValue = Int(sender.value)
    }
    @IBAction func bandSevenChanged(_ sender: UISlider) {
        self.bandSevenText.text = "16kHz: \(Int(sender.value))"
        bandSevenValue = Int(sender.value)
    }

    @IBAction func saveButton(_ sender: Any) {
       writeValue(data: "PRTTRSH0 \(bandOneValue!)\n")
        writeValue(data: "PRTTRSH1 \(bandTwoValue!)\n")
        writeValue(data: "PRTTRSH2 \(bandThreeValue!)\n")
        writeValue(data: "PRTTRSH3 \(bandFourValue!)\n")
        writeValue(data: "PRTTRSH4 \(bandFiveValue!)\n")
        writeValue(data: "PRTTRSH5 \(bandSixValue!)\n")
        writeValue(data: "PRTTRSH6 \(bandSevenValue!)\n")
    }

    @IBAction func Party6Down(_ sender: UIButton) {
        writeValue(data: "PRTRV21 6")
    }
    @IBAction func Party5Down(_ sender: UIButton) {
        writeValue(data: "PRTRV21 5")
    }
    @IBAction func Party4Down(_ sender: UIButton) {
        writeValue(data: "PRTRV21 4")
    }
    @IBAction func Party3Down(_ sender: UIButton) {
        writeValue(data: "PRTRV21 3")
    }
    @IBAction func Party2Down(_ sender: UIButton) {
        writeValue(data: "PRTRV21 2")
    }
    @IBAction func Party1Down(_ sender: UIButton) {
        writeValue(data: "PRTRV21 1")
    }
    @IBAction func Party0Down(_ sender: UIButton) {
        writeValue(data: "PRTRV21 0")
    }
    @IBAction func Party0Up(_ sender: UIButton) {
        writeValue(data: "PRTRV20")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        bandOneValue = 1500
        bandTwoValue = 1550
        bandThreeValue = 1400
        bandFourValue = 2500
        bandFiveValue = 3000
        bandSixValue = 2000
        bandSevenValue = 2375
        
        bandOne.setValue(Float(bandOneValue), animated: false)
        bandTwo.setValue(Float(bandTwoValue), animated: false)
        bandThree.setValue(Float(bandThreeValue), animated: false)
        bandFour.setValue(Float(bandFourValue), animated: false)
        bandFive.setValue(Float(bandFiveValue), animated: false)
        bandSix.setValue(Float(bandSixValue), animated: false)
        bandSeven.setValue(Float(bandSevenValue), animated: false)
        
        self.bandOneText.text = "63Hz: \(Int(bandOneValue))"
        self.bandTwoText.text = "160Hz: \(Int(bandTwoValue))"
        self.bandThreeText.text = "400Hz: \(Int(bandThreeValue))"
        self.bandFourText.text = "1kHz: \(Int(bandFourValue))"
        self.bandFiveText.text = "2.5kHz: \(Int(bandFiveValue))"
        self.bandSixText.text = "6kHz: \(Int(bandSixValue))"
        self.bandSevenText.text = "16kHz: \(Int(bandSevenValue))"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func writeValue(data: String){
        print("Tx \(data)")
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        //change the "data" to valueString
        if let blePeripheral = blePeripheral{
            if let txCharacteristic = txCharacteristic {
                blePeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
