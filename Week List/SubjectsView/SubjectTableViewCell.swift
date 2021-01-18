//
//  SubjectTableViewCell.swift
//  Week List
//
//  Created by Macbook Pro on 11/30/20.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    var subject: Subject? {
        didSet {
            guard let subject = subject else { return }
            self.title.text = subject.subject
            self.timeLabel.text = subject.timeToString()
            self.subtitle.text = subject.info
        }
    }
    
    let title: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = color.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        
        container.addSubview(editButton)
        editButton.heightAnchor.constraint(equalTo: title.heightAnchor).isActive = true
        editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor).isActive = true
        editButton.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
        editButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        
        container.addSubview(shareButton)
        shareButton.heightAnchor.constraint(equalTo: editButton.heightAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor).isActive = true
        shareButton.topAnchor.constraint(equalTo: editButton.bottomAnchor).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        
        container.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        
        container.addSubview(subtitle)
        subtitle.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20).isActive = true
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
