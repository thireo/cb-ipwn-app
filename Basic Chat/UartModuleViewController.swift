//
//  UartModuleViewController.swift
//  Basic Chat
//
//  Created by Trevor Beaton on 12/4/16.
//  Copyright © 2016 Vanguard Logic LLC. All rights reserved.
//





import UIKit
import CoreBluetooth
class UartModuleViewController: UIViewController, CBPeripheralManagerDelegate, UITextViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var RESET: UIButton!
    

    
    @IBAction func handleGesture(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began
        {
            writeValue(data: "MSTRRST 42\n")
        }
    }
    //UI
    @IBOutlet weak var baseTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var switchUI: UISwitch!
    //Data
    var peripheralManager: CBPeripheralManager?
    var peripheral: CBPeripheral!
    private var consoleAsciiText:NSAttributedString? = NSAttributedString(string: "")
    
    
    @IBOutlet weak var SB00: UIButton!
    @IBOutlet weak var SB01: UIButton!
    @IBOutlet weak var SB02: UIButton!
    @IBOutlet weak var SB03: UIButton!
    @IBOutlet weak var SB04: UIButton!
    @IBOutlet weak var SB05: UIButton!
    @IBOutlet weak var SB06: UIButton!
    @IBOutlet weak var SB07: UIButton!
    @IBOutlet weak var SB08: UIButton!
    @IBOutlet weak var SB09: UIButton!
    @IBOutlet weak var SB10: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.SB00.layer.cornerRadius = 10
        self.SB00.clipsToBounds = true
        self.SB01.layer.cornerRadius = 10
        self.SB01.clipsToBounds = true
        self.SB02.layer.cornerRadius = 10
        self.SB02.clipsToBounds = true
        self.SB03.layer.cornerRadius = 10
        self.SB03.clipsToBounds = true
        self.SB04.layer.cornerRadius = 10
        self.SB04.clipsToBounds = true
        self.SB05.layer.cornerRadius = 10
        self.SB05.clipsToBounds = true
        self.SB06.layer.cornerRadius = 10
        self.SB06.clipsToBounds = true
        self.SB07.layer.cornerRadius = 10
        self.SB07.clipsToBounds = true
        self.SB08.layer.cornerRadius = 10
        self.SB08.clipsToBounds = true
        self.SB09.layer.cornerRadius = 10
        self.SB09.clipsToBounds = true
        self.SB10.layer.cornerRadius = 10
        self.SB10.clipsToBounds = true
        
        
        self.RESET.layer.cornerRadius = 20
        self.RESET.clipsToBounds = true
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.plain, target:nil, action:nil)
        self.baseTextView.delegate = self
        //self.inputTextField.delegate = self
        //Base text view setup
        self.baseTextView.layer.borderWidth = 3.0
        self.baseTextView.layer.borderColor = UIColor.black.cgColor//UIColor.blue.cgColor
        self.baseTextView.layer.cornerRadius = 3.0
        self.baseTextView.text = ""
        //Input Text Field setup
        //self.inputTextField.layer.borderWidth = 2.0
        //self.inputTextField.layer.borderColor = UIColor.blue.cgColor
        //self.inputTextField.layer.cornerRadius = 3.0
        //Create and start the peripheral manager
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        //-Notification for updating the text view with incoming text
        updateIncomingData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.baseTextView.text = ""
    }
    @IBAction func OPEN(_ sender: UIButton) {
        writeValue(data: "COV 1\n")
    }
    @IBAction func CLOSE(_ sender: UIButton) {
        writeValue(data: "COV 0\n")
    }
    
    @IBAction func SBReset(_ sender: UIButton) {
        writeValue(data: "SBRST 42\n")
    }
    
    @IBAction func SB00Down(_ sender: UIButton) {
        writeValue(data: "SB00 1\n")
    }
    @IBAction func SB00Up(_ sender: UIButton) {
        writeValue(data: "SB00 0\n")
    }
    @IBAction func SB1(_ sender: UIButton) {
        writeValue(data: "SB01 1\n")
    }
    @IBAction func SB1Up(_ sender: UIButton) {
        writeValue(data: "SB01 0\n")
    }
    @IBAction func SB2Down(_ sender: UIButton) {
        writeValue(data: "SB02 1\n")
    }
    @IBAction func SB2Up(_ sender: UIButton) {
        writeValue(data: "SB02 0\n")
    }
    @IBAction func SB3(_ sender: UIButton) {
        writeValue(data: "SB03 1\n")
    }
    @IBAction func SB3Up(_ sender: UIButton) {
        writeValue(data: "SB03 0\n")
    }
    @IBAction func SB4Down(_ sender: UIButton) {
        writeValue(data: "SB04 1\n")
    }
    @IBAction func SB4Up(_ sender: UIButton) {
        writeValue(data: "SB04 0\n")
    }
    @IBAction func SB5Down(_ sender: UIButton) {
        writeValue(data: "SB05 1\n")
    }
    @IBAction func SB5Up(_ sender: UIButton) {
        writeValue(data: "SB05 0\n")
    }
    @IBAction func SB6Down(_ sender: UIButton) {
        writeValue(data: "SB06 1\n")
    }
    @IBAction func SB6Up(_ sender: UIButton) {
        writeValue(data: "SB06 0\n")
    }
    @IBAction func SB7Down(_ sender: UIButton) {
        writeValue(data: "SB07 1\n")
    }
    @IBAction func SB7Up(_ sender: UIButton) {
        writeValue(data: "SB07 0\n")
    }
    @IBAction func SB8Down(_ sender: UIButton) {
        writeValue(data: "SB08 1\n")
    }
    @IBAction func SB8Up(_ sender: UIButton) {
        writeValue(data: "SB08 0\n")
    }
    @IBAction func SB9Down(_ sender: UIButton) {
        writeValue(data: "SB09 1\n")
    }
    @IBAction func SB9Up(_ sender: UIButton) {
        writeValue(data: "SB09 0\n")
    }
    @IBAction func SB10Down(_ sender: UIButton) {
        writeValue(data: "SB10 1\n")
    }
    @IBAction func SB10Up(_ sender: UIButton) {
        writeValue(data: "SB10 0\n")
    }
    /*@IBAction func RESETUp(_ sender: UIButton) {
        writeValue(data: "MSTRRST 42\n")
    }*/
    
    
    override func viewDidDisappear(_ animated: Bool) {
        // peripheralManager?.stopAdvertising()
        // self.peripheralManager = nil
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    func updateIncomingData () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Notify"), object: nil , queue: nil){
            notification in
            let appendString = "\n"
            let myFont = UIFont(name: "Helvetica Neue", size: 15.0)
            let myAttributes2 = [NSFontAttributeName: myFont!, NSForegroundColorAttributeName: UIColor.red]
            let attribString = NSAttributedString(string: "[RX]: " + (characteristicASCIIValue as String) + appendString, attributes: myAttributes2)
            let newAsciiText = NSMutableAttributedString(attributedString: self.consoleAsciiText!)
            self.baseTextView.attributedText = NSAttributedString(string: characteristicASCIIValue as String , attributes: myAttributes2)
            
            newAsciiText.append(attribString)
            
            self.dataHandler(data: characteristicASCIIValue as String)
            
            self.consoleAsciiText = newAsciiText
            self.baseTextView.attributedText = self.consoleAsciiText
            
            
            
            let range = NSMakeRange(self.baseTextView.text.characters.count - 1, 0)
            self.baseTextView.scrollRangeToVisible(range)
            
        }
    }
    
    func dataHandler(data: String)
    {
        if data.hasPrefix("ERROR") {
            //todo
        }
    }
    
    @IBAction func clickSendAction(_ sender: AnyObject) {
        outgoingData()
        
    }
    
    @IBAction func clickTest1(_ sender: UIButton) {
        let inputText = "FHA0\n"
        writeValue(data: inputText)
    }
    
    @IBOutlet weak var partySwitch: UISwitch!

    @IBOutlet weak var hazardsSwitch: UISwitch!
    @IBAction func toggleHazardsSwitch(_ sender: UISwitch) {
        if hazardsSwitch.isOn {
            writeValue(data: "BKA 1\n")
        }
        else
        {
            writeValue(data: "BKA 0\n")
        }
    }
    
    @IBOutlet weak var lEDBeamSwitch: UISwitch!
    
    @IBAction func toggleLEDBeamSwitch(_ sender: UISwitch) {
        if lEDBeamSwitch.isOn
        {
            writeValue(data: "LED 1\n")
        }
        else
        {
            writeValue(data: "LED 0\n")
        }
    }
    @IBOutlet weak var flashy1Switch: UISwitch!
    @IBAction func toggleFlashy1Switch(_ sender: UISwitch) {
        if flashy1Switch.isOn
        {
            writeValue(data: "FLSH1 1\n")
        }
        else
        {
            writeValue(data: "FLSH1 0\n")
        }
    }
    @IBOutlet weak var flashy2Switch: UISwitch!
    @IBAction func toggleFlashy2Switch(_ sender: UISwitch) {
        if flashy2Switch.isOn
        {
            writeValue(data: "FLSH2 1\n")
        }
        else
        {
            writeValue(data: "FLSH2 0\n")
        }
    }
    @IBOutlet weak var fadeSwitch: UISwitch!
    @IBAction func toggleFadeSwitch(_ sender: UISwitch) {
        if fadeSwitch.isOn
        {
            writeValue(data: "FLSH3 1\n")
            //writeValue(data: "FLSHFD 1\n")
        }
        else
        {
            writeValue(data: "FLSH3 0\n")
            //writeValue(data: "FLSHFD 0\n")
        }
    }
    @IBOutlet weak var BrianSwitch: UISwitch!
    @IBAction func toggleBrianSwitch(_ sender: UISwitch) {
        if BrianSwitch.isOn
        {
            writeValue(data: "BRIAN 1\n")
        }
        else
        {
            writeValue(data: "BRIAN 0\n")
        }
    }
    
    @IBOutlet weak var aLLSwitch: UISwitch!
    @IBAction func toggleALLSwitch(_ sender: UISwitch) {
        if aLLSwitch.isOn
        {
            writeValue(data: "FHA1\n")
        }
        else
        {
            writeValue(data: "FHA0\n")
        }
    }
    
    @IBAction func touchDownAll(_ sender: UIButton) {
        writeValue(data: "FHA1\n")
    }
    
    @IBOutlet weak var headlightSwitch: UISwitch!
    
    @IBAction func toggleHeadlightSwitch(_ sender: UISwitch) {
        if headlightSwitch.isOn {
            writeValue(data: "HDL 1\n")
            //partySwitch.setOn(false, animated: true)
        }
        else
        {
            writeValue(data: "HDL 0\n")
            //partySwitch.setOn(true, animated: true)
        }
    }
    
    @IBAction func togglePartySwitch(_ sender: UISwitch) {
        if partySwitch.isOn {
            writeValue(data: "PRT 1\n")
            //partySwitch.setOn(false, animated: true)
        }
        else
        {
            writeValue(data: "PRT 0\n")
            //partySwitch.setOn(true, animated: true)
        }

    }
    
    func outgoingData () {
        let appendString = "\n"
        
        let inputText = inputTextField.text
        
        let myFont = UIFont(name: "Helvetica Neue", size: 15.0)
        let myAttributes1 = [NSFontAttributeName: myFont!, NSForegroundColorAttributeName: UIColor.blue]
        
        writeValue(data: inputText!)
        
        let attribString = NSAttributedString(string: "[Outgoing]: " + inputText! + appendString, attributes: myAttributes1)
        let newAsciiText = NSMutableAttributedString(attributedString: self.consoleAsciiText!)
        newAsciiText.append(attribString)
        
        consoleAsciiText = newAsciiText
        baseTextView.attributedText = consoleAsciiText
        //erase what's in the text field
        inputTextField.text = ""
        
    }
    
    // Write functions
    func writeValue(data: String){
        print("Tx \(data)")
        self.baseTextView.text.append(data)
        self.baseTextView.scrollRangeToVisible(NSMakeRange(self.baseTextView.text.characters.count - 1, 1))
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        //change the "data" to valueString
        if let blePeripheral = blePeripheral{
            if let txCharacteristic = txCharacteristic {
                blePeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
            }
        }
    }
    
    func writeCharacteristic(val: Int8){
        var val = val
        let ns = NSData(bytes: &val, length: MemoryLayout<Int8>.size)
        blePeripheral!.writeValue(ns as Data, for: txCharacteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
    
    
    //MARK: UITextViewDelegate methods
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView === baseTextView {
            //tapping on consoleview dismisses keyboard
            //inputTextField.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:250), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            return
        }
        print("Peripheral manager is running")
    }
    
    //Check when someone subscribe to our characteristic, start sending the data
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Device subscribe to characteristic")
    }
    
    //This on/off switch sends a value of 1 and 0 to the Arduino
    //This can be used as a switch or any thing you'd like
    @IBAction func switchAction(_ sender: Any) {
        if switchUI.isOn {
            print("On ")
            writeCharacteristic(val: 1)
        }
        else
        {
            print("Off")
            writeCharacteristic(val: 0)
            print(writeCharacteristic)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        outgoingData()
        return(true)
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("\(error)")
            return
        }
    }
}

