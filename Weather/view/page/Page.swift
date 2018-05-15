import UIKit

class Page:UIView{
    lazy var header:UIView = createHeader()
    lazy var degLabel:UILabel = createDeglabel()
    lazy var centerContent:UIView = createCenterContent()
    lazy var kindLabel:UILabel = createkindLabel()
    lazy var weatherIcon:UIImageView = createWeatherIcon()
    
    /**
     * Stores the constraints, for easy activating and deactivating
     */
    var size:(w:NSLayoutConstraint,h:NSLayoutConstraint)?
    var anchor:(x:NSLayoutConstraint,y:NSLayoutConstraint)?
    var idx:Int
    init(idx:Int) {
        self.idx = idx
        super.init(frame: CGRect.zero)
        self.backgroundColor = .white//ViewController.citiesAndColors[idx].color
        _ = header
        _ = centerContent
        _ = degLabel
        _ = kindLabel
        _ = weatherIcon
    }
    /**
     * Boilerplate
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




