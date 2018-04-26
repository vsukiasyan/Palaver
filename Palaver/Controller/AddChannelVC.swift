//
//  AddChannelVc.swift
//  Palaver
//
//  Created by Vic Sukiasyan on 4/25/18.
//  Copyright © 2018 Vic Sukiasyan. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }

  
    @IBAction func closeModalPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else { return }
        guard let channelDesc = chanDesc.text else { return }
        
        
        
        AuthService.instance.createChannel(name: channelName, description: channelDesc, completion: { (success) in
            if success {
                print("Channel added.")
                
            } else {
                print("Didn't work.")
            }
        })
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NOTIF_UPDATE_TABLE, object: nil)
        
//        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
//            if success {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
        
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
        chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
