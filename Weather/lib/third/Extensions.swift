import UIKit
/**
 * Generic utility extensions
 */
extension Date{

    var day:Int {return Calendar.current.component(.day, from:self)}
    var month:Int {return Calendar.current.component(.month, from:self)}
    var year:Int {return Calendar.current.component(.year, from:self)}
    var hour:Int {return Calendar.current.component(.hour, from:self)}

    static func assertHour(_ a:Date,with b:Date) -> Bool{
        //        Swift.print("a.year:  \(a.year)")
        //        Swift.print("b.year:  \(b.year)")
        //        Swift.print("a.month:  \(a.month)")
        //        Swift.print("b.month:  \(b.month)")
        //        Swift.print("a.day:  \(a.day)")
        //        Swift.print("b.day:  \(b.day)")
        //        Swift.print("a.hour:  \(a.hour)")
        //        Swift.print("b.hour:  \(b.hour)")
        return a.year == b.year && a.month == b.month && a.day == b.day && a.hour == b.hour
    }
    static func assertDay(_ a:Date,with b:Date) -> Bool{
        return a.year == b.year && a.month == b.month && a.day == b.day
    }
    static func offsetByHours(_ date:Date, _ hours:Int)->Date?{
        //swift 3 update. may work, may not work. its not including: Calendar.Options.matchStrictly
        let calendar = Calendar.current
        let newDate:Date? = calendar.date(byAdding: .hour, value: hours, to: date)//let newDate:Date = NSCalendar.current.dateByAddingUnit(NSCalendar.Unit.Day, value: days, toDate: date, options: Calendar.Options.matchStrictly)!
        return newDate
    }
    /**
     * Returns a Date instance for a date and dayOffset
     * EXAMPLE: NSDate().offsetByDays(-3)//an NSDate instance that is 3 days ago
     */
    static func offsetByDays(_ date:Date, _ days:Int)->Date{
        //swift 3 update. may work, may not work. its not including: Calendar.Options.matchStrictly
        let calendar = Calendar.current
        let newDate:Date = calendar.date(byAdding: .day, value: days, to: date)!//let newDate:Date = NSCalendar.current.dateByAddingUnit(NSCalendar.Unit.Day, value: days, toDate: date, options: Calendar.Options.matchStrictly)!
        return newDate
    }
    /**
     * Returns a date instance for time components like: 2016,11,03,15,49,59
     * IMPORTANT: ⚠️️⚠️️⚠️️ if you pass 0 in any of the arguments the returned date is all wrong, use nil and make sure your var is not 0
     * TODO: ⚠️️ should throw
     */
    static func createDate(_ year:Int? = nil,_ month:Int? = nil,_ day:Int? = nil,_ hour:Int? = nil,_ minute:Int? = nil,_ second:Int? = nil)->Date?{
        if year == 0 || month == 0 || day == 0 {//this may not apply to hour,min,sec so these arent tested
            fatalError("can't be 0")
        }
        let calendar = Calendar.current
        var components = DateComponents()
        if year != nil {components.year = year!}//⚠️️ use if let
        if month != nil {components.month = month!}
        if day != nil {components.day = day!}
        if hour != nil {components.hour = hour!}
        if minute != nil {components.minute = minute!}
        if second != nil {components.second = second!}
        return calendar.date(from: components)
    }

    /**
     * Returns Mon,Tue,Wed
     */
    var semiShortDayName:String?{
        if let dayName:String = self.dayName{
            let str:String = String.subStr(dayName, 0, 3)
            return str
        }else {
            return nil
        }
    }
    var dayName:String? {/*Convenience*/
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }

}
extension String {
    /**
     * Format: 2018-05-01T18:38:43.162Z
     */
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "Y-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: self)
        return date
    }
    static func subStr(_ str:String, _ beginning:Int,_ len:Int)->String{
        //str.stringRange(str, beginning, len:len)
        let start = str.index(str.startIndex, offsetBy: beginning)
        let end = str.index(str.startIndex, offsetBy: beginning+len)
        let retVal = str[start..<end]//swift 4 upgrade, was: return str.substring(with:range)
        return String(retVal)
    }

}

extension Array {
    /**
     * RATIONAL 1: Enhances readability when doing `if let` style coding
     * RATIONAL 2: using if let in conjunction with array avoids out of bound crashing
     * NOTE: Performance wise `self.dropFirst(at).first` is as fast as doing .contain,
     * ⚠️️IMPORTANT:⚠️️ Do not use this with arrays such as :[Int?]
     * EXAMPLE: if let item = [a,b,c,d][safe:3] {print(item)}
     */
    subscript(safe index: Index) -> Iterator.Element? {
        if indices.contains(index) { return self[index] }
        return nil
    }
}

