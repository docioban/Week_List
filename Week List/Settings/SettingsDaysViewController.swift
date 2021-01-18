//
//  SettingsDaysViewController.swift
//  Week List
//
//  Created by Macbook Pro on 12/1/20.
//

import UIKit

class SettingsDaysViewController: UIViewController {
    
    var checkBoxes = [UIButton]()
    
    let cancelButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Cancel", for: .normal)
        b.setTitleColor(color.textColor, for: .normal)
        b.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return b
    }()
    
    let saveButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Save", for: .normal)
        b.setTitleColor(color.textColor, for: .normal)
        b.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return b
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Days"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color.textColor
        return label
    }()
    
    let checkBox0: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(checkDay), for: .touchUpInside)
        return b
    }()
    
    let dayLabel0: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunday"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = color.textColor
        return label
    }()
    
    let checkBox1: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(checkDay), for: .touchUpInside)
        return b
    }()
    
    let dayLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Monday"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = color.textColor
        return label
    }()
    
    let checkBox2: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(checkDay), for: .touchUpInside)
        return b
    }()
    
    let dayLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tuesday"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = color.textColor
        return label
    }()
    
    let checkBox3: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(checkDay), for: .touchUpInside)
        return b
    }()
    
    let dayLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wednesday"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = color.textColor
        return label
    }()
    
    let checkBox4: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(checkDay), for: .touchUpInside)
        return b
    }()
    
    let dayLabel4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thursday"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = color.textColor
        return label
    }()
    
    let checkBox5: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(checkDay), for: .touchUpInside)
        return b
    }()
    
    let dayLabel5: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Friday"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = color.textColor
        return label
    }()
    
    let checkBox6: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(checkDay), for: .touchUpInside)
        return b
    }()
    
    let dayLabel6: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Saturday"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = color.textColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addElements()
    }
    
    func addElements() {
        let heightButton:CGFloat = 30
        
        view.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        view.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(checkBox0)
        checkBox0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        checkBox0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        checkBox0.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox0.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(dayLabel0)
        dayLabel0.topAnchor.constraint(equalTo: checkBox0.topAnchor, constant: 3).isActive = true
        dayLabel0.leadingAnchor.constraint(equalTo: checkBox0.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox1)
        checkBox1.topAnchor.constraint(equalTo: checkBox0.bottomAnchor, constant: 20).isActive = true
        checkBox1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        checkBox1.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox1.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(dayLabel1)
        dayLabel1.topAnchor.constraint(equalTo: checkBox1.topAnchor, constant: 3).isActive = true
        dayLabel1.leadingAnchor.constraint(equalTo: checkBox1.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox2)
        checkBox2.topAnchor.constraint(equalTo: checkBox1.bottomAnchor, constant: 20).isActive = true
        checkBox2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        checkBox2.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox2.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(dayLabel2)
        dayLabel2.topAnchor.constraint(equalTo: checkBox2.topAnchor, constant: 3).isActive = true
        dayLabel2.leadingAnchor.constraint(equalTo: checkBox2.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox3)
        checkBox3.topAnchor.constraint(equalTo: checkBox2.bottomAnchor, constant: 20).isActive = true
        checkBox3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        checkBox3.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox3.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(dayLabel3)
        dayLabel3.topAnchor.constraint(equalTo: checkBox3.topAnchor, constant: 3).isActive = true
        dayLabel3.leadingAnchor.constraint(equalTo: checkBox3.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox4)
        checkBox4.topAnchor.constraint(equalTo: checkBox3.bottomAnchor, constant: 20).isActive = true
        checkBox4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        checkBox4.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox4.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(dayLabel4)
        dayLabel4.topAnchor.constraint(equalTo: checkBox4.topAnchor, constant: 3).isActive = true
        dayLabel4.leadingAnchor.constraint(equalTo: checkBox4.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox5)
        checkBox5.topAnchor.constraint(equalTo: checkBox4.bottomAnchor, constant: 20).isActive = true
        checkBox5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        checkBox5.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox5.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(dayLabel5)
        dayLabel5.topAnchor.constraint(equalTo: checkBox5.topAnchor, constant: 3).isActive = true
        dayLabel5.leadingAnchor.constraint(equalTo: checkBox5.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox6)
        checkBox6.topAnchor.constraint(equalTo: checkBox5.bottomAnchor, constant: 20).isActive = true
        checkBox6.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        checkBox6.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox6.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(dayLabel6)
        dayLabel6.topAnchor.constraint(equalTo: checkBox6.topAnchor, constant: 3).isActive = true
        dayLabel6.leadingAnchor.constraint(equalTo: checkBox6.trailingAnchor, constant: 20).isActive = true
        
        checkBox0.isSelected = days[0].appear
        checkBox1.isSelected = days[1].appear
        checkBox2.isSelected = days[2].appear
        checkBox3.isSelected = days[3].appear
        checkBox4.isSelected = days[4].appear
        checkBox5.isSelected = days[5].appear
        checkBox6.isSelected = days[6].appear
    }
    
    @objc func checkDay(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @objc func saveTapped() {
        days[0].appear = checkBox0.isSelected
        days[1].appear = checkBox1.isSelected
        days[2].appear = checkBox2.isSelected
        days[3].appear = checkBox3.isSelected
        days[4].appear = checkBox4.isSelected
        days[5].appear = checkBox5.isSelected
        days[6].appear = checkBox6.isSelected
        DispatchQueue.main.async {
            self.savePath()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func savePath() {
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        if let encodeData = try? encode.encode(days) {
            let jsonString = String(data: encodeData, encoding: .utf8)!
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = dir.appendingPathComponent("Days.json")
            do {
                try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                fatalError("Can not write in file")
            }
        }
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
}
