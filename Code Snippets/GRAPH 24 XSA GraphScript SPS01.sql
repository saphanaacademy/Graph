PROCEDURE "graph.graphdb::graphScript" (OUT cnt INT)
   LANGUAGE GRAPH
   SQL SECURITY INVOKER
   --DEFAULT SCHEMA <default_schema_name>
   READS SQL DATA AS
BEGIN
   /*************************************
       Write your procedure logic 
   *************************************/
	Graph g = Graph("graph.graphdb::graphw");
	Vertex chaos = Vertex(:g, 'Chaos');
	Multiset<Vertex> neighbors = Neighbors(:g,:chaos, 0, 2);
	Multiset<Vertex> neighborsWithResidence = Multiset<Vertex> (:g);
	FOREACH n IN :neighbors {
		if (:n."RESIDENCE" IS NOT NULL) {
			neighborsWithResidence = :neighborsWithResidence UNION {:n};
		}
	}
	cnt = INT(COUNT(:neighborsWithResidence));
END
