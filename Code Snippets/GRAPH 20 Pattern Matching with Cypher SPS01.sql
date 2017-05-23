-- undirected edges
MATCH (a)-[e]-(b)
WHERE a.NAME = ''Uranus''
RETURN b.NAME AS NAME
ORDER BY b.NAME

-- limited length paths
MATCH p = (a)-[*1..2]->(b)
WHERE a.NAME = ''Uranus''
RETURN b.NAME AS NAME
ORDER BY b.NAME

-- all edges in path
MATCH p = (a)-[*1..2]->(b)
WHERE a.NAME = ''Uranus'' AND ALL (e IN RELATIONSHIPS(p) WHERE e.TYPE = ''hasDaughter'')
RETURN b.NAME AS NAME
ORDER BY b.NAME

-- full example
DROP CALCULATION SCENARIO "MATCH_SUBGRAPHS_EXAMPLE" CASCADE;

CREATE CALCULATION SCENARIO "MATCH_SUBGRAPHS_EXAMPLE" USING '
 <?xml version="1.0"?>
 <cubeSchema version="2" operation="createCalculationScenario" defaultLanguage="en">
  <calculationScenario name="MATCH_SUBGRAPHS_EXAMPLE">
   <calculationViews>
	<graph name="match_subgraphs_node" defaultViewFlag="true" schema="GREEK_MYTHOLOGY" workspace="GRAPH" action="MATCH_SUBGRAPHS">
		<expression>
			<![CDATA[
				MATCH (a)-[e]-(b)
				WHERE a.NAME = ''Uranus''
				RETURN b.NAME AS NAME
				ORDER BY b.NAME
			]]>
		</expression>
		<viewAttributes>
			<viewAttribute name="NAME" datatype="string"/>
		</viewAttributes>
	</graph>
   </calculationViews>
  </calculationScenario>
 </cubeSchema>
 ' 
 WITH PARAMETERS ('EXPOSE_NODE'=('match_subgraphs_node','MATCH_SUBGRAPHS_EXAMPLE'));

SELECT * FROM "MATCH_SUBGRAPHS_EXAMPLE";
