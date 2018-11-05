import UIKit

class WeatherCard:UIView{
    lazy var degLabel:UILabel = createDeglabel()
    lazy var kindLabel:UILabel = createkindLabel()
    lazy var weatherIcon:UIImageView = createWeatherIcon()
    override init(frame: CGRect) {
        super.init(frame:frame)
        _ = degLabel
        _ = kindLabel
        _ = weatherIcon
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
