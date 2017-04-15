/**
 * Alternate translation of the example from class which demonstrated barriers
 * in openMP, using the 'clocked finish' structure
 */
public class BarrierEx2 {
	public static def main(args:Rail[String]){
		clocked finish for(i in 0 .. 3){
			clocked async {
				
				Console.OUT.println("activity " + i + " (before)");
				Clock.advanceAll();
				Console.OUT.println("activity " + i + " (after)");
			}
		}
	}
}