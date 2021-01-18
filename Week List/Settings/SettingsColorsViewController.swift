//
//  SettingsColorsViewController.swift
//  Week List
//
//  Created by Macbook Pro on 12/3/20.
//

import UIKit

protocol reloadColors {
    func reloadColorViews()
}

class SettingsColorsViewController: UIViewController {

    
    var checkBoxs = [UIButton]()
    var index: Int = color.index
    var delegate: reloadColors!

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
        label.text = "Colors"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color.textColor
        return label
    }()
    
    let color0: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        v.image = renderer.image {
            ctx in
            guard let color = UIColor(named: "ButtonColor0") else { fatalError("No this color") }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 40, height: 40))
            ctx.cgContext.drawPath(using: .fill)
        }
        
        return v
    }()
    
    let color1: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        v.image = renderer.image {
            ctx in
            guard let color = UIColor(named: "TextColor0") else { fatalError("No this color") }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 40, height: 40))
            ctx.cgContext.drawPath(using: .fill)
        }
        
        return v
    }()
    
    let checkBox0: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(chengeColor), for: .touchUpInside)
        return b
    }()
    
    let color2: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        v.image = renderer.image {
            ctx in
            guard let color = UIColor(named: "ButtonColor1") else { fatalError("No this color") }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 40, height: 40))
            ctx.cgContext.drawPath(using: .fill)
        }
        
        return v
    }()
    
    let color3: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        v.image = renderer.image {
            ctx in
            guard let color = UIColor(named: "TextColor1") else { fatalError("No this color") }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 40, height: 40))
            ctx.cgContext.drawPath(using: .fill)
        }
        
        return v
    }()
    
    let checkBox1: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(chengeColor), for: .touchUpInside)
        return b
    }()
    
    let color4: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        v.image = renderer.image {
            ctx in
            guard let color = UIColor(named: "ButtonColor2") else { fatalError("No this color") }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 40, height: 40))
            ctx.cgContext.drawPath(using: .fill)
        }
        
        return v
    }()
    
    let color5: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        v.image = renderer.image {
            ctx in
            guard let color = UIColor(named: "TextColor2") else { fatalError("No this color") }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 40, height: 40))
            ctx.cgContext.drawPath(using: .fill)
        }
        
        return v
    }()
    
    let checkBox2: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(chengeColor), for: .touchUpInside)
        return b
    }()
    
    let color6: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        v.image = renderer.image {
            ctx in
            guard let color = UIColor(named: "ButtonColor3") else { fatalError("No this color") }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 40, height: 40))
            ctx.cgContext.drawPath(using: .fill)
        }
        
        return v
    }()
    
    let color7: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        v.image = renderer.image {
            ctx in
            guard let color = UIColor(named: "TextColor3") else { fatalError("No this color") }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 40, height: 40))
            ctx.cgContext.drawPath(using: .fill)
        }
        
        return v
    }()
    
    let checkBox3: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        b.addTarget(self, action: #selector(chengeColor), for: .touchUpInside)
        return b
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addElements()
    }
    
    func addElements() {
        let heightButton:CGFloat = 40
        
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
        
        view.addSubview(color0)
        color0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        color0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        view.addSubview(color1)
        color1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        color1.leadingAnchor.constraint(equalTo: color0.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox0)
        checkBoxs.append(checkBox0)
        checkBox0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        checkBox0.leadingAnchor.constraint(equalTo: color1.trailingAnchor, constant: 40).isActive = true
        checkBox0.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox0.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        
        view.addSubview(color2)
        color2.topAnchor.constraint(equalTo: color0.bottomAnchor, constant: 20).isActive = true
        color2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        view.addSubview(color3)
        color3.topAnchor.constraint(equalTo: color1.bottomAnchor, constant: 20).isActive = true
        color3.leadingAnchor.constraint(equalTo: color2.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox1)
        checkBoxs.append(checkBox1)
        checkBox1.topAnchor.constraint(equalTo: checkBox0.bottomAnchor, constant: 20).isActive = true
        checkBox1.leadingAnchor.constraint(equalTo: color3.trailingAnchor, constant: 40).isActive = true
        checkBox1.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox1.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(color4)
        color4.topAnchor.constraint(equalTo: color2.bottomAnchor, constant: 20).isActive = true
        color4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        view.addSubview(color5)
        color5.topAnchor.constraint(equalTo: color3.bottomAnchor, constant: 20).isActive = true
        color5.leadingAnchor.constraint(equalTo: color4.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox2)
        checkBoxs.append(checkBox2)
        checkBox2.topAnchor.constraint(equalTo: checkBox1.bottomAnchor, constant: 20).isActive = true
        checkBox2.leadingAnchor.constraint(equalTo: color5.trailingAnchor, constant: 40).isActive = true
        checkBox2.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox2.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        view.addSubview(color6)
        color6.topAnchor.constraint(equalTo: color4.bottomAnchor, constant: 20).isActive = true
        color6.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        view.addSubview(color7)
        color7.topAnchor.constraint(equalTo: color5.bottomAnchor, constant: 20).isActive = true
        color7.leadingAnchor.constraint(equalTo: color6.trailingAnchor, constant: 20).isActive = true
        
        view.addSubview(checkBox3)
        checkBoxs.append(checkBox3)
        checkBox3.topAnchor.constraint(equalTo: checkBox2.bottomAnchor, constant: 20).isActive = true
        checkBox3.leadingAnchor.constraint(equalTo: color7.trailingAnchor, constant: 40).isActive = true
        checkBox3.heightAnchor.constraint(equalToConstant: heightButton).isActive = true
        checkBox3.widthAnchor.constraint(equalToConstant: heightButton).isActive = true
        
        checkBoxs[color.index].isSelected = true
        index = color.index
    }
    
    @objc func chengeColor(sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            checkBoxs[index].isSelected = false
            index = checkBoxs.firstIndex(of: sender) ?? 1
            switchColorsInView()
        }
    }
    
    func switchColorsInView() {
        cancelButton.setTitleColor(UIColor(named: "TextColor\(index)") ?? .black, for: .normal)
        saveButton.setTitleColor(UIColor(named: "TextColor\(index)") ?? .black, for: .normal)
        titleLabel.textColor = UIColor(named: "TextColor\(index)") ?? .black
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped() {
        let vc = UIAlertController(title: "Save", message: "Save changes?", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Yes", style: .default) {
            [weak self] _ in
            color.index = self?.index ?? color.index
            color.buttonColor = UIColor(named: "ButtonColor\(color.index)") ?? .white
            color.textColor = UIColor(named: "TextColor\(color.index)") ?? .black
            let defaults = UserDefaults.standard
            defaults.setValue(color.index, forKey: "colorIndex")
            self?.delegate.reloadColorViews()
            self?.dismiss(animated: true, completion: nil)
        })
        vc.addAction(UIAlertAction(title: "No", style: .default) {
            [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        })
        present(vc, animated: true)
    }

}
