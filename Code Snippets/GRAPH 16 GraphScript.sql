DROP PROCEDURE "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD";

CREATE PROCEDURE "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD" (OUT cnt INT)
 LANGUAGE GRAPH READS SQL DATA AS
  BEGIN
	Graph g = Graph("GREEK_MYTHOLOGY","GRAPH");
	ALTER g ADD TEMPORARY VERTEX ATTRIBUTE(Bool livesInUnderWorld = false);
	FOREACH e IN Edges(:g) {
		Vertex msource = Source(:e);
		Vertex mtarget = Target(:e);
		Bool areGods = :msource."TYPE" == 'god' AND :mtarget."TYPE" == 'god';
		IF (:e.type == 'hasDaughter' AND :areGods) {
			IF (:mtarget.residence == 'Underworld' AND :msource.residence != 'Underworld') {
				IF (NOT :mtarget.livesInUnderWorld) {
					cnt = :cnt + 1;
					mtarget.livesInUnderWorld = TRUE;
				}
			}
		}
	}
  END;

-- the result here is 1, only Persephone is a goddess and lives in the underworld
CALL "GET_NUM_OF_DAUGHTERS_IN_UNDERWORLD"(?);
