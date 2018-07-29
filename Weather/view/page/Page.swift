import UIKit

class Page:UIView{
    lazy var header:UIView = createHeader()
    lazy var card:Card = createCard()
    /**
     * Stores the constraints, for easy activating and deactivating
     */
    var size:SizeConstraint?
    var anchor:AnchorConstraint?
    var idx:Int
    init(idx:Int) {
        self.idx = idx
        super.init(frame: CGRect.zero)
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




