//
//  DetailsSelectDayVIewController.swift
//  CalendarListWork
//
//  Created by Степан Харитонов on 23.11.2022.
//

import UIKit

class DetailsSelectDayViewController: UIViewController {
    
    //MARK: Constant
    let labelNameWork: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let labelDescriptionWork: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Properties
    var textNameWork: String?
    var textDescriptionWork: String?
    var visualEffectView: UIView?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = .clear
        addSubviews()
        blurMotion()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleSubviews()
    }
    
    private func addSubviews() {
        self.view.addSubview(labelNameWork)
        self.view.addSubview(labelDescriptionWork)
    }
    
    private func styleSubviews() {
        labelNameWork.frame = CGRect(
            x: 0,
            y: 10,
            width: self.view.frame.width,
            height: self.view.frame.height*0.1)
        labelNameWork.textAlignment = .center
        labelNameWork.text = textNameWork
        labelDescriptionWork.frame = CGRect(
            x: 40,
            y: labelNameWork.frame.maxY+5,
            width: self.view.frame.width-80,
            height: self.view.frame.height*0.8)
        labelDescriptionWork.textAlignment = .center
        labelDescriptionWork.numberOfLines = 0
        labelDescriptionWork.text = textDescriptionWork
    }
    
    private func blurMotion() {
        let blurEffect = UIBlurEffect(style: .light)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            visualEffectView.frame = self.view.frame
            self.view.addSubview(visualEffectView)
            self.view.sendSubviewToBack(visualEffectView)
            self.visualEffectView = visualEffectView
        visualEffectView.alpha = 1
    }
}
