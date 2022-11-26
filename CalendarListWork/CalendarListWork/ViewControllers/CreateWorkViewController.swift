//
//  CreateWorkViewController.swift
//  CalendarListWork
//
//  Created by Степан Харитонов on 23.11.2022.
//

import UIKit
import RealmSwift

class CreateWorkViewController: UIViewController {
    
    //MARK: Constant
    let confirmWorkButton = UIButton()
    let closeThisScreen = UIButton()
    let nameWorkTextField = UITextField()
    let descriptionWorkTextField = UITextField()
    let datePickerStartWork = UIDatePicker()
    let datePickerFinalWork = UIDatePicker()
    let labelDateStartWork: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let labelDateFinalWork: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Properties
    var visualEffectView: UIView?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clear
        addSubviewsToView()
        blurMotion()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleConfirmWorkButton()
        styleCloseThisScreenButton()
        styleWorkTextField(textField: nameWorkTextField)
        styleWorkTextField(textField: descriptionWorkTextField)
        styleLabel(label: labelDateStartWork)
        styleDatePicker(datePicker: datePickerStartWork)
        styleLabel(label: labelDateFinalWork)
        styleDatePicker(datePicker: datePickerFinalWork)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            if let firstVC = presentingViewController as? MainViewController {
                DispatchQueue.main.async {
                    if let date = firstVC.calendar.selectedDate {
                        firstVC.loadSelectDayWork(filterDate: date)
                        firstVC.tableListWork.reloadData()
                    }
                }
            }
        }
    
    //MARK: Private func
    private func addSubviewsToView() {
        self.view.addSubview(nameWorkTextField)
        self.view.addSubview(labelDateStartWork)
        self.view.addSubview(datePickerStartWork)
        self.view.addSubview(labelDateFinalWork)
        self.view.addSubview(datePickerFinalWork)
        self.view.addSubview(descriptionWorkTextField)
        self.view.addSubview(confirmWorkButton)
        self.view.addSubview(closeThisScreen)
    }
    
    private func styleConfirmWorkButton() {
        confirmWorkButton.frame = CGRect(
            x: self.view.frame.maxX-15-confirmWorkButton.frame.width,
            y: self.view.safeAreaLayoutGuide.layoutFrame.maxY-confirmWorkButton.frame.height,
            width: self.view.frame.maxX*0.3,
            height: 50)
        confirmWorkButton.backgroundColor = UIColor(red: 66/255, green: 170/255, blue: 1, alpha: 1)
        confirmWorkButton.layer.cornerRadius = 15
        confirmWorkButton.setTitle("Confirm", for: .normal)
        confirmWorkButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        confirmWorkButton.titleLabel?.textColor = UIColor.white
        confirmWorkButton.addTarget(self, action: #selector(addNewWorkInRealm), for: .touchUpInside)
    }
    private func styleCloseThisScreenButton() {
        closeThisScreen.frame = CGRect(
            x: 15,
            y: self.view.safeAreaLayoutGuide.layoutFrame.maxY-confirmWorkButton.frame.height,
            width: self.view.frame.maxX*0.3,
            height: 50)
        closeThisScreen.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        closeThisScreen.layer.cornerRadius = 15
        closeThisScreen.setTitle("Close", for: .normal)
        closeThisScreen.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        closeThisScreen.addTarget(self, action: #selector(closeThisScreenMethod), for: .touchUpInside)
    }
    private func styleWorkTextField(textField: UITextField) {
        textField.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = 15
        textField.attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        switch textField {
        case nameWorkTextField:
            textField.frame = CGRect(
                x: self.view.frame.midX-textField.frame.width/2,
                y: 30,
                width: 300,
                height: 40)
            textField.placeholder = "Name Work"
            textField.textAlignment = .center
        case descriptionWorkTextField:
            textField.frame = CGRect(
                x: self.view.frame.midX-textField.frame.width/2,
                y: nameWorkTextField.frame.maxY+10,
                width: 300,
                height: 80)
            textField.placeholder = "Description this work"
            textField.textAlignment = .center
        default:
            break
        }
    }
    private func styleLabel(label: UILabel) {
        label.textColor = UIColor.black
        label.textAlignment = .center
        switch label {
        case labelDateStartWork:
            label.text = "Date start"
            label.frame = CGRect(
                x: 0,
                y: descriptionWorkTextField.frame.maxY+50,
                width: self.view.frame.width,
                height: 15)
        case labelDateFinalWork:
            label.text = "Date final"
            label.frame = CGRect(
                x: 0,
                y: datePickerStartWork.frame.maxY+10,
                width: self.view.frame.width,
                height: 15)
        default: break
        }
    }
    private func styleDatePicker(datePicker: UIDatePicker) {
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.datePickerMode = .dateAndTime
        datePicker.contentHorizontalAlignment = .center
        datePicker.tintColor = UIColor.black
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.locale = Locale(identifier: "ru_GB")
        switch datePicker {
        case datePickerStartWork:
            datePicker.minimumDate = .now
            datePicker.frame = CGRect(
                x: self.view.frame.midX-datePicker.frame.width/2,
                y: labelDateStartWork.frame.maxY,
                width: 300,
                height: 50)
        case datePickerFinalWork:
            datePicker.minimumDate = datePickerStartWork.date
            datePicker.frame = CGRect(
                x: self.view.frame.midX-datePicker.frame.width/2,
                y: labelDateFinalWork.frame.maxY,
                width: 300,
                height: 50)
        default: break
        }
    }
    
    //MARK: Alert control
    private func alertController(nameError: String) {
        let alertController = UIAlertController(title: nameError, message: nil, preferredStyle: .alert)
        let closeAlert = UIAlertAction(title: "Close", style: .default) 
        alertController.addAction(closeAlert)
        present(alertController, animated: true, completion: nil)
    }
    //MARK: Blur effect
    private func blurMotion() {
        let blurEffect = UIBlurEffect(style: .light)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            visualEffectView.frame = self.view.frame
            self.view.addSubview(visualEffectView)
            self.view.sendSubviewToBack(visualEffectView)
            self.visualEffectView = visualEffectView
        visualEffectView.alpha = 1
    }
    
    //MARK: @Objc methods
    @objc func closeThisScreenMethod(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func addNewWorkInRealm(sender: UIButton) {
        let newWork = Work()
        if nameWorkTextField.text != nil && nameWorkTextField.text != "" {
            newWork.nameWork = nameWorkTextField.text!
            if descriptionWorkTextField.text != nil {
                newWork.descriptionWork = descriptionWorkTextField.text!
            } else {
                newWork.descriptionWork = "There is no description"
            }
            newWork.startTime = datePickerStartWork.date
            if datePickerFinalWork.date != datePickerStartWork.date {
                newWork.finalTime = datePickerFinalWork.date
            }
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.add(newWork)
                try realm.commitWrite()
                self.dismiss(animated: true)
            } catch {
                print(error)
                alertController(nameError: "Oh, something went wrong(")
            }
        } else {
            alertController(nameError: "The task name is missing!")
        }
        
    }
    
    
}
