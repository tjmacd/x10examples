/**
 * Translation of the example from class which demonstrated barriers
 * in openMP. Here it uses Clocks.
 */
public class BarrierEx1 {
	public static def main(args:Rail[String]){
		val clock = Clock.make();
		for(i in 0 .. 3){
			finish async clocked(clock){
				
				Console.OUT.println("thread number " + i + " (before)");
				Clock.advanceAll();
				Console.OUT.println("thread number " + i + " (after)");
			}
		}
	}
}