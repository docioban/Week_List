//
//  SubjectsTasksViewController.swift
//  Week List
//
//  Created by Macbook Pro on 12/5/20.
//

import UIKit

class SubjectsTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.separatorStyle = .none
        return t
    }()
    
    var index = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        readFile()
        setupTable()
    }
    
    func readFile() {
        if let path = Bundle.main.url(forResource: "Tasks", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: path)
                if let jsonResult = try? JSONDecoder().decode(Tasks.self, from: jsonData) {
                    objects = jsonResult.objects
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadColors()
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: color.textColor]
        navigationController?.navigationBar.tintColor = color.textColor
        
        if index != -1 {
            tableView.beginUpdates()
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            tableView.endUpdates()
        }
    }
    
    func reloadColors() {
        tableView.visibleCells.forEach{
            guard let a = $0 as? SubjectTaskTableViewCell else { return }
            a.container.backgroundColor = color.buttonColor
            a.title.textColor = color.textColor
            a.subtitle.textColor = color.textColor
        }
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
        
        tableView.register(SubjectTaskTableViewCell.self, forCellReuseIdentifier: "CellSubjectTask")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellSubjectTask") as? SubjectTaskTableViewCell else { fatalError("Can not cast cell to SubjectTaskTableViewCell") }
        cell.object = objects[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Tasks") as? TasksViewController {
            vc.index = indexPath.row
            index = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
