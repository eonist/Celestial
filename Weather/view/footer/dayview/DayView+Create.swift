
import UIKit

extension DayView{
    /**
     * Create Day Label
     */
    func createDayLabel() -> UILabel{
        let dayLabel = UILabel()//add day label
        dayLabel.text = day
        dayLabel.font = .boldSystemFont(ofSize: 12)//dayLabel.font.withSize(12)
        dayLabel.textAlignment = .center
        //dayLabel.backgroundColor = .yellow
        dayLabel.textColor = .black//UIColor(hex:"EBCF4B")
        self.addSubview(dayLabel)
        dayLabel.activateConstraint{ view in
            let anchor = Constraint.anchor(dayLabel, to: self, align:.topCenter, alignTo: .topCenter)
            let height = Constraint.height(dayLabel, height: 30)
            let width = Constraint.width(dayLabel, to: self)
            return [anchor.x,anchor.y,width,height]
        }
        return dayLabel
    }
    /**
     * Create WeatherIcon
     */
    func createWeatherIcon() -> UIImageView{
        let imageView = UIImageView()
        //imageView.backgroundColor = .purple
        self.addSubview(imageView)
        imageView.activateConstraint{ view in
            let anchor = Constraint.anchor(view, to: self, align:.centerCenter, alignTo: .centerCenter)
            let height = Constraint.height(view, height: 19)
            let width = Constraint.width(view, width: 19)
            return [anchor.x,anchor.y,width,height]
        }
        return imageView
    }
    /**
     * Create Degree Label
     */
    func createDegLabel() -> UILabel{
        let degLabel = UILabel()
        degLabel.text = "5°C"
        degLabel.font = degLabel.font.withSize(12)
        degLabel.textAlignment = .center
        //degLabel.backgroundColor = .blue
        degLabel.textColor = .black//UIColor(hex:"EBCF4B")
        self.addSubview(degLabel)
        degLabel.activateConstraint{ view in
            view.translatesAutoresizingMaskIntoConstraints = false
            let anchor = Constraint.anchor(view, to: self, align:.bottomCenter, alignTo: .bottomCenter)
            let height = Constraint.height(view, height: 30)
            let width = Constraint.width(view, to: self)
            return [anchor.x,anchor.y,width,height]
        }
        return degLabel
    }
}
//    let loc:Loc = Loc.init(lat:59.911491, long:10.757933)
//    let weatherList:[WeatherModel] = MetWeatherService().weeklyForcast(loc: loc)
//    weatherList.enumerated().forEach{ (i,obj) in
//    Swift.print("Day \(i):  Temprature: \(obj.temperature) Type: \(obj.weatherType)")
//    }
