/**
 * Naive concurrent integral pi calculation from class.
 * Is there a better way?
 */
public class ConcurrentPi {
	static val numSteps = 100000000;
	
	public static def main(args:Rail[String]) {
		val step:Double = 1.0/numSteps;
		var sum:Double = 0;
		val P = Place.numPlaces();
		val blockSize = numSteps/P;
		
		finish for(p in 0 .. (P-1)) {
			async {
				Console.OUT.println(p);
				val start = p*blockSize;
				var subSum : Double = 0.0;
				for(i in start .. (start+blockSize)) {
					val x = (i+0.5)*step;
					subSum += 4.0/(1.0+x*x);
				}
				atomic sum += subSum;
				Console.OUT.println(p);
			}
		}
		val pi = step * sum;
		Console.OUT.println("pi = " + pi);
	}
}