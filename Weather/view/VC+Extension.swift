
import UIKit

/**
 * Animation
 */
extension VC{
    /**
     * PARAM: to: the amount to offset in the X dir
     * PARAM: onComplete: called when the animation completes
     * TODO: ⚠️️ Upgrade to more modern Constraint class, and use the built in animation code
     */
    func animate(to:CGFloat, onComplete:@escaping ()-> Void){
        let newConstraintClosure = {
            guard let anchor = self.curView.anchor else {fatalError("err posConstraint not available")}
            NSLayoutConstraint.deactivate([anchor.x])
            let xConstraint = Constraint.anchor(self.curView, to: self.view, align: .left, alignTo: .left, offset: to)
            NSLayoutConstraint.activate([xConstraint/*,pos.y*/])
            self.curView.anchor?.x = xConstraint
        }
        let anim = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
            newConstraintClosure()// Set the new constraints
            self.view.layoutIfNeeded()
        })
        anim.addCompletion{_ in
            onComplete()
        }
        anim.startAnimation()
    }
}

