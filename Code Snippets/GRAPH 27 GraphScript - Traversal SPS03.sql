DROP PROCEDURE "AirportDestinations";

CREATE PROCEDURE "AirportDestinations" (IN airportCode NVARCHAR(3), OUT direct Int, OUT oneTransfer Int, OUT twoTransfers Int)
 LANGUAGE GRAPH READS SQL DATA AS
  BEGIN
	Graph g = Graph("TRAVEL", "Flights");
	TRAVERSE BFS :g 
		FROM { 
			Vertex(:g, :airportCode)
		} 
	    ON VISIT VERTEX (Vertex v, BigInt lvl) {
	    	IF (:lvl == 1L) {
	    		direct = :direct + 1;
	    		}
	    	ELSE {
	    		IF (:lvl == 2L) {
	    			oneTransfer = :oneTransfer + 1;
	    		}
	    		ELSE {
	    			IF (:lvl == 3L) {
	    				twoTransfers = :twoTransfers + 1;
	    			}
		    	}
	    	}
		}
	;
  END;

CALL "AirportDestinations"('ATL',?,?,?);
CALL "AirportDestinations"('PDX',?,?,?);
CALL "AirportDestinations"('YVR',?,?,?);
