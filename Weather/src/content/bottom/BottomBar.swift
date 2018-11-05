import UIKit

/**
 * Represents the bottom-bar of the app (forcast for the next 5 days)
 */
class BottomBar:UIStackView{
    static let footerHeight:CGFloat = 90
    static let dayNames = BottomBar.createDayNames()
    lazy var dayViews:[DayView] = self.createDayViews()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bg = UIView()
        bg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bg.backgroundColor = .blue
        self.addSubview(bg)/*Add a background to*/  
        self.axis = .horizontal/*arrange subViews horizontally*/
        self.distribution  = .equalSpacing
        self.alignment = .center
        self.spacing = 0/*zero gaps between view*/
        _ = dayViews
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomBar{
   static let bottomBarHeight:CGFloat = UIScreen.main.bounds.width/4 + UIApplication.shared.statusBarFrame.height
}
