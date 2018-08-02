import UIKit

/**
 * Create
 */
extension Footer{
    /**
     * Creates Day views
     */
    func createDayViews() -> [DayView]{
        let boxW:CGFloat = UIScreen.main.bounds.size.width / 5 /*75p on iphone 8*/
        let dayViews:[DayView] = Footer.dayNames.map{ day in
            let dayView = DayView.init(day:day)
            self.addArrangedSubview(dayView)
            dayView.activateConstraint{ view in /*constraints*/
                let size = Constraint.size(dayView, size: CGSize(width:boxW,height:Footer.footerHeight))
                return [size.w,size.h]
            }
            return dayView/*all vertically centered, 30p height each*/
        }
        return dayViews
    }
    /**
     * Creates day names
     */
    static func createDayNames() -> [String] {
        let dayNames:[String] = (0..<5).indices.compactMap {
            let day = Date.offsetByDays(Date(), $0)
            return day.semiShortDayName
        }
        return dayNames
    }
}
