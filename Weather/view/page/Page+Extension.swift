import UIKit
/**
 * Update
 */
extension Page{
    /**
     * Updates the weather for the page
     */
    func setWeather(_ weather:WeatherModel){
        degLabel.text = "\(weather.temperature)°C"
        Swift.print("weather.weatherType:  \(weather.weatherType)")
        Swift.print("Consts.weatherTypes.count:  \(Consts.weatherTypes.count)")
        let idx:Int = Int(Double(weather.weatherType)!)
        guard let weatherType:String = Consts.weatherTypes[idx] else {fatalError("error no weahter symbol for idx: \(idx)")}
        kindLabel.text = "\(weatherType)"
        
        guard let url = URL(string: Consts.imageURL(weather.weatherType)) else {fatalError("error invalid url")}
        weatherIcon.contentMode = .scaleAspectFit
        self.weatherIcon.downloadImage(url: url)
        //weatherIcon = img
    }
}
/**
 * Create
 */
extension Page{
    /**
     * Header
     */
    func createHeader() -> UIView{
        let view = UIView()
        view.backgroundColor = .cyan
        addSubview(view)
        _ = {//constraints
            view.translatesAutoresizingMaskIntoConstraints = false//(this enables you to set your own constraints)
            let anchor = Constraint.anchor(view, to: self, align: .topCenter, alignTo: .topCenter)
            let screenSize = UIScreen.main.bounds.size
            let size = Constraint.size(view, size: CGSize(width:screenSize.width,height:60))
            NSLayoutConstraint.activate([anchor.x,anchor.y,size.w,size.h])
        }()
        
        let label = UILabel()
        let location:String = VC.citiesAndColors[idx].city.cityName
        label.text = location
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        //label.backgroundColor = .green
        label.textColor = .black//UIColor(hex:"EBCF4B")
        view.addSubview(label)
        _ = {
            label.translatesAutoresizingMaskIntoConstraints = false
            let anchor = Constraint.anchor(label, to: view, align:.centerCenter, alignTo: .centerCenter)
            let height = Constraint.height(label, height: 30)
            let width = Constraint.width(label, to: view)
            NSLayoutConstraint.activate([anchor.x,anchor.y,width,height])
        }()
        return view
    }
    
    /**
     * Center content
     */
    func createCenterContent() -> UIView{
        let view = UIView()
        //view.backgroundColor = .white
        addSubview(view)
        _ = {//constraints
            view.translatesAutoresizingMaskIntoConstraints = false//(this enables you to set your own constraints)
            let anchor = Constraint.anchor(view, to: self, align: .centerCenter, alignTo: .centerCenter)
            let size = Constraint.size(view, size: CGSize(width:200,height:200))
            NSLayoutConstraint.activate([anchor.x,anchor.y,size.w,size.h])
        }()
        
        //weather Kind Label small
        return view
    }
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
        self.centerContent.addSubview(degLabel)
        _ = {
            degLabel.translatesAutoresizingMaskIntoConstraints = false
            let anchor = Constraint.anchor(degLabel, to: self.centerContent, align:.bottomCenter, alignTo: .bottomCenter)
            let height = Constraint.height(degLabel, to: self.centerContent)
            let width = Constraint.width(degLabel, to: self.centerContent)
            NSLayoutConstraint.activate([anchor.x,anchor.y,width,height])
        }()
        return degLabel
    }
    /**
     * kindLabel
     */
    func createkindLabel() -> UILabel{
        let kindLabel = UILabel()
        kindLabel.text = "Clear skies"
        kindLabel.font = kindLabel.font.withSize(20)
        kindLabel.textAlignment = .center
        //        kindLabel.backgroundColor = .gray
        kindLabel.textColor = .black//UIColor(hex:"EBCF4B")
        self.centerContent.addSubview(kindLabel)
        _ = {
            kindLabel.translatesAutoresizingMaskIntoConstraints = false
            let anchor = Constraint.anchor(kindLabel, to: self.degLabel, align:.topCenter, alignTo: .bottomCenter)
            let height = Constraint.height(kindLabel, height: 40)
            let width = Constraint.width(kindLabel, to: self.centerContent)
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
        self.centerContent.addSubview(view)
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



