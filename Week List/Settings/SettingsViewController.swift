//
//  SettingsViewController.swift
//  Week List
//
//  Created by Macbook Pro on 11/30/20.
//

import UIKit

class SettingsViewController: UIViewController, passPassword, reloadColors {
    
    let containerDays: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        return v
    }()

    let containerColor: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        return v
    }()

    let containerPassword: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        return v
    }()
    
    let textInDays: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Days"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    let textInColor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Color"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    let textInPassword: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    let passwordSwitch: UISwitch = {
        let s = UISwitch(frame: .zero)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.setOn(false, animated: true)
        s.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: color.textColor]
        
        initElements()
        addElements()
    }
    
    func initElements() {
        containerDays.backgroundColor = color.buttonColor
        containerColor.backgroundColor = color.buttonColor
        containerPassword.backgroundColor = color.buttonColor
        textInDays.textColor = color.textColor
        textInColor.textColor = color.textColor
        textInPassword.textColor = color.textColor
    }
    
    func addElements() {
        
        let heightOfCell: CGFloat = 72
        let topAnchorCell: CGFloat = 10
//        let bottomAnchorCell: CGFloat = 4
        let leadingAnchorCell: CGFloat = 5
        let trailingAnchorCell: CGFloat = -5
        let leadingAnchorText: CGFloat = 15
        let trailingAnchorText: CGFloat = -15
        
        view.addSubview(containerDays)
        containerDays.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        containerDays.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingAnchorCell).isActive = true
        containerDays.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingAnchorCell).isActive = true
        containerDays.heightAnchor.constraint(equalToConstant: heightOfCell).isActive = true
        
        containerDays.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsDays)))

        containerDays.addSubview(textInDays)
        textInDays.topAnchor.constraint(equalTo: containerDays.topAnchor).isActive = true
        textInDays.leadingAnchor.constraint(equalTo: containerDays.leadingAnchor, constant: leadingAnchorText).isActive = true
        textInDays.trailingAnchor.constraint(equalTo: containerDays.trailingAnchor, constant: trailingAnchorText).isActive = true
        textInDays.bottomAnchor.constraint(equalTo: containerDays.bottomAnchor).isActive = true
        
        view.addSubview(containerColor)
        containerColor.topAnchor.constraint(equalTo: containerDays.bottomAnchor, constant: topAnchorCell).isActive = true
        containerColor.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingAnchorCell).isActive = true
        containerColor.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingAnchorCell).isActive = true
        containerColor.heightAnchor.constraint(equalToConstant: heightOfCell).isActive = true
        
        containerColor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsColors)))
        
        containerColor.addSubview(textInColor)
        textInColor.topAnchor.constraint(equalTo: containerColor.topAnchor).isActive = true
        textInColor.leadingAnchor.constraint(equalTo: containerColor.leadingAnchor, constant: leadingAnchorText).isActive = true
        textInColor.trailingAnchor.constraint(equalTo: containerColor.trailingAnchor, constant: trailingAnchorText).isActive = true
        textInColor.bottomAnchor.constraint(equalTo: containerColor.bottomAnchor).isActive = true
        
        view.addSubview(containerPassword)
        containerPassword.topAnchor.constraint(equalTo: containerColor.bottomAnchor, constant: topAnchorCell).isActive = true
        containerPassword.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingAnchorCell).isActive = true
        containerPassword.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingAnchorCell).isActive = true
        containerPassword.heightAnchor.constraint(equalToConstant: heightOfCell).isActive = true
        
        containerPassword.addSubview(textInPassword)
        textInPassword.topAnchor.constraint(equalTo: containerPassword.topAnchor).isActive = true
        textInPassword.leadingAnchor.constraint(equalTo: containerPassword.leadingAnchor, constant: leadingAnchorText).isActive = true
        textInPassword.bottomAnchor.constraint(equalTo: containerPassword.bottomAnchor).isActive = true
        
        containerPassword.addSubview(passwordSwitch)
        passwordSwitch.trailingAnchor.constraint(equalTo: containerPassword.trailingAnchor, constant: -10).isActive = true
        passwordSwitch.centerYAnchor.constraint(equalTo: containerPassword.centerYAnchor).isActive = true
        let p = KeychainWrapper.standard.string(forKey: "Password")
        if p != nil, p != "" {
            passwordSwitch.setOn(true, animated: true)
        } else {
            passwordSwitch.setOn(false, animated: true)
        }
    }
    
    @objc func settingsDays() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsDays") as? SettingsDaysViewController {
            present(vc, animated: true)
        }
    }
    
    @objc func settingsColors() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsColors") as? SettingsColorsViewController {
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    func reloadColorViews() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: color.textColor]
        containerDays.backgroundColor = color.buttonColor
        containerColor.backgroundColor = color.buttonColor
        containerPassword.backgroundColor = color.buttonColor
        textInDays.textColor = color.textColor
        textInColor.textColor = color.textColor
        textInPassword.textColor = color.textColor
        tabBarController?.tabBar.tintColor = color.buttonColor
        tabBarController?.tabBar.unselectedItemTintColor = color.textColor
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        if sender.tag == 0 {
            if sender.isOn {
                if let vc = storyboard?.instantiateViewController(identifier: "CreatePassword") as? CreatePasswordViewController {
                    vc.delegate = self
                    present(vc, animated: true)
                }
            } else {
                KeychainWrapper.standard.set("", forKey: "Password")
            }
        }
    }
    
    func isSavePassword(isSave: Bool) {
        passwordSwitch.setOn(isSave, animated: true)
    }
}
