DROP PROCEDURE "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD";

CREATE PROCEDURE "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD" (OUT cnt INT)
 LANGUAGE GRAPH READS SQL DATA AS
  BEGIN
	Graph g = Graph("GREEK_MYTHOLOGY","GRAPH");
	ALTER g ADD TEMPORARY VERTEX ATTRIBUTE(Bool livesInUnderWorld = false);
	FOREACH e IN Edges(:g) {
		Vertex source = Source(:e);
		Vertex target = Target(:e);
		Bool areGods = :source.type == 'god' AND :target.type == 'god';
		IF (:e.type == 'hasDaughter' AND :areGods) {
			IF (:target.residence == 'Underworld' AND :source.residence != 'Underworld') {
				IF (NOT :target.livesInUnderWorld) {
					cnt = :cnt + 1;
					target.livesInUnderWorld = TRUE;
				}
			}
		}
	}
  END;

-- the result here is 1, only Persephone is a goddess and lives in the underworld
CALL "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD"(?);
