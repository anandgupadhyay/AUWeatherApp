//
//  AUWeatherAppTests.swift
//  AUWeatherAppTests
//
//  Created by Anand Upadhyay on 09/02/23.
//

import XCTest
@testable import AUWeatherApp
import Network

class AUWeatherAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class WeatherView: XCTestCase {
    var weatherVM: MokeWeatherViewModel?
    override func setUp(){
        weatherVM = MokeWeatherViewModel()
        bindWeatherModel()
    }
    
    override func tearDown() {
        weatherVM = nil
        super.tearDown()
    }
    
    func bindWeatherModel(){
        self.weatherVM?.weatherModel.bind { [weak self] newModel in
            DispatchQueue.main.async {
                if self?.weatherVM?.weatherModel.value?.weather != nil {
                    //Found Weather
                }
            }
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchWeatherFromFile() throws{
        weatherVM?.mokeFetchWeather(fileName: "SingleWeather", complete: { result in
            switch result {
            case .success(_):
                print("Got response")
                let rowCount: Int =  self.weatherVM?.weatherModel.value?.weather?.count ?? 0
                XCTAssertTrue(rowCount == 0,"No Weather To Show")
                //No need to handle UI Updates here as whenever a new weather will be updated and the binding will take place and trigger UI Update
            case .failure(let error):
                print("Error:\(error.localizedDescription)")
            }
        })
    }
    
    func testFetchWeatherFromSearchLocation(){
        let params : [String : String] = ["q" : "New York" , "units" : User.shared.tempratureUnit.rawValue,"appid" : NetworkHelperConstants.weatherAPIKey]
        weatherVM?.fetchWeather(params: params) { result in
            switch result {
            case .success(_):print("Got response")
                let rowCount: Int =  self.weatherVM?.weatherModel.value?.weather?.count ?? 0
                XCTAssertTrue(rowCount == 0,"No Weather To Show")
            case .failure(let error):
                print("Error:\(error.localizedDescription)")
            }
        }
    }
    
    func testFetchWeatherFromSearchCityId(){
        let params : [String : String] = ["id" : "1279233" , "units" : User.shared.tempratureUnit.rawValue, "appid" : NetworkHelperConstants.weatherAPIKey]
        weatherVM?.fetchWeather(params: params) { result in
            switch result {
            case .success(_):print("Got response")
                let rowCount: Int =  self.weatherVM?.weatherModel.value?.weather?.count ?? 0
                XCTAssertTrue(rowCount == 0,"No Weather To Show")
            case .failure(let error):
                print("Error:\(error.localizedDescription)")
            }
        }
    }
    
    func testNoWeatherForCityId(){
        let params : [String : String] = ["id" : "abcd" , "units" : User.shared.tempratureUnit.rawValue, "appid" : NetworkHelperConstants.weatherAPIKey]
        weatherVM?.fetchWeather(params: params) { result in
            switch result {
            case .success(_):print("Got response")
                let rowCount: Int =  self.weatherVM?.weatherModel.value?.weather?.count ?? 0
                XCTAssertNil(rowCount != 0,"No Weather To Show")
            case .failure(let error):
                print("Error:\(error.localizedDescription)")
            }
            XCTAssertNil(self.weatherVM?.weatherModel.value,"No Weather for City")
        }
    }
}
