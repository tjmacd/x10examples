/**
 * Translation of the example from class which demonstrated barriers
 * in openMP. Here it uses Clocks.
 */
public class BarrierEx1 {
	public static def main(args:Rail[String]){
		val clock = Clock.make();
		for(i in 0 .. 3){
			async clocked(clock){
				
				Console.OUT.println("activity " + i + " (before)");
				clock.advance();
				Console.OUT.println("activity " + i + " (after)");
			}
		}
	}
}