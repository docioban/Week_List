//
//  CreatePasswordViewController.swift
//  Week List
//
//  Created by Macbook Pro on 12/5/20.
//

import UIKit

protocol passPassword {
    func isSavePassword(isSave: Bool)
}

class CreatePasswordViewController: UIViewController {
    
    var delegate: passPassword!
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Password"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = color.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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

    let newPassFiled: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.placeholder = "New Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = color.textColor
        tf.backgroundColor = .secondarySystemBackground
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.rightView = paddingView
        tf.rightViewMode = .always
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    let secondNewPassFiled: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.placeholder = "Second time new Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = color.textColor
        tf.backgroundColor = .secondarySystemBackground
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.rightView = paddingView
        tf.rightViewMode = .always
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    let errorLable1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        return label
    }()
    
    let errorLable2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        
        view.addSubview(saveButton)
        saveButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        view.addSubview(newPassFiled)
        newPassFiled.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        newPassFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        newPassFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        newPassFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(secondNewPassFiled)
        secondNewPassFiled.topAnchor.constraint(equalTo: newPassFiled.bottomAnchor, constant: 50).isActive = true
        secondNewPassFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        secondNewPassFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        secondNewPassFiled.heightAnchor.constraint(equalTo: newPassFiled.heightAnchor).isActive = true
    }
    
    @objc func saveTapped() {
        guard let password = newPassFiled.text else {
            return
        }
        if password.count < 4 {
            errorLable2.text = ""
            errorLable1.text = "Must be more then 3 characters"
            view.addSubview(errorLable1)
            errorLable1.topAnchor.constraint(equalTo: newPassFiled.bottomAnchor, constant: 5).isActive = true
            errorLable1.leadingAnchor.constraint(equalTo: newPassFiled.leadingAnchor, constant: 10).isActive = true
            
            newPassFiled.text = ""
            secondNewPassFiled.text = ""
            return
        }
        
        if newPassFiled.text == secondNewPassFiled.text {
            KeychainWrapper.standard.set(password, forKey: "Password")
            delegate.isSavePassword(isSave: true)
            dismiss(animated: true, completion: nil)
        } else {
            errorLable1.text = ""
            errorLable2.text = "Passwords must be the same"
            view.addSubview(errorLable2)
            errorLable2.topAnchor.constraint(equalTo: secondNewPassFiled.bottomAnchor, constant: 10).isActive = true
            errorLable2.leadingAnchor.constraint(equalTo: secondNewPassFiled.leadingAnchor, constant: 10).isActive = true
            secondNewPassFiled.text = ""
        }
    }

    @objc func cancelTapped() {
        delegate.isSavePassword(isSave: false)
        dismiss(animated: true, completion: nil)
    }
}
