/**
 * Object oriented implementation of Ticket Simulator from Lab 6
 * Uses GlobalRef[T] (I guess T needs to be an object and not a struct)
 */

import x10.util.Random;

public class TicketSimulator2 {
	public static struct TicketAgent(id:Long, available:Long, numRef:GlobalRef[Rail[Long]]){
		def run() {
			Console.OUT.println("Hello from agent " + id);
			val ticketsSold = numRef();
			val rand = new Random();
			while(ticketsSold(0) < available) {
				val randomNum = rand.nextDouble();
				if((id % 2 == 1 && randomNum <= 0.3) ||
						(id % 2 == 0 && randomNum <= 0.45)) {
					var nTickets:Long = rand.nextLong(4)+1;
					atomic {
						if(ticketsSold(0) >= available){
							break;
						}
						if(ticketsSold(0) + nTickets > available) {
							nTickets = available - ticketsSold(0);
						}
						ticketsSold(0) += nTickets;
						Console.OUT.printf("Ticket agent %d: Successful transaction "
								+ "- %d tickets sold\n", id, nTickets);
					}
				} else {
					Console.OUT.printf("Ticket agent %d: Unsuccessful "+
							"transaction\n", id);
				}
				//System.sleep(100);
			}
		}
	}
	
	public static def main(argv:Rail[String]) {
		if(argv.size != 3) {
			Console.OUT.println("Usage: ticket-simulator [num_agents] "+
			"[num_seats] [percent_allowed_oversell]");
			return;
		}
		
		val nAgents = Long.parseLong(argv(0));
		val nSeats = Long.parseLong(argv(1));
		val oversell = Double.parseDouble(argv(2)) / 100;
		var available:Long = (nSeats + oversell*nSeats) as Long;
		val ticketsSold = GlobalRef[Rail[Long]](new Rail[Long](1, 0));
		
		finish for (i in 0 .. (nAgents-1)) {
			val agent = new TicketAgent(i, available, ticketsSold);
			async {
				agent.run();
			}
		}
		
		Console.OUT.printf("Summary: %d tickets sold\n", ticketsSold()(0));
	}
}