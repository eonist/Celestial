import UIKit

extension DayView{
    /**
     * Update degLabel and weatherIcon
     */
    func setWeather(_ weather:WeatherModel){
        self.degLabel.text = "\(weather.temperature)°C"
        guard let url = URL(string: Consts.imageURL(weather.weatherType)) else {fatalError("error invalid url")}
        weatherIcon.contentMode = .scaleAspectFit
        self.weatherIcon.downloadImage(url: url)
    }
}

