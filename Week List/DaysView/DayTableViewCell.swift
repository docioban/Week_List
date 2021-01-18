//
//  DayTableViewCell.swift
//  Week List
//
//  Created by Macbook Pro on 11/30/20.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    var day: Day? {
        didSet {
            guard let day = day else { return }
            self.title.text = day.name
            self.title.textColor = color.textColor
            self.subtitle.text = "\(day.subjects.count) subjects"
            self.subtitle.textColor = color.textColor
            self.container.backgroundColor = color.buttonColor
        }
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Subtitle"
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
