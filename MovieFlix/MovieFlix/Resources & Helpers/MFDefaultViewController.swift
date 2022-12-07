//
//  MFDefaultViewController.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 07/12/22.
//

import UIKit

class MFDefaultViewController: UIViewController {

    var toolBar : UIToolbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpKeyboardUI()
    }
    
    func setUpKeyboardUI(){
       
        //Adding toolbar above keyboard
        self.toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let DoneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: target,
                                         action: #selector(tapDone))
        self.toolBar?.setItems([flexibleSpace, DoneButton], animated: false)
        
    }
    
    //Toolbar done button action
    @objc func tapDone() {
       self.view.endEditing(true)
     }

}
