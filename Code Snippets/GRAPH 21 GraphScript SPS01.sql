DROP PROCEDURE "GREEK_MYTHOLOGY"."NEIGHBORS_WITH_RESIDENCE";

CREATE PROCEDURE "GREEK_MYTHOLOGY"."NEIGHBORS_WITH_RESIDENCE" (OUT cnt INT)
 LANGUAGE GRAPH READS SQL DATA AS
  BEGIN
	Graph g = Graph("GREEK_MYTHOLOGY", "GRAPH");
	Vertex chaos = Vertex(:g, 'Chaos');
	Multiset<Vertex> neighbors = Neighbors(:g,:chaos, 0, 2);
	Multiset<Vertex> neighborsWithResidence = Multiset<Vertex> (:g);
	FOREACH n IN :neighbors {
		if (:n."RESIDENCE" IS NOT NULL) {
			neighborsWithResidence = :neighborsWithResidence UNION {:n};
		}
	}
	cnt = INT(COUNT(:neighborsWithResidence));
  END;

-- the result here is 2, only these are neighbors of Chaos with residence not null
CALL "GREEK_MYTHOLOGY"."NEIGHBORS_WITH_RESIDENCE"(?);
