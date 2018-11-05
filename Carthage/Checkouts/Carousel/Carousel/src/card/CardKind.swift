import Foundation
import Spatial

public protocol CardKind:ConstraintKind{
   var idx:Int {get set}
}
//enum ItemState{
//   case active, inActive
//}


/**
 * If the Carousel-Item is within the visible part of the Carousel, the state is active.
 * If the Carousel-Item is within the invisible part of the Carousel, the state is inActive.
 */
//   var state:ItemState {get set}
/**
 * Called when view comes into the visible part of the carousel
 * NOTE: will only be called if state is .inActive
 */
//func appeared()
/**
 * Called when view goes out of the visible part of the carousel
 * NOTE: will only be called if state is already .active
 */
//func disappeared()

//func appeared() {
//continue playing things,
//or create things
//or load things from external services
//}
//func disappeared() {
//pause playing things,
//or deInit things
//or cancel loading things from external services
//}
