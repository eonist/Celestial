import Foundation

protocol WeatherService{//we use a protocol so we can switch out the API with ease
    func hourlyForcast(loc:Loc) -> WeatherModel
}
/**
 * MET weather service (yr.no etc)
 */
struct MetWeatherService:WeatherService{
    /**
     * Returns weather for the next hour from now
     */
    func hourlyForcast(loc:Loc)-> WeatherModel{
        guard let nextHour:Date = Date.offsetByHours(Date(), 1) else {fatalError("err with date")}//⚠️️ TODO: figure out the timezone difference
        
        //let curHourlyForcast:Forcast =
        //Yields 5 results. The first has the temp, the other 4 has past hour weather type data.
        let weather = getWeatherForDate(loc: loc, nextHour, timeType: .hour)
        return weather
    }
    /**
     * Returns 1 weatherModel for each day the next 5 days
     */
    func weeklyForcast(loc:Loc) -> [WeatherModel]{
        let fiveDates:[Date] = fiveDays //get weathermodel for each date and return them
        let weatherList:[WeatherModel] = fiveDates.map {
            Swift.print("$0:  \($0)")
            return getWeatherForDate(loc: loc, $0, timeType: .day)
        }
        return weatherList
    }
}
/**
 * Utils
 */
extension MetWeatherService{
    enum TimeType{
        case day, hour
    }
    /**
     * returns weathermodel for date and forcasts
     */
    fileprivate func getWeatherForDate(loc:Loc,_ targetDate:Date, timeType:TimeType) -> WeatherModel{
        let parser:WeatherXMLParser = self.weather(loc:loc)
        let matches:[Forcast] = parser.forcasts.filter {
            guard let fromDate:Date = $0.from.date else {fatalError("err in xml")}
            guard let toDate:Date = $0.to.date else {fatalError("err in xml")}
            switch timeType {
            case .hour:
                if Date.assertHour(fromDate,with:targetDate) && Date.assertHour(toDate,with:targetDate) {return true}//forcast from this hour with temperature
                if $0.symbol != nil && Date.assertHour(toDate,with:targetDate) {return true}//forcast from this hour with symbol
            case .day:
                if Date.assertDay(fromDate,with:targetDate) && Date.assertDay(toDate,with:targetDate) {return true}//forcast from this hour with temperature
                if $0.symbol != nil && Date.assertDay(toDate,with:targetDate) {return true}//forcast from this hour with symbol
            }
            
            
            return false
        }
        //        Swift.print("matches.count:  \(matches.count)")
        //        matches.forEach{
        //            Swift.print("$0.from:  \($0.from.date) $0.to:  \($0.to.date)")
        //            if let symbol = $0.symbol {
        //                Swift.print("symbol:  \(symbol)")
        //            }
        //            if let temperature = $0.temperature{
        //                Swift.print("temperature:  \(temperature)")
        //            }
        //        }
        let weather = weatherModel(matches: matches)
        return weather
    }
    /**
     *
     */
    func weatherModel(matches:[Forcast]) -> WeatherModel{
        let hourlyForcast:Forcast = {
            guard let from:String = matches[safe:0]?.from else {fatalError("err in xml")}
            guard let to:String = matches[safe:0]?.to else {fatalError("err in xml")}
            guard let symbol:String = matches[safe:1]?.symbol else {fatalError("err in xml")}
            guard let temperature:String = matches[safe:0]?.temperature  else {fatalError("err in xml")}
            return Forcast.init(from: from, to: to, symbol: symbol, temperature: temperature)
        }()
        
        //        Swift.print("hourlyForcast0.from:  \(hourlyForcast.from.date) $hourlyForcast.to:  \(hourlyForcast.to.date)")
        guard let symbol = hourlyForcast.symbol else { fatalError("err in xml") }
        Swift.print("symbol:  \(symbol)")
        
        guard let temperature = hourlyForcast.temperature, let temperatureAsDouble = Double(temperature) else { fatalError("err in xml or cant cast string to double") }
        Swift.print("temperature:  \(temperature)")
        
        let weather = WeatherModel.init(weatherType: symbol, temperature: temperatureAsDouble)
        return weather
    }
    enum URLS {
        static let YR_LOCATION_FORECAST = "https://api.met.no/weatherapi/locationforecast/1.9"
        static let YR_WEATHER_ICON = ""
    }
    /**
     * Returns weathermodel for url for the next hour from now
     * ref: https://github.com/skogland/WeatherApp/blob/cc8036c860706b2f0100cceaea06a1552636cb13/WeatherApp/WeatherApp/LocationForecastDataParser.swift
     */
    private func weather(loc:Loc) -> WeatherXMLParser{
        let parser = WeatherXMLParser()
        let url = URLS.YR_LOCATION_FORECAST + "/?lat=\(loc.lat)&lon=\(loc.long)"
        parser.initiate(url:url)
        Swift.print("parser.forcasts.count:  \(parser.forcasts.count)")
        
//        
//        parser.forcasts.forEach{
//            Swift.print("$0.from:  \($0.from.date) $0.to:  \($0.to.date)")
//            if let symbol = $0.symbol {
//                Swift.print("symbol:  \(symbol)")
//            }
//            if let temperature = $0.temperature{
//                Swift.print("temperature:  \(temperature)")
//            }
//        }
//        

        
        return parser
    }
}
/**
 * Time utils
 */
extension MetWeatherService {
    var fiveDays:[Date] {
        let today = Date()
        let day:Int = today.day
        let month:Int = today.month
        let year:Int = today.year
        
        
        guard let todayAtNoon:Date = Date.createDate(year, month, day, 13, 00) else {fatalError("err creating date")}
        
        let day2AtNoon:Date = Date.offsetByDays(todayAtNoon, 1)
        let day3AtNoon:Date = Date.offsetByDays(todayAtNoon, 2)
        let day4AtNoon:Date = Date.offsetByDays(todayAtNoon, 3)
        let day5AtNoon:Date = Date.offsetByDays(todayAtNoon, 4)
        return [todayAtNoon,day2AtNoon,day3AtNoon,day4AtNoon,day5AtNoon]
    }
}
