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
            guard let curAnchor = self.curView.anchor else {fatalError("err anchor not available")}
            NSLayoutConstraint.deactivate([curAnchor.x])/*Deactivate the current active constraint*/
            let xConstraint = Constraint.anchor(self.curView, to: self.view, align: .left, alignTo: .left, offset: to)
            NSLayoutConstraint.activate([xConstraint/*,pos.y*/])/*Activate the new constraint*/
            self.curView.anchor?.x = xConstraint/*Store the new constraint*/
        }
        UIView.animate({/*Animate*/
            newConstraintClosure()/*Set the new constraints*/
            self.view.layoutIfNeeded()/*Tells Apples Internals to get moving*/
        }, onComplete:onComplete)
    }
}

