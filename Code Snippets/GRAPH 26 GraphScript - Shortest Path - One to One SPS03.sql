DROP TYPE "TripRoutingTT";
DROP PROCEDURE "TripRoutingSP";
DROP PROCEDURE "TripRoutingSPW";

CREATE TYPE "TripRoutingTT" AS TABLE ("segment" BIGINT, "airportCodeOrigin" NVARCHAR(3), "airportCodeDestination" NVARCHAR(3), "airlineName" NVARCHAR(100), "distance" INT, "duration" INT);

CREATE PROCEDURE "TripRoutingSP" (IN airportCodeOrigin NVARCHAR(3), IN airportCodeDestination NVARCHAR(3), OUT totalSegments BigInt, OUT totalDistance Int, OUT totalDuration Int, OUT routing "TripRoutingTT")
 LANGUAGE GRAPH READS SQL DATA AS
  BEGIN
	Graph g = Graph("TRAVEL", "Flights");
	Vertex sourceVertex = Vertex(:g, :airportCodeOrigin);
	Vertex targetVertex = Vertex(:g, :airportCodeDestination);
	WeightedPath<BigInt> p = SHORTEST_PATH(:g, :sourceVertex, :targetVertex);
	totalSegments = Length(:p);
	FOREACH e IN Edges(:p) {
		totalDistance = :totalDistance + :e."distance";
		totalDuration = :totalDuration + :e."duration";
	}
	routing = SELECT :segment, :e."airportCodeOrigin",  :e."airportCodeDestination", :e."airlineName", :e."distance", :e."duration" FOREACH e in Edges(:p) WITH ORDINALITY AS segment;
  END;

CALL "TripRoutingSP"('NTE','PDX',?,?,?,?);

CREATE PROCEDURE "TripRoutingSPW" (IN weight VARCHAR(10), IN airportCodeOrigin NVARCHAR(3), IN airportCodeDestination NVARCHAR(3), OUT totalSegments BigInt, OUT totalDistance Int, OUT totalDuration Int, OUT routing "TripRoutingTT")
 LANGUAGE GRAPH READS SQL DATA AS
  BEGIN
	Graph g = Graph("TRAVEL", "Flights");
	Vertex sourceVertex = Vertex(:g, :airportCodeOrigin);
	Vertex targetVertex = Vertex(:g, :airportCodeDestination);
	IF (:weight == 'distance') {
		WeightedPath<Int> p = SHORTEST_PATH(:g, :sourceVertex, :targetVertex, (Edge e) => Int {return :e."distance";});
		totalSegments = Length(:p);
		totalDistance = Weight(:p);
		FOREACH e IN Edges(:p) {
			totalDuration = :totalDuration + :e."duration";
		}	
		routing = SELECT :segment, :e."airportCodeOrigin",  :e."airportCodeDestination", :e."airlineName", :e."distance", :e."duration" FOREACH e in Edges(:p) WITH ORDINALITY AS segment;
	} ELSE {
		IF (:weight == 'duration') {
			WeightedPath<Int> p = SHORTEST_PATH(:g, :sourceVertex, :targetVertex, (Edge e) => Int {return :e."duration";});
			totalSegments = Length(:p);
			totalDuration = Weight(:p);
			FOREACH e IN Edges(:p) {
				totalDistance = :totalDistance + :e."distance";
			}
			routing = SELECT :segment, :e."airportCodeOrigin",  :e."airportCodeDestination", :e."airlineName", :e."distance", :e."duration" FOREACH e in Edges(:p) WITH ORDINALITY AS segment;
		} ELSE {
			WeightedPath<BigInt> p = SHORTEST_PATH(:g, :sourceVertex, :targetVertex);
			totalSegments = Length(:p);
			FOREACH e IN Edges(:p) {
				totalDistance = :totalDistance + :e."distance";
				totalDuration = :totalDuration + :e."duration";
			}
			routing = SELECT :segment, :e."airportCodeOrigin",  :e."airportCodeDestination", :e."airlineName", :e."distance", :e."duration" FOREACH e in Edges(:p) WITH ORDINALITY AS segment;
		}
	}
  END;

CALL "TripRoutingSPW"('','NTE','PDX',?,?,?,?);
CALL "TripRoutingSPW"('distance','NTE','PDX',?,?,?,?);
CALL "TripRoutingSPW"('duration','NTE','PDX',?,?,?,?);
