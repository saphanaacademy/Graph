DROP CALCULATION SCENARIO "MATCH_SUBGRAPHS_EXAMPLE" CASCADE;

CREATE CALCULATION SCENARIO "MATCH_SUBGRAPHS_EXAMPLE" USING '
 <?xml version="1.0"?>
 <cubeSchema version="2" operation="createCalculationScenario" defaultLanguage="en">
  <calculationScenario name="MATCH_SUBGRAPHS_EXAMPLE">
   <calculationViews>
	<graph name="match_subgraphs_node" defaultViewFlag="true" schema="GREEK_MYTHOLOGY" workspace="GRAPH" action="MATCH_SUBGRAPHS">
		<expression>
			<![CDATA[
				MATCH (A)-[E1]->(B), (A)-[E2]->(C)
				WHERE A.NAME < B.NAME AND E1.TYPE = ''marriedTo'' AND C.TYPE = ''god'' AND C.RESIDENCE = ''Olymp''
				RETURN A.NAME AS PARENT1_NAME, B.NAME AS PARENT2_NAME, C.NAME AS CHILD_NAME
			]]>
		</expression>
		<viewAttributes>
			<viewAttribute name="PARENT1_NAME" datatype="string"/>
			<viewAttribute name="PARENT2_NAME" datatype="string"/>
			<viewAttribute name="CHILD_NAME" datatype="string"/>
		</viewAttributes>
	</graph>
   </calculationViews>
  </calculationScenario>
 </cubeSchema>
 ' 
 WITH PARAMETERS ('EXPOSE_NODE'=('match_subgraphs_node','MATCH_SUBGRAPHS_EXAMPLE'));

SELECT * FROM "MATCH_SUBGRAPHS_EXAMPLE";
