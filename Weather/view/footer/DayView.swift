import UIKit

class DayView:UIView{
    lazy var dayLabel:UILabel = createDayLabel()
    lazy var weatherIcon:UIImageView = createWeatherIcon()
    lazy var degLabel:UILabel = createDegLabel()
    var day:String
    init(day:String) {
        self.day = day
        super.init(frame: .zero)
//        self.backgroundColor = .cyan
        _ = dayLabel
        _ = weatherIcon
        _ = degLabel
    }
    /**
     * Boilerplate
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
