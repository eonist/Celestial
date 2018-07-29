import UIKit
/**
 * Update
 */
extension Page{
    /**
     * Updates the weather for the page
     */
    func setWeather(_ weather:WeatherModel){
        card.degLabel.text = "\(weather.temperature)°C"
        Swift.print("weather.weatherType:  \(weather.weatherType)")
        Swift.print("Consts.weatherTypes.count:  \(Consts.weatherTypes.count)")
        let idx:Int = Int(Double(weather.weatherType)!)
        guard let weatherType:String = Consts.weatherTypes[idx] else {fatalError("error no weahter symbol for idx: \(idx)")}
        card.kindLabel.text = "\(weatherType)"
        
        guard let url = URL(string: Consts.imageURL(weather.weatherType)) else {fatalError("error invalid url")}
        card.weatherIcon.contentMode = .scaleAspectFit
        card.weatherIcon.downloadImage(url: url)
        //weatherIcon = img
    }
}

