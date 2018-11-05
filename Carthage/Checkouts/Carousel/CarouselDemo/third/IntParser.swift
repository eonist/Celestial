import Foundation

class IntParser{
   /**
    * Returns a normalized integer value (loopy index)
    * NOTE: Great for iterating int arrays
    * NOTE: Can be used for looping items in an array (carousel etc)
    * EXAMPLE:
    * print(IntParser.normalize(3, 7))//3
    * print(IntParser.normalize(-3, 7))//4
    * print(IntParser.normalize(0, 7))//0
    * print(IntParser.normalize(7, 7))//0
    * print(IntParser.normalize(8, 7))//1
    * print(IntParser.normalize(12, 7))//5
    * Was: return index >= 0 ? (index < len ? index : index % len) : (len + (index % len))//IMPORTANT: print(IntParser.normalize(-7, 7)) yields 7, which is wrong it should be 0
    */
   static func normalize(_ index:Int,_ len:Int) -> Int {
      if index >= 0 {
         if index < len{
            return index
         }else {
            return index % len
         }
      }else {
         if index % len == 0 {
            return 0
         }else {
            return len + (index % len)
         }
      }
   }
}
