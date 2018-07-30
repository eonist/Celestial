import UIKit

/**
 * Animation
 */
extension VC{
    /**
     * PARAM: to: the amount to offset in the X dir
     * PARAM: onComplete: called when the animation completes
     */
    func animate(to:CGFloat, onComplete:@escaping () -> Void){
        let newConstraintClosure = {/*Animate to this*/
            guard let anchor = self.curView.anchor else {fatalError("err anchor not available")}
            NSLayoutConstraint.deactivate([anchor.x])/*Deactivate the current active constraint*/
            let xConstraint = Constraint.anchor(self.curView, to: self.view, align: .left, alignTo: .left, offset: to)
            NSLayoutConstraint.activate([xConstraint/*,pos.y*/])
            self.curView.anchor?.x = xConstraint
        }
        UIView.animate({/*animate*/
            newConstraintClosure()/*Set the new constraints*/
            self.view.layoutIfNeeded()
        }, onComplete:onComplete)
    }
}

