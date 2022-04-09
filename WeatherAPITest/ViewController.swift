//
//  ViewController.swift
//  WeatherAPITest
//
//  Created by Jaewon on 2022/04/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFetchWeatherInfo(_ sender: UIButton) {
        guard let cityName = cityNameTextField.text else { return }
        self.getWeatherInfo(cityName: cityName)
        self.view.endEditing(true)
    }
    
    func updateView(weatherInfo: WeatherInfo) {
        self.cityNameLabel.text = weatherInfo.name
        self.cityWeatherLabel.text = weatherInfo.weather.first?.description
    }
    
    func getWeatherInfo(cityName: String) {
        let apiKey = Storage().apiKey
        // url 지정
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)") else { return }
        
        // 기본 세션 생성
        let session = URLSession(configuration: .default)
        // Task를 통해 작업 추가
        session.dataTask(with: url) { data, response, error in
            // Completion Handler 작성
            guard let data = data, error == nil else { return } // 에러가 나지 않고 data를 가져옴
            // JSONDecoder 생성
            let decoder = JSONDecoder()
            // 지정한 구조체 형식에 맞춰서 data를 decode
            guard let weatherInfo = try? decoder.decode(WeatherInfo.self, from: data) else { return }
            // 메인쓰레드에서 작업이 되도록 지정
            DispatchQueue.main.async {
                self.updateView(weatherInfo: weatherInfo)
            }
        }.resume()
    }
    
}

