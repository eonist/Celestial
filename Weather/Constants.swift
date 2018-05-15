import Foundation

class Consts{
    static let weatherTypes:[Int:String] = [1:"Sun",2:"LightCloud",3:"PartlyCloud",4:"Cloud",5:"LightRainSun",6:"LightRainThunderSun",7:"SleetSun",8:"SnowSun",9:"LightRain",10:"Rain",11:"RainThunder",12:"Sleet",13:"Snow",14:"SnowThunder",15:"Fog",20:"SleetSunThunder",21:"SnowSunThunder",22:"LightRainThunder",23:"SleetThunder",24:"DrizzleThunderSun",25:"RainThunderSun",26:"LightSleetThunderSun",27:"HeavySleetThunderSun",28:"LightSnowThunderSun",29:"HeavySnowThunderSun",30:"DrizzleThunder",31:"LightSleetThunder",32:"HeavySleetThunder",33:"LightSnowThunder",34:"HeavySnowThunder",40:"DrizzleSun",41:"RainSun",42:"LightSleetSun",43:"HeavySleetSun",44:"LightSnowSun",45:"HeavysnowSun",46:"Drizzle",47:"LightSleet",48:"HeavySleet",49:"LightSnow",50:"HeavySnow"]
    static var imageURL:(_ weatherType:String) -> String = {
        return "https://api.met.no/weatherapi/weathericon/1.1/?symbol=\($0)&content_type=image/png"
    }
}

struct City {
    static var cities:[City] = {
        let oslo:City = .init(cityName: "Oslo", coordinate: (lat:59.911491, long:10.757933))//is , and the longitude is .
        let sanFrancisco:City = .init(cityName: "San Francisco", coordinate: (lat:37.7749, long:-122.4194))
        //San fran, Oslo, Milano, New york, London, Los angels, Paris,
        let stockholm:City = .init(cityName: "Stockholm", coordinate: (lat:59.3293, long:18.063240))//long: , lat
        let paris:City = .init(cityName: "Paris", coordinate: (lat:2.349014, long:48.8566))//long: , lat//Longitude‎: ‎2.349014,lat: 48.8566
        let london:City = .init(cityName: "London", coordinate: (lat:51.5074, long:-0.118092))//Longitude‎: ‎, lat
        let barcelona:City = .init(cityName: "Barcelona", coordinate: (lat:41.390205, long:2.154007))//long ,lat: ‎
        return [oslo,london,sanFrancisco,barcelona,stockholm,paris]
    }()
    let cityName:String
    let coordinate:(long:Double,lat:Double)
}



