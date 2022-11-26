//
//  ListWorkTableViewCell.swift
//  CalendarListWork
//
//  Created by Степан Харитонов on 22.11.2022.
//

import Foundation
import UIKit

class ListWorkTableViewCell: UITableViewCell {
    
    let labelStartTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelFinalTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelWorkName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(labelStartTime)
        self.contentView.addSubview(labelFinalTime)
        self.contentView.addSubview(labelWorkName)
        constraintContent()
    }
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelWorkName.text = nil
    }
    
    private func constraintContent() {
        NSLayoutConstraint.activate([
            labelStartTime.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            labelStartTime.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            labelFinalTime.topAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            labelFinalTime.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            labelWorkName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            labelWorkName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 80),
            labelWorkName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
        ])
    }
}
