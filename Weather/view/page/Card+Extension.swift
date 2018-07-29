import UIKit

extension Card{
    /**
     * DegLabel
     */
    func createDeglabel() -> UILabel{
        let degLabel = UILabel()
        degLabel.text = "5°C"
        degLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
        degLabel.textAlignment = .center
        //        degLabel.backgroundColor = .blue
        degLabel.textColor = .black//UIColor(hex:"EBCF4B")
        self.addSubview(degLabel)
        _ = {
            degLabel.translatesAutoresizingMaskIntoConstraints = false
            let anchor = Constraint.anchor(degLabel, to: self, align:.bottomCenter, alignTo: .bottomCenter)
            let height = Constraint.height(degLabel, to: self)
            let width = Constraint.width(degLabel, to: self)
            NSLayoutConstraint.activate([anchor.x,anchor.y,width,height])
        }()
        return degLabel
    }
    /**
     * kindLabel
     * NOTE: weather type api: https://api.met.no/weatherapi/weathericon/_/documentation/
     */
    func createkindLabel() -> UILabel{
        let kindLabel = UILabel()
        kindLabel.text = "Clear skies"
        kindLabel.font = kindLabel.font.withSize(20)
        kindLabel.textAlignment = .center
        //        kindLabel.backgroundColor = .gray
        kindLabel.textColor = .black//UIColor(hex:"EBCF4B")
        self.addSubview(kindLabel)
        _ = {
            kindLabel.translatesAutoresizingMaskIntoConstraints = false
            let anchor = Constraint.anchor(kindLabel, to: self.degLabel, align:.topCenter, alignTo: .bottomCenter)
            let height = Constraint.height(kindLabel, height: 40)
            let width = Constraint.width(kindLabel, to: self)
            NSLayoutConstraint.activate([anchor.x,anchor.y,width,height])
        }()
        return kindLabel
    }
    /**
     * WeatherIcon
     */
    func createWeatherIcon()->UIImageView{
        let view = UIImageView()
        //        view.backgroundCol    or = .purple
        self.addSubview(view)
        _ = {
            view.translatesAutoresizingMaskIntoConstraints = false
            let anchor = Constraint.anchor(view, to: self.degLabel, align:.bottomCenter, alignTo: .topCenter)
            let height = Constraint.height(view, height: 38)
            let width = Constraint.width(view, width:38)
            NSLayoutConstraint.activate([anchor.x,anchor.y,width,height])
        }()
        return view
    }
}
