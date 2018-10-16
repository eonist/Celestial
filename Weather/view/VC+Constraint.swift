import UIKit
/**
 * Constraints
 */
extension VC{
    /**
     * Set center constraints
     * TODO: ⚠️️ use the new activateConstraintKind
     */
    func setCenterConstraints<T:UIView>(_ page:T) where T:ConstraintKind {
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
      page.setAndActivateConstraint{ view in
         let size:SizeConstraint = Constraint.size(page, size: screenSize)
         let anchor:AnchorConstraint = Constraint.anchor(page, to: self.view, align: .topLeft, alignTo: .topLeft)
         return (anchor:anchor, size:size)
      }
    }
    /**
     * Set left constraints
     * NOTE: called from tapRelease and createLeftView
     */
    func setLeftConstraints<T:UIView>(_ page:T) where T:ConstraintKind {
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        page.setAndActivateConstraint{ view in
            let size = Constraint.size(page, size: screenSize)
            let anchor = Constraint.anchor(page, to: self.curView, align: .topRight, alignTo: .topLeft)
            return (anchor, size)
        }
    }
    /**
     * // Nice: Places the view to the right of the middle view
     * // Nice: NOTE: this method has multiple callers
     */
    func setRightConstraints<T:UIView>(_ page:T) where T:ConstraintKind {
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        page.setAndActivateConstraint { view in
            let size = Constraint.size(view, size: screenSize)
            let anchor = Constraint.anchor(view, to: self.curView, align: .topLeft, alignTo: .topRight)
            return (anchor, size)
        }
    }
}
