//
//  DetailCompositionView.swift
//  Phosition
//
//  Created by Dimas Pramudya Satria H on 09/06/21.
//

import UIKit

class DetailCompositionView: UIView {
    
    @IBOutlet weak var detailCompositionTableView: UITableView!
    
    func setup() {
        print("View Linked")
        
        detailCompositionTableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
        
        let anib = UINib(nibName: "\(DescriptionTableViewCell.self)", bundle: nil)
        detailCompositionTableView.register(anib, forCellReuseIdentifier: "descriptionTableViewCell")
        
        let bnib = UINib(nibName: "\(InstructionTableViewCell.self)", bundle: nil)
        detailCompositionTableView.register(bnib, forCellReuseIdentifier: "instructionTableViewCell")
    }
    
}


//MARK: -Custom Button Inside Table View Cell
class MyCell: UITableViewCell {
    
    var buttonTapCallback: () -> ()  = { }
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Practice", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.1160918847, green: 0.3141029179, blue: 0.578050971, alpha: 1)
     
        btn.layer.cornerRadius = 4
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return btn
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .systemPink
        return lbl
    }()
    
    @objc func didTapButton() {
        buttonTapCallback()
        print("Button is Clicked")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Add button
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        //Set constraints as per your requirements
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Add label
        contentView.addSubview(label)
        //Set constraints as per your requirements
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
