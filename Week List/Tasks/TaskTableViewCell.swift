//
//  TaskTableViewCell.swift
//  Week List
//
//  Created by Macbook Pro on 12/5/20.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    var task: Task? {
        didSet {
            guard let task = task else { return }
            self.title.text = task.title
            self.timeLabel.text = "\(task.time.hour):\(task.time.minutes)"
            self.subtitle.text = task.info ?? "error"
        }
    }
    
    let title: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lable.textColor = color.textColor
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let editButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(systemName: "pencil"), for: .normal)
        b.tintColor = color.textColor
        return b
    }()
    
    let shareButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        b.tintColor = color.textColor
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = color.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = color.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = -1
        return label
    }()
    
    let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = color.buttonColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let checkBox: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        b.setImage(UIImage(named: "Checkbox"), for: [.selected])
        return b
    }()
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.contentView.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(container)
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        container.addSubview(title)
        title.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20).isActive = true
        title.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        contentView.addSubview(checkBox)
        checkBox.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
        checkBox.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkBox.widthAnchor.constraint(equalTo: checkBox.heightAnchor).isActive = true
        
        container.addSubview(editButton)
        editButton.heightAnchor.constraint(equalTo: title.heightAnchor).isActive = true
        editButton.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
        editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor).isActive = true
        editButton.trailingAnchor.constraint(equalTo: checkBox.leadingAnchor).isActive = true
        
        container.addSubview(shareButton)
        shareButton.heightAnchor.constraint(equalTo: editButton.heightAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor).isActive = true
        shareButton.topAnchor.constraint(equalTo: editButton.bottomAnchor).isActive = true
        shareButton.centerXAnchor.constraint(equalTo: checkBox.centerXAnchor).isActive = true
        
        container.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        container.addSubview(subtitle)
        subtitle.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor).isActive = true
//        subtitle.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    }
    
    func makeUnderline() {
        var attrString = NSAttributedString(string: title.text ?? "", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        title.attributedText = attrString
        attrString = NSAttributedString(string: timeLabel.text ?? "", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        timeLabel.attributedText = attrString
        attrString = NSAttributedString(string: subtitle.text ?? "", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        subtitle.attributedText = attrString
    }
    
    func makeNormal() {
        var attributeString = NSMutableAttributedString(string: title.text ?? "")
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        title.attributedText = attributeString
        
        attributeString = NSMutableAttributedString(string: timeLabel.text ?? "")
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        timeLabel.attributedText = attributeString
        
        attributeString = NSMutableAttributedString(string: subtitle.text ?? "")
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        subtitle.attributedText = attributeString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
