//
//  RoundedButton.swift
//  Palaver
//
//  Created by Vic Sukiasyan on 4/23/18.
//  Copyright © 2018 Vic Sukiasyan. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
}
