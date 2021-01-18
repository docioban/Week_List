//
//  SubjectsViewController.swift
//  Week List
//
//  Created by Macbook Pro on 11/30/20.
//

import UIKit

protocol PassDataToVc {
    func passDataToSave(subject: Subject)
    func passDataToUpdate(subject: Subject)
}

class SubjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PassDataToVc, UIGestureRecognizerDelegate {
    
    func passDataToSave(subject: Subject) {
        days[index].subjects.append(subject)
        DispatchQueue.main.async {
            self.savePath()
        }
        tableView.reloadData()
        DispatchQueue.main.async {
            // add category to task
            self.readTask()
            objects.append(Object(name: subject.subject, tasks: []))
            self.saveTask()
        }
    }
    
    func readTask() {
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
    
    func saveTask() {
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        if let encodeData = try? encode.encode(objects) {
            let jsonString = String(data: encodeData, encoding: .utf8)!
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = dir.appendingPathComponent("Tasks.json")
            do {
                try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                fatalError("Can not write in file")
            }
        }
    }
    
    func passDataToUpdate(subject: Subject) {
        days[index].subjects[rowForUpdate] = subject
        DispatchQueue.main.async {
            self.savePath()
        }
        tableView.reloadData()
    }
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    var index: Int!
    
    var rowSelected: Int = -1
    var rowForUpdate: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = days[index].name
        
        setupTable()
        setupLongPressGesture()
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewSubject)), UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareDay))]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadColors()
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: color.textColor]
        navigationController?.navigationBar.tintColor = color.textColor
    }
    
    func reloadColors() {
        tableView.visibleCells.forEach{
            guard let a = $0 as? SubjectTableViewCell else { return }
            a.container.backgroundColor = color.buttonColor
            a.title.textColor = color.textColor
            a.subtitle.textColor = color.textColor
        }
    }
    
    @objc func addNewSubject() {
        guard let vc = storyboard?.instantiateViewController(identifier: "AddSubject") as? AddSubjectViewController else {
            fatalError("Can not find addNewObjcetViewController")
        }
        vc.delegate = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        var date = dateFormatter.date(from: "08:00")
        if !days[index].subjects.isEmpty {
            date = dateFormatter.date(from: "\(days[index].subjects.last?.timeEnd.hour ?? 08):\(days[index].subjects.last?.timeEnd.minutes ?? 00)")
        }
        vc.fromPicker.date = date ?? dateFormatter.date(from: "08:00")!
        
        if !days[index].subjects.isEmpty {
            let newTimp = days[index].subjects.last?.timeEnd.adaugaTimp(hour: 1, minute: 20)
            date = dateFormatter.date(from: "\(newTimp?.0 ?? 08):\(newTimp?.1 ?? 00)")
        }
        vc.toPicker.date = date ?? dateFormatter.date(from: "08:00")!
        
        present(vc, animated: true)
    }
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(SubjectTableViewCell.self, forCellReuseIdentifier: "cellSubject")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == rowSelected {
            return CGFloat(((days[index].subjects[indexPath.row].info?.filter({ $0 == "\n" }).count ?? 0) * 22) + 140)
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days[index].subjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellSubject", for: indexPath) as? SubjectTableViewCell else {
            fatalError("Can not convert cell to SubjectTabelVeiwCell")
        }
        if (days[index].subjects[indexPath.row].info != nil) {
            cell.subtitle.heightAnchor.constraint(equalToConstant: CGFloat((days[index].subjects[indexPath.row].info?.filter({ $0 == "\n" }).count)!+1) * 22).isActive = true
        }
        cell.subject = days[index].subjects[indexPath.row]
        cell.editButton.tag = indexPath.row
        cell.shareButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editButtonTap(_:)), for: .touchUpInside)
        cell.shareButton.addTarget(self, action: #selector(shareSubject(_:)), for: .touchUpInside)
        cell.animate()
        return cell
    }
    
    @objc func shareSubject(_ sender: UIButton) {
        let items = ["\(days[index].subjects[sender.tag].subject)", "\(days[index].subjects[sender.tag].timeToString())", "\(days[index].subjects[sender.tag].info ?? "")"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func shareDay() {
        let items = days[index].subjects.map{("\($0.subject) \($0.timeToString())")}
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func editButtonTap(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "AddSubject") as? AddSubjectViewController else {
            fatalError("Can not find addNewObjcetViewController")
        }
        vc.delegate = self
        rowForUpdate = sender.tag
        vc.subject = days[index].subjects[rowForUpdate]
        present(vc, animated: true)
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
                    self.savePath()
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
            days[index].subjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let rowToMove = days[index].subjects[sourceIndexPath.row]
        days[index].subjects.remove(at: sourceIndexPath.row)
        days[index].subjects.insert(rowToMove, at: destinationIndexPath.row)
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
}
