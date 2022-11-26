//
//  ViewController.swift
//  CalendarListWork
//
//  Created by Степан Харитонов on 19.11.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class MainViewController: UIViewController, FSCalendarDelegate {
    
    //MARK: Constants
    let buttonTransitionToCreateWorkVC = UIButton()
    let calendarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let listWorkBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 66/255, green: 170/255, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let listWorkTimeIntervals = CellsStaticContentInitialize.cellsStaticTimeInfo()
    
    //MARK: Properties
    var workArray: [Int: Work] = [:]
    var visualEffectView: UIView?
    var calendar = FSCalendar()
    var tableListWork = UITableView()
    var curentOrSelectDateLabel = UILabel()
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        setupSubviews()
        backgroundMainImage()
        foundationStyleViewAndSubviews()
        settingsCalendar()
        styleLabelListWorkView()
        registerCell()
        styleTableListWorkView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(
            x: calendarBackgroundView.frame.minX,
            y: 0,
            width: calendarBackgroundView.frame.width*0.95,
            height: calendarBackgroundView.frame.height*0.95)
        calendarBackgroundView.addSubview(calendar)
        
        curentOrSelectDateLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: listWorkBackgroundView.frame.width,
            height: listWorkBackgroundView.frame.height*0.1)
        listWorkBackgroundView.addSubview(curentOrSelectDateLabel)

        tableListWork.frame = CGRect(
            x: 0,
            y: curentOrSelectDateLabel.frame.maxY,
            width: listWorkBackgroundView.frame.width,
            height: listWorkBackgroundView.frame.height-curentOrSelectDateLabel.frame.maxY)
        listWorkBackgroundView.addSubview(tableListWork)
        
        buttonTransitionToCreateWorkVC.frame = CGRect(
            x: listWorkBackgroundView.frame.maxX*0.85,
            y: curentOrSelectDateLabel.frame.midY-listWorkBackgroundView.frame.maxX*0.1/2,
            width: listWorkBackgroundView.frame.maxX*0.1,
            height: listWorkBackgroundView.frame.maxX*0.1)
        buttonTransitionToCreateWorkVC.backgroundColor = UIColor.clear
        buttonTransitionToCreateWorkVC.layer.borderColor = UIColor.white.cgColor
        buttonTransitionToCreateWorkVC.layer.borderWidth = 0.5
        buttonTransitionToCreateWorkVC.layer.cornerRadius = listWorkBackgroundView.frame.maxX*0.1/2
        buttonTransitionToCreateWorkVC.setTitle("✛", for: .normal)
        buttonTransitionToCreateWorkVC.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        buttonTransitionToCreateWorkVC.addTarget(self, action: #selector(presentCreateWorkVC), for: .touchUpInside)
        self.listWorkBackgroundView.addSubview(buttonTransitionToCreateWorkVC)
    }
}

//MARK: BG-Subviews setup
extension MainViewController {
    private func setupSubviews() {
        self.view.addSubview(calendarBackgroundView)
        self.view.addSubview(listWorkBackgroundView)
        NSLayoutConstraint.activate([
            calendarBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            calendarBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            calendarBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            calendarBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            listWorkBackgroundView.topAnchor.constraint(equalTo: calendarBackgroundView.bottomAnchor, constant: 15),
            listWorkBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            listWorkBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            listWorkBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
        ])
    }
}

//MARK: Style elements
extension MainViewController {
    private func foundationStyleViewAndSubviews() {
        calendarBackgroundView.layer.cornerRadius = 20
        calendarBackgroundView.layer.masksToBounds = true
        listWorkBackgroundView.layer.cornerRadius = 20
        listWorkBackgroundView.layer.masksToBounds = true
    }
    
    private func backgroundMainImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "backgroundImage")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func settingsCalendar() {
        calendar.firstWeekday = 2
        calendar.locale = Locale.init(identifier: "en")
    }
    
    private func styleLabelListWorkView() {
        self.curentOrSelectDateLabel.textAlignment = .center
        self.curentOrSelectDateLabel.textColor = .white
    }
    
    private func styleTableListWorkView() {
        tableListWork.backgroundColor = UIColor.white
    }
}

//MARK: Action select date
extension MainViewController {
    
    // Methods framework FSCalendar
    // Updating label and Table when date pressed
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM , EEEE"
        let selectDate = formatter.string(from: date)
        loadSelectDayWork(filterDate: date)
        UIView.transition(
            with: curentOrSelectDateLabel,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                [weak self] in
                self?.curentOrSelectDateLabel.text = selectDate
                },
            completion: nil)
        self.tableListWork.reloadData()
    }
    
    // Methods framework FSCalendar
    // Initialization Label and Table curent date at the start app
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        if cell.dateIsToday {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM , EEEE"
            let selectDate = formatter.string(from: date)
            loadSelectDayWork(filterDate: date)
            curentOrSelectDateLabel.text = selectDate
            self.tableListWork.reloadData()
        }
    }
}

//MARK: Table view
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWorkTimeIntervals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as? ListWorkTableViewCell else {
            return UITableViewCell()
        }
        let staticTimeSplitCell = listWorkTimeIntervals[indexPath.row]
        cell.labelStartTime.text = "\(staticTimeSplitCell.startTimeHour):00"
        cell.labelFinalTime.text = "\(staticTimeSplitCell.finalTimeHour):00"
        if workArray != [:] {
            for (_, c) in workArray {
                if Int(ArraySplitDate.arraySplitDate(work: c)[0]) == staticTimeSplitCell.startTimeHour || Int(ArraySplitDate.arraySplitDate(work: c)[0])! < staticTimeSplitCell.startTimeHour && Int(ArraySplitDate.arraySplitDate(work: c)[1])! >= staticTimeSplitCell.finalTimeHour{
                    cell.labelWorkName.text = c.nameWork
                    cell.backgroundColor = UIColor(red: 66/255, green: 170/255, blue: 1, alpha: 1)
                    cell.isUserInteractionEnabled = true
                    workArray.updateValue(c, forKey: indexPath.row)
                    break
                }
            }
        }
        if cell.labelWorkName.text == nil {
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = UIColor.clear
            cell.labelWorkName.text = "Free time"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = DetailsSelectDayViewController()
        let itemWork = workArray[indexPath.row]
        destination.textNameWork = itemWork?.nameWork
        destination.textDescriptionWork = itemWork?.descriptionWork
        self.present(destination, animated: true)
        
    }
    
    private func registerCell() {
        tableListWork.delegate = self
        tableListWork.dataSource = self
        tableListWork.register(ListWorkTableViewCell.self, forCellReuseIdentifier: "contentCell")
    }
}

//MARK: Realm Module
extension MainViewController {
    func loadSelectDayWork(filterDate: Date) {
        self.workArray = [:]
        let startAndEndDate = DateFormatterDiapason.dateFormatt(date: filterDate)
        do {
            let realm = try Realm()
            let dayWorkData = realm.objects(Work.self)
            let filterDayWorkData = dayWorkData.filter("startTime BETWEEN {%@,%@}" ,startAndEndDate[0], startAndEndDate[1])
            filterDayWorkData.forEach() {
                self.workArray[0] = $0
            }
        } catch {
            print(error)
        }
    }
}

//MARK: Present CreateWork VC
extension MainViewController {
    @objc func presentCreateWorkVC(sender: UIButton) {
        let createWorkVC: CreateWorkViewController = CreateWorkViewController()
        self.present(createWorkVC, animated: true)
    }
}



