//
//  DaysViewController.swift
//  Week List
//
//  Created by Macbook Pro on 11/30/20.
//

import UIKit
import LocalAuthentication

class DaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    let passwordField: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isSelected = true
        t.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        t.keyboardType = .numberPad
        t.textAlignment = .center
        t.isSecureTextEntry = true
        t.backgroundColor = .green
        t.addTarget(self, action: #selector(checkPassword(_:)), for: .editingChanged)
        return t
    }()
    
    var index: Int = -1
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password = KeychainWrapper.standard.string(forKey: "Password")
        if password != nil, password != "" {
            authentication()
        } else {
            showView()
        }
    }
    
    func authentication() {
        view.addSubview(passwordField)
        passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        passwordField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        view.endEditing(false)
        
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.showView()
                    }
                }
            }
        }
        
        title = "Password"
    }
    
    @objc func checkPassword(_ sender: UITextField) {
        if sender.text == password {
            passwordField.isEnabled = false
            passwordField.isHidden = true
            showView()
        }
    }
    
    func showView() {
        setColors()
        
        title = "Days"
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color.textColor]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: color.textColor]
        navigationController?.navigationBar.tintColor = color.textColor
        
        tabBarController?.tabBar.tintColor = color.buttonColor
        tabBarController?.tabBar.unselectedItemTintColor = color.textColor

        readFile()
        setupTable()
    }
    
    func setColors() {
        color.index = UserDefaults.standard.integer(forKey: "colorIndex")
        color.buttonColor = UIColor(named: "ButtonColor\(color.index)") ?? .white
        color.textColor = UIColor(named: "TextColor\(color.index)") ?? .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color.textColor]
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: color.textColor]
        navigationController?.navigationBar.tintColor = color.textColor
        self.tableView.reloadData()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color.textColor]
        if index != -1 {
            tableView.beginUpdates()
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            tableView.endUpdates()
        }
    }
    
    func readFile() {
        if let path = Bundle.main.url(forResource: "Days", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: path)
                if let jsonResult = try? JSONDecoder().decode(Days.self, from: jsonData) {
                    days = jsonResult.days
                }
            } catch {
                print(error)
            }
        }
        
        for d in days {
            for s in d.subjects {
                if !allSubjects.contains(s.subject) {
                    allSubjects.append(s.subject)
                }
            }
        }
        
//        print(allSubjects)
    }
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DayTableViewCell.self, forCellReuseIdentifier: "cellDay")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        days.forEach { (day) in
            if day.appear {
                count += 1
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellDay", for: indexPath) as? DayTableViewCell else {
            fatalError("Can not cast to DayTableVieCell")
        }
        cell.day = days[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "subjectView") as? SubjectsViewController {
            vc.index = indexPath.row
            index = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
