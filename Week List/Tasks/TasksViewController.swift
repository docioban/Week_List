//
//  TasksViewController.swift
//  Week List
//
//  Created by Macbook Pro on 12/5/20.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, passTask, UIGestureRecognizerDelegate {
    
    var index: Int!
    var rowSelected: Int = -1
    var isEdit: Bool = false
    var rowForUpdate: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = days[index].name
        
        setupTable()
        setupLongPressGesture()
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask)), UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareTasks))]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadColors()
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: color.textColor]
        navigationController?.navigationBar.tintColor = color.textColor
    }
    
    // MARK: - Table View
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.separatorStyle = .none
        return tb
    }()
    
    func reloadColors() {
        tableView.visibleCells.forEach{
            guard let a = $0 as? TaskTableViewCell else { return }
            a.container.backgroundColor = color.buttonColor
            a.title.textColor = color.textColor
            a.timeLabel.textColor = color.textColor
            a.subtitle.textColor = color.textColor
        }
    }
    
    @objc func addNewTask() {
        guard let vc = storyboard?.instantiateViewController(identifier: "NewTask") as? NewTaskViewController else {
            fatalError("Can not find NewTaskViewController")
        }
        vc.delegate = self
        present(vc, animated: true)
    }

    func setupTable() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "CellTask")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == rowSelected {
            guard let nrLines = objects[index].tasks[indexPath.row].info?.filter({ $0 == "\n" }).count else {
                return 118
            }
            return CGFloat(nrLines * 22 + 146)
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects[index].tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as? TaskTableViewCell else {
            fatalError("Can not convert cell to SubjectTabelVeiwCell")
        }
        if objects[index].tasks[indexPath.row].info != nil {
            cell.subtitle.heightAnchor.constraint(equalToConstant: CGFloat(((objects[index].tasks[indexPath.row].info?.filter({ $0 == "\n" }).count)!+1) * 22)).isActive = true
        }
        cell.task = objects[index].tasks[indexPath.row]
        cell.tag = indexPath.row
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(chengeColor(_:)), for: .touchUpInside)
        cell.animate()
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editTask(_:)), for: .touchUpInside)
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(shareTask(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func shareTask(_ sender: UIButton) {
        let items = ["\(objects[index].tasks[sender.tag].title)", "\(objects[index].tasks[sender.tag].time.timeToString())", "\(objects[index].tasks[sender.tag].info ?? "")"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func shareTasks() {
        let items = objects[index].tasks.map{("\($0.title) \($0.time.timeToString())")}
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func editTask(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "NewTask") as? NewTaskViewController else {
            fatalError("Can not find NewTaskViewController")
        }
        vc.delegate = self
        rowForUpdate = sender.tag
        vc.task = objects[index].tasks[sender.tag]
        vc.isUpdate = true
        present(vc, animated: true)
    }
    
    @objc func chengeColor(_ sender: UIButton) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? TaskTableViewCell else {
            return
        }
        if sender.isSelected {
            sender.isSelected = false
            cell.makeNormal()
        } else {
            sender.isSelected = true
            cell.makeUnderline()

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if rowSelected == indexPath.row {
            rowSelected = -1
        } else {
            rowSelected = indexPath.row
        }
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
        tableView.endUpdates()
    }
    
    
    // MARK: - Gesture
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        tableView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            if tableView.isEditing {
                DispatchQueue.main.async {
                    self.saveTask()
                }
                tableView.isEditing = false
                tableView.reloadData()
            } else {
                tableView.isEditing = true
            }
            gestureRecognizer.location(in: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects[index].tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let rowToMove = objects[index].tasks[sourceIndexPath.row]
        objects[index].tasks.remove(at: sourceIndexPath.row)
        objects[index].tasks.insert(rowToMove, at: destinationIndexPath.row)
    }
    
    // MARK: - Save
    func saveTask() {
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        if let encodeData = try? encode.encode(objects) {
            let jsonString = String(data: encodeData, encoding: .utf8)!
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = dir.appendingPathComponent("Tasks.json")
            do {
                try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
//                print(jsonString)
            }
            catch {
                fatalError("Can not write in file")
            }
        }
    }
    
    // MARK: - Pass Task
    func passTask(task: Task) {
        objects[index].tasks.append(task)
        DispatchQueue.main.async {
            self.saveTask()
        }
        tableView.reloadData()
    }
    
    func passForUpdate(task: Task) {
        objects[index].tasks[rowForUpdate] = task
        DispatchQueue.main.async {
            self.saveTask()
        }
        tableView.reloadData()
    }
}
