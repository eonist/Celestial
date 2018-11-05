import UIKit

/**
 * Update
 */
extension BottomBar{
    /**
     * Updates the dayviews
     */
    func updateWeather(idx:Int){
        let coordinate = VC.citiesAndColors[idx].city.coordinate
        let loc:Loc = Loc.init(lat:coordinate.lat, long:coordinate.long)
        let forcastForThe5NextDays:[WeatherModel] = MetWeatherService().weeklyForcast(loc: loc)
        //forcastForThe5NextDays.enumerated().forEach{ (i,obj) in Swift.print("Day \(i):  Temprature: \(obj.temperature) Type: \(obj.weatherType)")  }
        setWeather(weatherList:forcastForThe5NextDays)
    }
    /**
     * Sets the weather
     */
    func setWeather(weatherList:[WeatherModel]){
        guard weatherList.count == dayViews.count else {Swift.print("Footer.swift - array out of bound");return}
        dayViews.indices.forEach { idx in
            dayViews[idx].setWeather(weatherList[idx])
        }
    }
}
