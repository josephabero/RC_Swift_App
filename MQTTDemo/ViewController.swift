//
//  ViewController.swift
//  MQTTDemo
//
//  Created by user on 9/25/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import CocoaMQTT


class ViewController: UIViewController {
    
    var start = true
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.20.10.10", port: 1883)
    
//    var dCyc = 50
//    let freq = 1000
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var connectStatusLabel: UILabel!
    
    @IBOutlet weak var manualControlButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Connecting...")
        
        if(start){
            mqttClient.connect()
            start = false
        }
        
        connectStatusLabel.font = connectStatusLabel.font.withSize(20)
        
        disableControlButtons()
        
        manualControlButton.layer.cornerRadius = 10
        manualControlButton.adjustsImageWhenHighlighted = false
        manualControlButton.isSelected = true
        manualControlButton.backgroundColor = UIColor.blue
        manualControlButton.setTitleColor(UIColor.white, for: .normal)
        manualControlButton.setTitle("Autonomous Control", for: .normal)
        
//        let image = UIImage(named: "up_arrow.png")
//
//        forwardButton.setImage(image, for: .normal)
//        forwardButton.backgroundColor = UIColor.gray
        forwardButton.layer.cornerRadius = 10
        forwardButton.setTitle("↑", for: .normal)
        forwardButton.titleLabel?.font =  forwardButton.titleLabel?.font.withSize(30)
        
        
        rightButton.layer.cornerRadius = 10
        rightButton.setTitle("→", for: .normal)
        rightButton.titleLabel?.font = rightButton.titleLabel?.font.withSize(30)
        
        
        leftButton.layer.cornerRadius = 10
        leftButton.setTitle("←", for: .normal)
        leftButton.titleLabel?.font = leftButton.titleLabel?.font.withSize(30)
        
        
        stopButton.layer.cornerRadius = 10
        
        backButton.layer.cornerRadius = 10
        backButton.setTitle("↓", for: .normal)
        backButton.titleLabel?.font = backButton.titleLabel?.font.withSize(30)
        
        titleLabel.font = titleLabel.font.withSize(30)
        
