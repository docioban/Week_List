//
//  AddSubjectViewController.swift
//  Week List
//
//  Created by Macbook Pro on 12/4/20.
//

import UIKit

class AddSubjectViewController: UIViewController, UITableViewDataSource {
    
    var delegate: PassDataToVc!
    
    var isUpdate = false

    var subject: Subject? {
        didSet {
            guard let subject = subject else { return }
            isUpdate = true
            nameFiled.text = subject.subject
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            guard let date = dateFormatter.date(from: "\(subject.timeBegin.hour):\(subject.timeBegin.minutes)") else {
                fatalError("No such data")
            }
            fromPicker.date = date
            guard let data = dateFormatter.date(from: "\(subject.timeEnd.hour):\(subject.timeEnd.minutes)") else {
                fatalError("No such data")
            }
            toPicker.date = data
            homeworkTextView.text = subject.info
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
        label.text = "New Subjec"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = color.textColor
        return label
    }()
    
    let nameFiled: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name Subject"
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
    
    let table: UITableView = {
        let tw = UITableView()
        tw.translatesAutoresizingMaskIntoConstraints = false
        return tw
    }()

    let fromLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.text = "From"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color.textColor
        label.sizeToFit()
        return label
    }()
    
    let fromPicker: UIDatePicker = {
        let p = UIDatePicker()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.datePickerMode = .time
        p.preferredDatePickerStyle = .wheels
        p.tintColor = color.textColor
        return p
    }()

    let toLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.text = "To"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color.textColor
        return label
    }()
    
    let toPicker: UIDatePicker = {
        let p = UIDatePicker()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.datePickerMode = .time
        p.preferredDatePickerStyle = .wheels
        p.tintColor = color.textColor
        return p
    }()

    let homeworkTextView: UITextView = {
        let t = UITextView()
        t.isEditable = true
        t.isScrollEnabled = true
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
        
        homeworkTextView.inputAccessoryView = toolbar
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
        
        view.addSubview(homeworkTextView)
        homeworkTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceBeetwenView).isActive = true
        homeworkTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -distanceBeetwenView).isActive = true
        homeworkTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        view.addSubview(toPicker)
        toPicker.bottomAnchor.constraint(equalTo: homeworkTextView.topAnchor, constant: -distanceBeetwenView+10).isActive = true
        toPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        toPicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(toLabel)
        toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceBeetwenView).isActive = true
        toLabel.centerYAnchor.constraint(equalTo: toPicker.centerYAnchor).isActive = true
        
        view.addSubview(fromPicker)
        fromPicker.bottomAnchor.constraint(equalTo: toPicker.topAnchor, constant: -distanceBeetwenView).isActive = true
        fromPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        fromPicker.heightAnchor.constraint(equalTo: toPicker.heightAnchor).isActive = true
        
        view.addSubview(fromLabel)
        fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceBeetwenView).isActive = true
        fromLabel.centerYAnchor.constraint(equalTo: fromPicker.centerYAnchor).isActive = true
        fromLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        fromPicker.leadingAnchor.constraint(equalTo: fromLabel.trailingAnchor).isActive = true
        toPicker.widthAnchor.constraint(equalTo: fromPicker.widthAnchor).isActive = true
        
        view.addSubview(nameFiled)
//        nameFiled.addTarget(self, action: #selector(tableViewApear), for: .editingDidBegin)
        nameFiled.bottomAnchor.constraint(equalTo: fromLabel.topAnchor, constant: -distanceBeetwenView).isActive = true
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
    
    @objc func tableViewApear() {
//        tableView.rowHeight = 40
//        view.addSubview(table)
//        table.topAnchor.constraint(equalTo: nameFiled.bottomAnchor).isActive = true
//        table.leadingAnchor.constraint(equalTo: nameFiled.leadingAnchor).isActive = true
//        table.trailingAnchor.constraint(equalTo: nameFiled.trailingAnchor).isActive = true
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func saveTapped() {
        guard let subject = nameFiled.text else {
            fatalError("Is not find this text field")
        }
        if subject == "" {
            alertNoComplet(title: "Name is not complet", message: "Field name is required")
            return
        }
        var date = fromPicker.date
        var components = Calendar.current.dateComponents([.hour, .minute], from: date)
        guard let fromHour = components.hour else { fatalError("Can not found component hour in components") }
        guard let fromMinute = components.minute else { fatalError("Can not found component minute in components") }
        
        date = toPicker.date
        components = Calendar.current.dateComponents([.hour, .minute], from: date)
        guard let toHour = components.hour else { fatalError("Can not found component hour in components") }
        guard let toMinute = components.minute else { fatalError("Can not found component minute in components") }
        
        let sub = Subject(subject: subject.capitalized, info: homeworkTextView.text, timeBegin: Time(hour: fromHour, minutes: fromMinute), timeEnd: Time(hour: toHour, minutes: toMinute))
        if isUpdate {
            delegate.passDataToUpdate(subject: sub)
        } else {
            delegate.passDataToSave(subject: sub)
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("fsadfs")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "a"
        return cell
    }
}
