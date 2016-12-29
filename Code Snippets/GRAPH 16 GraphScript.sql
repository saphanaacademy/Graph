DROP PROCEDURE "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD";

CREATE PROCEDURE "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD" (OUT cnt INT)
 LANGUAGE GRAPH READS SQL DATA AS
  BEGIN
	Graph g = Graph("GREEK_MYTHOLOGY","GRAPH");
	ALTER g ADD TEMPORARY VERTEX ATTRIBUTE(Bool livesInUnderWorld = false);
	FOREACH e IN Edges(:g) {
		Vertex s = Source(:e);
		Vertex t = Target(:e);
		Bool areGods = :s."TYPE" == 'god' AND :t."TYPE" == 'god';
		IF (:e."TYPE" == 'hasDaughter' AND :areGods) {
			IF (:t."RESIDENCE" == 'Underworld' AND :s."RESIDENCE" != 'Underworld') {
				IF (NOT :t.livesInUnderWorld) {
					cnt = :cnt + 1;
					t.livesInUnderWorld = TRUE;
				}
			}
		}
	}
  END;

-- the result here is 1, only Persephone is a goddess and lives in the underworld
CALL "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD"(?);
