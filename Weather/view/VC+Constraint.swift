import UIKit

/**
 * Constraints
 */
extension VC{
    /**
     * Set center constraints
     */
    func setCenterConstraints(_ page:Page) {
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        page.activateConstraint { view in
            let size = Constraint.size(page, size: screenSize)
            let pos = Constraint.anchor(page, to: self.view, align: .topLeft, alignTo: .topLeft)
            page.size = size
            page.anchor = pos
            return [pos.x,pos.y,size.w,size.h]
        }
    }
    /**
     * Set left constraints
     * NOTE: called from tapRelease and createLeftView
     */
    func setLeftConstraints(_ page:Page) {
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        page.activateConstraint{ view in
            let size = Constraint.size(page, size: screenSize)
            let pos = Constraint.anchor(page, to: self.curView, align: .topRight, alignTo: .topLeft)
            page.size = size
            page.anchor = pos
            return [pos.x,pos.y,size.w,size.h]
        }
    }
    /**
     * Places the view to the right of the middle view
     * NOTE: this method has multiple callers
     */
    func setRightConstraints(_ page:Page) {
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        page.activateConstraint { view in
            let size = Constraint.size(view, size: screenSize)
            let pos = Constraint.anchor(view, to: self.curView, align: .topLeft, alignTo: .topRight)
            page.size = size
            page.anchor = pos
            return [pos.x,pos.y,size.w,size.h]
        }
    }
}
