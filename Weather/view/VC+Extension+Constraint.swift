
import UIKit

/**
 * Constraints
 */
extension VC{
    /**
     * center
     */
    func setCenterConstraints(_ view:Page) {
        view.translatesAutoresizingMaskIntoConstraints = false// (this enables you to set your own constraints)
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        let size = Constraint.size(view, size: screenSize)
        let pos = Constraint.anchor(view, to: self.view, align: .topLeft, alignTo: .topLeft)
        let constraints = [pos.x,pos.y,size.w,size.h]
        view.size = size
        view.anchor = pos
        NSLayoutConstraint.activate(constraints)
    }
    /**
     * NOTE: called from tapRelease and createLeftView
     */
    func setLeftConstraints(_ view:Page) {
        view.translatesAutoresizingMaskIntoConstraints = false// (this enables you to set your own constraints)
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        let size = Constraint.size(view, size: screenSize)
        let pos = Constraint.anchor(view, to: self.curView, align: .topRight, alignTo: .topLeft)
        let constraints = [pos.x,pos.y,size.w,size.h]
        view.size = size
        view.anchor = pos
        NSLayoutConstraint.activate(constraints)
    }
    /**
     * Places the view to the right of the middle view
     * NOTE: this method has multiple callers
     */
    func setRightConstraints(_ view:Page) {
        view.translatesAutoresizingMaskIntoConstraints = false// (this enables you to set your own constraints)
        let screenSize:CGSize = {
            let size = UIScreen.main.bounds.size
            return CGSize(width:size.width, height:size.height - Footer.footerHeight)
        }()
        let size = Constraint.size(view, size: screenSize)
        let pos = Constraint.anchor(view, to: curView, align: .topLeft, alignTo: .topRight)
        let constraints = [pos.x,pos.y,size.w,size.h]
        view.size = size
        view.anchor = pos
        NSLayoutConstraint.activate(constraints)
    }
}
