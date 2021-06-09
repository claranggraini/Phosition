//
//  DetailCompositionController.swift
//  Phosition
//
//  Created by Clara Anggraini on 07/06/21.
//

import UIKit

class DetailCompositionController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var detailCompositionTableView: UITableView!

    
    let compositions = Database.shared.getCompositions()
    
    
    // MARK: -Dummy Data
    var selectedRule = [
        DetailComposition(compositionName: .ruleOfThird, compositionDescription: "The rule of thirds is an essential photography technique. It can be applied to any subject to improve the composition and balance of your images.   The rule of thirds is a compositional guideline that breaks an image down into thirds (both horizontally and vertically) so you have nine pieces and four gridlines.   The rule of thirds also identifies four power points at the center of each gridline intersection.")
    ]
    
    var ruleOfThirdInstruction = [
        CompositionInstruction(instructionNo: .step1, instructionDescription: "Choose an object that you want to take a picture of."),
        CompositionInstruction(instructionNo: .step2, instructionDescription: "Place the object at the center of the camera view."),
        CompositionInstruction(instructionNo: .step3, instructionDescription: "Move the camera horizontally to left or right, so the object will be on a third left or third right in the camera view."),
        CompositionInstruction(instructionNo: .step4, instructionDescription: "Adjust the horizontal view lower or higher if needed, so the object will be on a third higher or a third lower in the camera view.")
    ]
    
    //MARK: -ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCompositionTableView.dataSource = self
        detailCompositionTableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
        getDesc()
        getCompoInstruct()
        getData()
        
    }
    
    func getDesc() {
        let nib = UINib(nibName: "\(DescriptionTableViewCell.self)", bundle: nil)
        detailCompositionTableView.register(nib, forCellReuseIdentifier: "descriptionTableViewCell")
    }
    
    
    func getCompoInstruct (){
        let nib = UINib(nibName: "\(InstructionTableViewCell.self)", bundle: nil)
        detailCompositionTableView.register(nib, forCellReuseIdentifier: "instructionTableViewCell")
    }
    
    
    func getData(){
        //        let data = Database().getCompositions()
        print("Test Get Data")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            //INSTRUCTION
            return ruleOfThirdInstruction.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            cell.descriptionImage.image = selectedRule[indexPath.row].compositionName?.getImage()
            cell.descriptionTextLabel.text = selectedRule[indexPath.row].compositionDescription
            print("Testing")
            return cell
        case 1:
            //INSTRUCTION
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructionTableViewCell", for: indexPath) as! InstructionTableViewCell
            cell.instructionImage.image = ruleOfThirdInstruction[indexPath.row].instructionNo?.getROTimage()
            cell.instructionNumberLabel.text = ruleOfThirdInstruction[indexPath.row].instructionNo?.rawValue
            cell.instructionDescriptionLabel.text = ruleOfThirdInstruction[indexPath.row].instructionDescription
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
            cell.label.text = ""
            cell.buttonTapCallback = {
                cell.label.text = "Practice"
            }
            return cell
            
        }
        
    }
    
}


// MARK: -Button
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

// MARK: -Extentions
extension DetailCompositionController {
    
    //    func loadCompositionData(){
    //        Database().getInstructions(from: [Composition])
    //    }
    
}

