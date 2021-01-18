//
//  SubjectTaskTableViewCell.swift
//  Week List
//
//  Created by Macbook Pro on 12/5/20.
//

import UIKit

class SubjectTaskTableViewCell: UITableViewCell {

    var object: Object? {
        didSet {
            guard let object = object else { return }
            self.title.text = object.name
            self.subtitle.text = "\(object.tasks.count) tasks"
            self.container.backgroundColor = color.buttonColor
            self.title.textColor = color.textColor
            self.subtitle.textColor = color.textColor
        }
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(container)
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        container.addSubview(title)
        container.addSubview(subtitle)
        
        title.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        subtitle.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