/**
 * Image loading
 */
extension UIImageView{
    /**
     * Assign and convert data to Image
     */
    func downloadImage(url: URL) {
        print("Download Started")
        url.getDataFromUrl { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}
extension URL{
    typealias URLQuery = (Data?, URLResponse?, Error?) -> ()
    /**
     * Get data from URL
     */
    func getDataFromUrl(completion: @escaping URLQuery) {
        URLSession.shared.dataTask(with: self) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
}

// let π = CGFloat(Double.pi)/*Global variable*/
// class TrigParser {
//     /**
//      * Returns an angle in radian between -3.14 and 3.14 (-180 and 180 converted to degress)
//      * PARAM: a is the pivot point
//      * PARAM: b is the polar point
//      * NOTE: use this formula to find the angle in a (0,0) point-space Math.atan2(pointB.y, pointB.x)
//      * NOTE: formula in standard form: Tan Ɵ = y/x (then use inverse tan to find the angle)
//      */
//     static func angle(_ a:CGPoint, _ b:CGPoint)->CGFloat {
//         return atan2(b.y - a.y, b.x - a.x)
//     }
//     /**
//     * Returns a radian to be between 0 and Math.PI*2 Radian (0 - 6.28)
//     * PARAM: theta: An radian in degrees typically 0 - Math.PI*2
//     * NOTE: we use "while" function type here because angle could be very low at which point Math.PI*2 needs to be contrinuasly added until its above 0 )
//     * TODO: ⚠️️ Use modulo like normalize2 does, is that faster ? do an optimization test.
//     */
//   static func normalize(_ angle:CGFloat)->CGFloat {
//       var angle = angle
//       while angle < 0 {angle += π*2}
//       while angle >= π*2 {angle -= π*2}
//       return angle
//   }
// }
class DirDetecor{
   // static var t:(CGFloat, CGFloat) = (-π/4,-π*0.75)
   // static var b:(CGFloat, CGFloat) = (π/4,π*0.75)
   // static var l:(CGFloat, CGFloat) = (TrigParser.normalize(π*0.75), TrigParser.normalize(-π*0.75))/*remember to normalize the angle to test against this value to be between 0 - PI*2*/
   // static var r:(CGFloat, CGFloat) = (-π/4, π/4)
   enum Dir{
      case hor, ver, none
   }
   //use trig from press to drag.dist >= 64 to activate, actually drag.dist.x > 54 or .y > 54
   static func dir(p1:CGPoint,p2:CGPoint) -> Dir {
      let xDist = abs(p2.x - p1.x)
      let yDist = abs(p2.y - p1.y)
      if xDist > yDist {
         return .hor
      }else if xDist < yDist {
         return .ver
      }else{
         return .none
      }
      // let angle:cgFloat = TrigParser.angle(prevMovePt,touchPt)
      // if (angel >= t.0 || angel <= t.1) || (angel >= b.0 || angel <= b.1){
      //    return .ver
      // } else // (angel >= l.0 || angel <= l.1) || (angel >= r.0 || angel <= r.1) {
      //    return .hor
      // }
   }
}
// class CGPointParser{
//    /**
//     * A method to check distance between two points
//     * Ref: https://en.wikipedia.org/wiki/Pythagorean_theorem
//     */
//    static func dist(a: CGPoint, b: CGPoint) -> CGFloat {
//       let xDist = a.x - b.x
//       let yDist = a.y - b.y
//       return CGFloat(sqrt(xDist * xDist + yDist * yDist))
//    }
// }


import UIKit.UIColor

extension UIColor {
   /**
    * EXAMPLE: let color = UIColor(hex: "ff0000")
    */
   convenience init(hex: String) {
      let scanner = Scanner(string: hex)
      scanner.scanLocation = 0
      var rgbValue: UInt64 = 0
      scanner.scanHexInt64(&rgbValue)
      let r = (rgbValue & 0xff0000) >> 16
      let g = (rgbValue & 0xff00) >> 8
      let b = rgbValue & 0xff
      self.init(
         red: CGFloat(r) / 0xff,
         green: CGFloat(g) / 0xff,
         blue: CGFloat(b) / 0xff, alpha: 1
      )
   }
}
