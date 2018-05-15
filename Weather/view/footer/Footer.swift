import UIKit

/**
 * Represents the bottom-bar of the app (forcast for the next 5 days)
 */
class Footer :UIStackView{
    static let footerHeight:CGFloat = 90
    static let dayNames = Footer.createDayNames()
    lazy var dayViews:[DayView] = createDayViews()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bg = UIView()
        bg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        bg.backgroundColor = .red
        self.addSubview(bg)
        self.axis  = UILayoutConstraintAxis.horizontal
        self.distribution  = UIStackViewDistribution.equalSpacing
        self.alignment = UIStackViewAlignment.center
        self.spacing = 0
        _ = dayViews
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/**
 * Create
 */
extension Footer{
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
    /**
     * Creates Day views
     */
    private func createDayViews() -> [DayView]{
        let boxW:CGFloat = UIScreen.main.bounds.size.width / 5//75p on iphone 8
        let dayViews:[DayView] = Footer.dayNames.map{ day in
            let dayView = DayView.init(day:day)
            self.addArrangedSubview(dayView)
            _ = {//constraints
                dayView.translatesAutoresizingMaskIntoConstraints = false//(this enables you to set your own constraints)
                let size = Constraint.size(dayView, size: CGSize(width:boxW,height:Footer.footerHeight))
                NSLayoutConstraint.activate([size.w,size.h])
            }()
            return dayView//all vertically centered, 30p height each
        }
        return dayViews
    }
    /**
     *
     */
    static func createDayNames() -> [String] {
    
        let dayNames:[String] = (0..<5).indices.compactMap {
            let day = Date.offsetByDays(Date(), $0)
            return day.semiShortDayName
        }
        return dayNames
        
    }
}

