public class SerialPi {
	static val numSteps = 100000000;
	
	public static def main(args:Rail[String]) {
		val step:Double = 1.0/numSteps;
		var x:Double;
		var sum:Double = 0;
		
		for(var i:Long=0; i<numSteps; i++) {
			x = (i+0.5)*step;
			sum += 4.0/(1.0+x*x);
		}
		val pi = step * sum;
		Console.OUT.println("pi = " + pi);
	}
}