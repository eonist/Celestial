import UIKit
/**
 * NOTE: indirect pan gesture ref:  https://stackoverflow.com/a/30505331/5389500 and https://stackoverflow.com/a/25090388/5389500
 * TODO: ⚠️️ Remove the colors part. Not needed anymore
 */
class VC: UIViewController {
    static let colors:[UIColor] = [.green,.orange,.blue,.red,.purple,.gray,.yellow]
    static let citiesAndColors:[(color:UIColor,city:City)] = VC.createCityAndColors()
    var curIdx:Int = 0/*current page index*/
    /*Create views*/
    lazy var curView:Page = self.createCurView(idx:curIdx)
    lazy var leftView:Page = self.createLeftView(idx: IntParser.normalize(-1, VC.citiesAndColors.count))
    lazy var rightView:Page = self.createRightView(idx: curIdx+1)
    lazy var footer:Footer = self.createFooter()
    /**
     * Setup the views
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        _ = curView
        _ = rightView
        _ = leftView
        _ = footer
        addGestures()/*add gesture recognizers*/
    }
    override var prefersStatusBarHidden:Bool {return true}/*hides statusbar*/   
    /**
     * Boilerplate
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
