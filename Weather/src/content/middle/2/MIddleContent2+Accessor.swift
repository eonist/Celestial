import UIKit
import Spatial

extension MiddleContent2 {
   /**
    * New
    */
   func setBackgroundColor(color:UIColor){
      let card:UIView = cardMode == .now ? firstCard : secondCard
//      card.backgroundColor = color
   }
   /**
    * New
    */
   func setWeather(weatherModel:WeatherModel){
      if cardMode == .now {
         firstCard.degLabel.text = "\(weatherModel.temperature)°C"
         //        Swift.print("weather.weatherType:  \(weather.weatherType)")
         //        Swift.print("Consts.weatherTypes.count:  \(Consts.weatherTypes.count)")
         let idx:Int = Int(Double(weatherModel.weatherType)!)
         guard let weatherType:String = Consts.weatherTypes[idx] else {fatalError("error no weather symbol for idx: \(idx)")}
         firstCard.kindLabel.text = "\(weatherType)"
         
         guard let url = URL(string: Consts.imageURL(weatherModel.weatherType)) else {fatalError("error invalid url")}
         firstCard.weatherIcon.contentMode = .scaleAspectFit
         DispatchQueue.global(qos: .background).async {
            self.firstCard.weatherIcon.downloadImage(url: url)
         }
      }else{
         //set hour forcasts
      }
   }
}
