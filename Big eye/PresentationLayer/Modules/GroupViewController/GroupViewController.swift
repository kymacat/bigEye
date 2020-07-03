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
    
    //view
    private let groupView = GroupVCView()
    
    var data: [GroupMemberCellModel] = [
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Влад", lastName: "Яндола", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Гена", lastName: "Горин", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Василий", lastName: "Пупкин", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Иван", lastName: "Иванов", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Владимир", lastName: "Путин", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Наталия", lastName: "Коновалова", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Слава", lastName: "Корнев", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Дарья", lastName: "Гулиева", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Матвей", lastName: "Потапов", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Дмитрий", lastName: "Медведев", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Марина", lastName: "Тищенко", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Петр", lastName: "Петров", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Аслан", lastName: "Намазов", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Астан", lastName: "Тедеев", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Ибрагим", lastName: "Абдулаев", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Денис", lastName: "Шолохов", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Никита", lastName: "Бондаренко", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Сергей", lastName: "Стецков", description: ""),
        GroupMemberCellModel(image: UIImage(named: "placeholder"), firstName: "Леонид", lastName: "Лихачев", description: "")
    ]
    
    // MARK: - Init
    
    init(model: IGroupVCModel, assembly: IPresentationAssembly) {
        self.model = model
        self.presentationAssembly = assembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = groupView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupView.collectionView.dataSource = self
        groupView.collectionView.delegate = self
        groupView.collectionView.register(GroupMemberCell.self, forCellWithReuseIdentifier: "memberCell")
        groupView.collectionView.register(AddMemberCell.self, forCellWithReuseIdentifier: "addCell")
        
        groupView.addMemberView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: - Keyboard show/hide
    
    @objc func keyboardWasShown() {
        groupView.setConstraintsWithKeyboard()
    }
    
    @objc func keyboardWillBeHidden() {
        groupView.setConstraintsWithoutKeyboard()
    }
    
}

// MARK: - CollectionView DataSource

extension GroupViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == data.count {
            guard let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as? AddMemberCell else {return UICollectionViewCell()}
            
            return addCell
        }
        
        guard let memberCell = collectionView.dequeueReusableCell(withReuseIdentifier: "memberCell", for: indexPath) as? GroupMemberCell else {return UICollectionViewCell()}
        
        let model = data[indexPath.row]
        memberCell.configure(with: model)
        
        return memberCell
    }
    
}

// MARK: - CollectionView Delegate

extension GroupViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GroupMemberCell {
            cell.didSelect()
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AddMemberCell {
            cell.didSelect()
            groupView.showAddMemberView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GroupMemberCell {
            cell.didHighlight()
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AddMemberCell {
            cell.didHighlight()
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GroupMemberCell {
            cell.didUnhighlight()
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AddMemberCell {
            cell.didUnhighlight()
        }
    }
}

// MARK: - CollectionView Layout

extension GroupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 15, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }
}

// MARK: - Add member delegate

extension GroupViewController: AddMemberDelegate {
    func addMember(firstName: String, lastName: String, description: String?, image: UIImage?) {
        let person = GroupMemberCellModel(image: image, firstName: firstName, lastName: lastName, description: description)
        
        self.model.savePerson(person: person)
        data.append(person)
        
        groupView.collectionView.reloadData()
        
    }
}

