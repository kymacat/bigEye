//
//  GroupViewController.swift
//  Big eye
//
//  Created by Const. on 30.06.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    //Depencies
    private let model: IGroupVCModel
    private let presentationAssembly: IPresentationAssembly
    
    // MARK: - Init
    
    init(model: IGroupVCModel, assembly: IPresentationAssembly) {
        self.model = model
        self.presentationAssembly = assembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
