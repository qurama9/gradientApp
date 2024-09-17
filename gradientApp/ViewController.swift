//
//  ViewController.swift
//  gradientApp
//
//  Created by Рамазан Абайдулла on 24.05.2024.
//

import UIKit

class ViewController: UIViewController {

    private lazy var viewManager: ViewManager = {
        
        return ViewManager(controller: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#464C75FF")
        viewManager.createAppHeader(title: "Заглавный текст \nв меню")
        viewManager.createCards()
        viewManager.createService()
    }


}