        let mTapGesture = UITapGestureRecognizer(target: self, action: #selector (manualTap))
        manualControlButton.addGestureRecognizer(mTapGesture)
        
       let rTapGesture = UITapGestureRecognizer(target: self, action: #selector (rightTap))
//        let rLongGesture = UILongPressGestureRecognizer(target: self, action: #selector (rightLong))
//        rTapGesture.numberOfTapsRequired = 1
      rightButton.addGestureRecognizer(rTapGesture)
//        rightButton.addGestureRecognizer(rLongGesture)
//
       let bTapGesture = UITapGestureRecognizer(target: self, action: #selector (backTap))
//        let bLongGesture = UILongPressGestureRecognizer(target: self, action: #selector (backLong))
//        bTapGesture.numberOfTapsRequired = 1
      backButton.addGestureRecognizer(bTapGesture)
//        backButton.addGestureRecognizer(bLongGesture)
//
       let lTapGesture = UITapGestureRecognizer(target: self, action: #selector (leftTap))
//        let lLongGesture = UILongPressGestureRecognizer(target: self, action: #selector (leftLong))
//        lTapGesture.numberOfTapsRequired = 1
      leftButton.addGestureRecognizer(lTapGesture)
//        leftButton.addGestureRecognizer(lLongGesture)
//
       let fTapGesture = UITapGestureRecognizer(target: self, action: #selector (forwardTap))
//        let fLongGesture = UILongPressGestureRecognizer(target: self, action: #selector (forwardLong))
//        fTapGesture.numberOfTapsRequired = 1
       forwardButton.addGestureRecognizer(fTapGesture)
//        forwardButton.addGestureRecognizer(fLongGesture)
//
        let sTapGesture = UITapGestureRecognizer(target: self, action: #selector (stopTap))
//        let sLongGesture = UILongPressGestureRecognizer(target: self, action: #selector (stopLong))
//        sTapGesture.numberOfTapsRequired = 1
      stopButton.addGestureRecognizer(sTapGesture)
//        stopButton.addGestureRecognizer(sLongGesture)
    }

//    @IBAction func gpioSwitch(_ sender: UISwitch) {
//        if sender.isOn {
//            mqttClient.publish(" ", withString: "on")
//        }
//        else {
//            mqttClient.publish("rpi/gpio", withString: "off")
//        }
//    }
    
    @objc func manualTap() {
        print("mTap")
        manualControlButton.isSelected = !manualControlButton.isSelected
        
             if manualControlButton.isSelected {
                print("manual")
                manualControlButton.backgroundColor = UIColor.white
                manualControlButton.setTitleColor(UIColor.black, for: .normal)
                manualControlButton.setTitle("Manual Control", for: .normal)
                
                enableControlButtons()
                mqttClient.publish("rpi/gpio", withString: "button: manual")
             }
             else {
                print("auto")
                manualControlButton.backgroundColor = UIColor.blue
                manualControlButton.setTitleColor(UIColor.white, for: .normal)
                manualControlButton.setTitle("Autonomous Control", for: .normal)
                
                disableControlButtons()
                mqttClient.publish("rpi/gpio", withString: "button: auto")
             }
    }
    

    @objc func rightTap() {
        print("rTap")
        mqttClient.publish("rpi/gpio", withString: "button: rButton")
    }
    
    @objc func rightLong() {
        print("rLong")
    }
    
    @objc func backTap() {
        print("bTap")
        mqttClient.publish("rpi/gpio", withString: "button: bButton")
    }
    
    @objc func backLong() {
        print("bLong")
    }
    
    @objc func leftTap() {
        print("lTap")
        mqttClient.publish("rpi/gpio", withString: "button: lButton")
    }
    
    @objc func leftLong() {
        print("lLong")
        mqttClient.publish("rpi/gpio", withString: "button: leftLong")
    }
    
    @objc func forwardTap() {
        print("fTap")
        mqttClient.publish("rpi/gpio", withString: "button: fButton")
    }
    
    @objc func forwardLong() {
        print("fLong")
    }
    
    @objc func stopTap() {
        print("sTap")
        mqttClient.publish("rpi/gpio", withString: "button: sButton")
    }
    
    @objc func stopLong() {
        print("sLong")
    }
    
    
    func disableControlButtons()
    {
        forwardButton.isEnabled = false
        rightButton.isEnabled = false
        leftButton.isEnabled = false
        stopButton.isEnabled = false
        backButton.isEnabled = false
        
        forwardButton.backgroundColor = UIColor.gray
        rightButton.backgroundColor = UIColor.gray
        leftButton.backgroundColor = UIColor.gray
        stopButton.backgroundColor = UIColor.gray
        backButton.backgroundColor = UIColor.gray
    }
    
    func enableControlButtons()
    {
        forwardButton.isEnabled = true
        rightButton.isEnabled = true
        leftButton.isEnabled = true
        stopButton.isEnabled = true
        backButton.isEnabled = true
        
        forwardButton.backgroundColor = UIColor.blue
        rightButton.backgroundColor = UIColor.blue
        leftButton.backgroundColor = UIColor.blue
        stopButton.backgroundColor = UIColor.red
        backButton.backgroundColor = UIColor.blue
    }
    
    // @objc func rightTap() {
    //     print("rTap")
    //     rightButton.isSelected = !rightButton.isSelected
        
    //     if rightButton.isSelected {
    //         dCyc = dCyc + 2
    //         print("rightOn: \(dCyc)")
    //         mqttClient.publish("rpi/gpio", withString: "button: rightOn")
    //     }
    //     else {
    //         dCyc = dCyc - 1
    //         print("rightOff: \(dCyc)")
    //         mqttClient.publish("rpi/gpio", withString: "button: rightOff")
    //     }
    // }
    
    // @objc func rightLong() {
    //     print("rLong")
    // }
    
    // @objc func backTap() {
    //     print("bTap")
        
    //     backButton.isSelected = !backButton.isSelected
        
    //     if backButton.isSelected {
    //         print("backOn")
    //         mqttClient.publish("rpi/gpio", withString: "button: backOn")
    //     }
    //     else {
    //         print("forwardOff")
    //         mqttClient.publish("rpi/gpio", withString: "button: backOff")
    //     }
    // }
    
    // @objc func backLong() {
    //     print("bLong")
    // }
    
    // @objc func leftTap() {
    //     print("lTap")
        
    //     leftButton.isSelected = !leftButton.isSelected
        
    //     if leftButton.isSelected {
    //         print("leftOn")
    //         dCyc = dCyc + 1
    //         mqttClient.publish("rpi/gpio", withString: "button: leftOn")
    //     }
    //     else {
    //         print("leftOff")
    //         dCyc = 0
    //         mqttClient.publish("rpi/gpio", withString: "button: leftOff")
    //     }
    // }
    
    // @objc func leftLong() {
    //     print("lLong")
    //     mqttClient.publish("rpi/gpio", withString: "button: leftLong")
    // }
    
    // @objc func forwardTap() {
    //     print("fTap")
    //     forwardButton.isSelected = !forwardButton.isSelected
        
    //     if forwardButton.isSelected {
    //         print("forwardOn")
    //         mqttClient.publish("rpi/gpio", withString: "button: forwardOn")
    //     }
    //     else {
    //         print("forwardOff")
    //         mqttClient.publish("rpi/gpio", withString: "button: forwardOff")
    //     }
    // }
    
    // @objc func forwardLong() {
    //     print("fLong")
    // }
    
    // @objc func stopTap() {
    //     print("sTap")
    //     stopButton.isSelected = !stopButton.isSelected
        
    //     if stopButton.isSelected {
    //         print("stopOn")
    //         mqttClient.publish("rpi/gpio", withString: "button: stopOn")
    //     }
    //     else {
    //         print("stopOff")
    //         mqttClient.publish("rpi/gpio", withString: "button: stopOff")
    //     }
    // }
    
    // @objc func stopLong() {
    //     print("sLong")
    // }
    
//    @IBAction func forwardAction(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        print("forward: ", sender.isSelected)
//
//        if sender.isSelected {
//           print("forwardOn")
//           mqttClient.publish("rpi/gpio", withString: "forwardOn")
//        }
//        else {
//           print("forwardOff")
//           mqttClient.publish("rpi/gpio", withString: "forwardOff")
//        }
//    }
    
    
//    @IBAction func rightButton(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        print("right: ", sender.isSelected)
//
//        if sender.isSelected {
//            print("rightOn")
//            mqttClient.publish("rpi/gpio", withString: "rightOn")
//        }
//        else {
//            print("rightOff")
//            mqttClient.publish("rpi/gpio", withString: "rightOff")
//        }
//    }
//
//    @IBAction func backButton(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        print("back: ", sender.isSelected)
//
//        if sender.isSelected {
//            print("backOn")
//            mqttClient.publish("rpi/gpio", withString: "backOn")
//        }
//        else {
//            print("backOff")
//            mqttClient.publish("rpi/gpio", withString: "backOff")
//        }
//    }
//
//    @IBAction func leftButton(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        print("left: ", sender.isSelected)
//
//        if sender.isSelected {
//            print("leftOn")
//            mqttClient.publish("rpi/gpio", withString: "leftOn")
//        }
//        else {
//            print("leftOff")
//            mqttClient.publish("rpi/gpio", withString: "leftOff")
//        }
//    }
    
//    @IBAction func connectButton(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//
//        if sender.isSelected {
//            mqttClient.connect()
//            sender.setTitle("Disconnect", for: .normal)
//        }
//        else {
//            // mqttClient.disconnect()
//            sender.setTitle("Connect", for: .normal)
//        }
//    }
    
//    @IBAction func disconnectButton(_ sender: UIButton) {
//        mqttClient.disconnect()
//    }
}
