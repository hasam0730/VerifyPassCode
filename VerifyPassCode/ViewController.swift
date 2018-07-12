//
//  ViewController.swift
//  VerifyPassCode
//
//  Created by Developer on 7/12/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var stackViewCodeTxt: UIStackView!
	var currChar: String?
	var currTxtIndex: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		stackViewCodeTxt.arrangedSubviews.forEach {
			($0 as! VerificationTextField).delegate = self
			($0 as! VerificationTextField).handleKeyboardDelegate = self
		}
		let v = UIView(frame: stackViewCodeTxt.bounds)
		v.backgroundColor = .clear
		stackViewCodeTxt.addSubview(v)
		
		guard let firstTxtField = stackViewCodeTxt.arrangedSubviews.first else { return }
		firstTxtField.becomeFirstResponder()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

extension ViewController: UITextFieldDelegate, VerificationTextFieldDelegate {
	func textFieldDidDelete(in textField: VerificationTextField) {
		clearTextField(tfIndex: textField.tag-1)
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let previousString = textField.text!
		let txtTag = textField.tag
		let typingString = string
		
		if typingString.count > 0 && previousString.count == 0 {
			fillTextField(text: typingString, tfIndex: txtTag)
		} else if previousString.count > 0 {
			fillTextField(text: typingString, tfIndex: txtTag+1)
		}
		
		if typingString.count == 0 {
			clearTextField(tfIndex: txtTag)
		}
		
		return false
	}
	
	func fillTextField(text: String, tfIndex: Int) {
		if tfIndex > stackViewCodeTxt.arrangedSubviews.count {
			return
		}
		var tf = view.viewWithTag(tfIndex) as! VerificationTextField
		tf.text = text
		
		if tfIndex == stackViewCodeTxt.arrangedSubviews.count { return }
		tf = view.viewWithTag(tfIndex+1) as! VerificationTextField
		tf.becomeFirstResponder()
	}
	
	func clearTextField(tfIndex: Int) {
		if tfIndex == 0 { return }
		var tf = view.viewWithTag(tfIndex) as! VerificationTextField
		tf.text = ""
		
		if tfIndex == 1 {
			tf = view.viewWithTag(1) as! VerificationTextField
			tf.becomeFirstResponder()
			return
		}
		tf = view.viewWithTag(tfIndex-1) as! VerificationTextField
		tf.becomeFirstResponder()
	}
}
