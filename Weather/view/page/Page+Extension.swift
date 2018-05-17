import UIKit
/**
 * Update
 */
extension Page{
    /**
     * Updates the weather for the page
     */
    func setWeather(_ weather:WeatherModel){
        card.degLabel.text = "\(weather.temperature)°C"
        Swift.print("weather.weatherType:  \(weather.weatherType)")
        Swift.print("Consts.weatherTypes.count:  \(Consts.weatherTypes.count)")
        let idx:Int = Int(Double(weather.weatherType)!)
        guard let weatherType:String = Consts.weatherTypes[idx] else {fatalError("error no weahter symbol for idx: \(idx)")}
        card.kindLabel.text = "\(weatherType)"
        
        guard let url = URL(string: Consts.imageURL(weather.weatherType)) else {fatalError("error invalid url")}
        card.weatherIcon.contentMode = .scaleAspectFit
        card.weatherIcon.downloadImage(url: url)
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
    func createCard() -> Card{
        let view = Card()
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
   
}
