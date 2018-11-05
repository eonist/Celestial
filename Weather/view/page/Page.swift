import UIKit
import Spatial

class Page:UIView,ConstraintKind{
    lazy var header:UIView = createHeader()
    lazy var card:WeatherCard = createCard()
    /**
     * Stores the constraints, for easy activating and deactivating
     */
    var size:SizeConstraint?
    var anchor:AnchorConstraint?
    var idx:Int
    init(idx:Int) {
        self.idx = idx
        super.init(frame: .zero)
        self.backgroundColor = .white//ViewController.citiesAndColors[idx].color
        _ = header
        _ = card
    }
    /**
     * Boilerplate
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
