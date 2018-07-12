//
//  VerificationTextField.swift
//  GoFixCustomer
//
//  Created by hieu nguyen on 7/12/18.
//  Copyright © 2018 gofix.vinova.sg. All rights reserved.
//

import UIKit

protocol VerificationTextFieldDelegate: class {
    func textFieldDidDelete(in textField: VerificationTextField)
}

class VerificationTextField: UITextField {

    @IBInspectable var radius: CGFloat = 5.0
    
    weak var handleKeyboardDelegate: VerificationTextFieldDelegate?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.cornerRadius = radius
        layer.masksToBounds = true
        tintColor = .clear
        textAlignment = .center
        keyboardType = .numberPad
        font = UIFont.systemFont(ofSize: 16.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        
        handleKeyboardDelegate?.textFieldDidDelete(in: self)
    }

}
