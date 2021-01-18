//
//  NewTaskViewController.swift
//  Week List
//
//  Created by Macbook Pro on 12/6/20.
//

import UIKit

protocol passTask {
    func passTask(task: Task)
    func passForUpdate(task: Task)
}

class NewTaskViewController: UIViewController {
    var delegate: passTask!
    var isUpdate = false
    
    var task: Task? {
        didSet {
            guard let task = task else {
                fatalError("Is not task")
            }
            nameFiled.text = task.title
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            guard let date = dateFormatter.date(from: "\(task.time.hour):\(task.time.minutes)") else {
                fatalError("No such data")
            }
            timePicker.date = date
            
            infoText.text = task.info
        }
    }

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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = color.textColor
        return label
    }()
    
    let nameFiled: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name Task"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = color.textColor
        tf.backgroundColor = .secondarySystemBackground
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.rightView = paddingView
        tf.rightViewMode = .always
        tf.layer.cornerRadius = 20
        tf.layer.shadowColor = color.buttonColor.cgColor
        tf.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        tf.layer.shadowOpacity = 0.4
        tf.layer.shadowRadius = 20
        tf.layer.masksToBounds = false
        return tf
    }()
    
    let timePicker: UIDatePicker = {
        let p = UIDatePicker()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.datePickerMode = .time
        p.preferredDatePickerStyle = .wheels
        p.tintColor = color.textColor
        return p
    }()
    
    

    let infoText: UITextView = {
        let t = UITextView()
        t.isEditable = true
        t.isUserInteractionEnabled = true
        t.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textColor = color.textColor
        t.autocapitalizationType = .sentences
        t.backgroundColor = .secondarySystemBackground
        t.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        t.layer.cornerRadius = 20
        t.layer.shadowColor = color.buttonColor.cgColor
        t.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        t.layer.shadowOpacity = 0.4
        t.layer.shadowRadius = 20
        t.layer.masksToBounds = false
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupTextFields()
        
        addElements()
    }

    func setupTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        infoText.inputAccessoryView = toolbar
        nameFiled.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if !nameFiled.isEditing {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardFrame.height - view.safeAreaInsets.bottom
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if !nameFiled.isEditing {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func addElements() {
        let distanceBeetwenView: CGFloat = 30
        
        view.addSubview(infoText)
        infoText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceBeetwenView).isActive = true
        infoText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -distanceBeetwenView).isActive = true
        infoText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        view.addSubview(timePicker)
        timePicker.bottomAnchor.constraint(equalTo: infoText.topAnchor, constant: -distanceBeetwenView).isActive = true
        timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(nameFiled)
        nameFiled.bottomAnchor.constraint(equalTo: timePicker.topAnchor, constant: -distanceBeetwenView).isActive = true
        nameFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        nameFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        nameFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: nameFiled.topAnchor, constant: -distanceBeetwenView).isActive = true
        
        view.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc func saveTapped() {
        guard let title = nameFiled.text else {
            fatalError("Is not find this text field")
        }
        if title == "" {
            alertNoComplet(title: "Name is not complet", message: "Field name is required")
            return
        }
        
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        guard let fromHour = components.hour else { fatalError("Can not found component hour in components") }
        guard let fromMinute = components.minute else { fatalError("Can not found component minute in components") }
        
        let task = Task(title: title, info: infoText.text, time: Time(hour: fromHour, minutes: fromMinute))
        if isUpdate {
            delegate.passForUpdate(task: task)
        } else {
            delegate.passTask(task: task)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func alertNoComplet(title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "ok", style: .default))
        present(vc, animated: true)
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }

}
