//
//  StatisticsViewController.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    //Depencies
    private let model: IStatisticsVCModel
    private let presentationAssembly: IPresentationAssembly
    
    
    //view
    private let statView = StatisticsView()
    
    // MARK: - Init
    
    init(model: IStatisticsVCModel, assembly: IPresentationAssembly) {
        self.model = model
        self.presentationAssembly = assembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = statView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
