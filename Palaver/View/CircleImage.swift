//
//  CircleImage.swift
//  Palaver
//
//  Created by Vic Sukiasyan on 4/24/18.
//  Copyright © 2018 Vic Sukiasyan. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
  
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}
