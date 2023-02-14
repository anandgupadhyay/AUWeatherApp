//
//  WeatherViewController.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//

import UIKit
import Foundation
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tblWeather: UITableView!
    @IBOutlet weak var barBtnHistory: UIBarButtonItem!{
        didSet{
            barBtnHistory.primaryAction = nil
            barBtnHistory.accessibilityIdentifier = "HistoryButton"
            barBtnHistory.menu = self.createContextMenu()
        }
    }
    
    //MARK: Private Properties
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var weatherVM = WeatherViewModel()
    let locationPickView: LocationInputView = .fromNib()
    override func viewDidLoad(){
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Setup UI , Reload and Observer Binding
    func setupView(){
        //No Data View
        showNoDataView()
        //Title
        self.title = AppMessages.AppTitle
        //Tableview
        tblWeather.adjustSeperatorInsent()
        tblWeather.dataSource = self
        //Header View
        locationPickView.delegate = self
        tblWeather.tableHeaderView = locationPickView
        //Location Manager
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy =  kCLLocationAccuracyBest
        //Binding Observer
        bindWeatherModel()
        //Reachability
        Reachability.shared.startMonitoring()
        //        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name:  Reachability.connectionStatusHasChangedNotification, object: nil)
    }
    
    /// Reload Weather UI
    func reloadWeatherUI(){
        if weatherVM.weatherModel.value?.weather != nil {
            //Found Weather
            hideNoDataView()
            locationPickView.closeKeyboard(isClear: true)
        }else{
            //Not Found
            showNoDataView()
        }
        tblWeather.reloadData()
    }
    
    /// Binding of Observer
    func bindWeatherModel(){
        weatherVM.weatherModel.bind { [weak self] newModel in
            DispatchQueue.main.async {
                self?.reloadWeatherUI()
                self?.barBtnHistory.menu =  self?.createContextMenu()
            }
        }
    }
    
    // MARK: - Error / No Data Handling
    
    /// Show Common Alert
    /// - Parameter message: Alert Message
    func showAlert(message: String){
        openAlert(title: AppMessages.AppTitle, message: message,  alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default],actions: [
            { _ in
            }
        ])
    }
    
    /// No Data Label
    private lazy var nodataView: NoDataView = {
        let ndV: NoDataView = Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)?.first as! NoDataView
        ndV.center = view.center
        ndV.setupSelectLocatin()
        return ndV
    }()
    
    /// Show No Data View
    func showNoDataView(){
        view.addSubview(nodataView)
        view.bringSubviewToFront(nodataView)
    }
    
    /// Hide No Data View
    func hideNoDataView() {
        nodataView.removeFromSuperview()
    }
}

//MARK: - Weather History Menu
extension WeatherViewController{
    
    /// Create Context Menu for History Button
    /// - Returns: UIMenu menu list
    func createContextMenu() -> UIMenu {
        
        var menuList = [UIAction]()
        guard let historyList = HistoryProvider.readWeatherHistory() else{
            let noHisotryAction = UIAction(title: AppMessages.NoWeatherHistoryMessage, image: UIImage(systemName: "list.number")) { _ in
            }
            return UIMenu(title: AppMessages.WeatherHistoryTitle, image: nil, identifier: .edit, options: .singleSelection, children: [noHisotryAction])
        }
        
        menuList = historyList.enumerated().map { index,weather in
            return UIAction(
                title: weather.name!,
                identifier: UIAction.Identifier("HistoryMenu\(index + 1)")) { action in
                    print(action.title)
                    self.weatherVM.weatherModel.value = weather
                }
        }
        
        //Add Clear History Action
        var removeRatingAttributes = UIMenuElement.Attributes.destructive
        //enable or disable action based on the count
        if historyList.count == 0 {
          removeRatingAttributes.insert(.disabled)
        }
        let deleteImage = UIImage(systemName: "trash.fill")
        let clearHistory = UIAction(
          title: AppMessages.ClearHistoryTitle,
          image: deleteImage,
          identifier: UIAction.Identifier("ClearHisotyr"),
          attributes: removeRatingAttributes) { _ in
              HistoryProvider.clearWeatherHistory()
              self.barBtnHistory.menu = self.createContextMenu()
        }
        menuList.append(clearHistory)
        
        return UIMenu(title: AppMessages.WeatherHistoryTitle, image: UIImage(systemName: "list.number"), identifier: .edit, options: .singleSelection, children: menuList)
    }
    
        
        
      
}
