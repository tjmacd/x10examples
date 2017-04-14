/**
 * Naive implementation of ticket simulator from lab 6.
 * Could it be done object oriented?
 * 
 * Note: no interleaving occurs in the following:
 * 		for (...) {
 * 			finish async {
 * 'finish S' waits for all activities spawned in S to complete before continuing
 * Instead we need to do:
 * 		finish for {
 * 			async {
 */

import x10.util.Random;

public class TicketSimulator {
	public static def main(Rail[String]) {
		val nAgents = 5;
		val nSeats = 100;
		val oversell = 0.1;
		var available:Long = (nSeats + oversell*nSeats) as Long;

		var ticketsSold:Long = 0;
		
		finish for (i in 0 .. (nAgents-1)) {
			async {
				Console.OUT.println("Hello from agent " + i);
				while(ticketsSold < available) {
					val rand = new Random();
					val randomNum = rand.nextDouble();
					if((i % 2 == 1 && randomNum <= 0.3) ||
						(i % 2 == 0 && randomNum <= 0.45)) {
						var nTickets:Long = rand.nextLong(4)+1;
						atomic {
							if(ticketsSold >= available){
								break;
							}
							if(ticketsSold + nTickets > available) {
								nTickets = available - ticketsSold;
							}
							ticketsSold += nTickets;
							Console.OUT.printf("Ticket agent %d: Successful transaction "
									+ "- %d tickets sold\n", i, nTickets);
						}
					} else {
						atomic {
							Console.OUT.printf("Ticket agent %d: Unsuccessful "+
								"transaction\n", i);
						}
					}
					//System.sleep(100);
				}
			}
		}
		
		
		Console.OUT.printf("Summary: %d tickets sold\n", ticketsSold);
	}
}