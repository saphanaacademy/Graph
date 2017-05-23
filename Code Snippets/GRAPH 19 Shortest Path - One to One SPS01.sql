DROP CALCULATION SCENARIO "SHORTEST_PATH_ONE_TO_ONE_EXAMPLE" CASCADE;

CREATE CALCULATION SCENARIO "SHORTEST_PATH_ONE_TO_ONE_EXAMPLE" USING '
 <?xml version="1.0"?>
 <cubeSchema version="2" operation="createCalculationScenario" defaultLanguage="en">
  <calculationScenario name="SHORTEST_PATH_ONE_TO_ONE_EXAMPLE">
   <calculationViews>
	<graph name="shortest_path_node" defaultViewFlag="true" schema="GREEK_MYTHOLOGY" workspace="GRAPH" action="GET_SHORTEST_PATH_ONE_TO_ONE">
		<expression>
			<![CDATA[{
				"parameters": {
					"startVertex": "Gaia",
					"targetVertex": "Ares",
					"outputWeightColumn": "DISTANCE"
				}
			}]]>
		</expression>
		<viewAttributes>
			<viewAttribute name="ORDERING" datatype="Fixed" length="18" sqltype="BIGINT"/>
			<viewAttribute name="SOURCE" datatype="string"/>
			<viewAttribute name="TARGET" datatype="string"/>
			<viewAttribute name="DISTANCE" datatype="int"/>
		</viewAttributes>
	</graph>
   </calculationViews>
  </calculationScenario>
 </cubeSchema>
 ' 
 WITH PARAMETERS ('EXPOSE_NODE'=('shortest_path_node','SHORTEST_PATH_ONE_TO_ONE_EXAMPLE'));

SELECT * FROM "SHORTEST_PATH_ONE_TO_ONE_EXAMPLE" ORDER BY "ORDERING";
