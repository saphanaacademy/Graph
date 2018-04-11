DROP CALCULATION SCENARIO "TripRoutings3Segments" CASCADE;

CREATE CALCULATION SCENARIO "TripRoutings3Segments" USING '
 <?xml version="1.0"?>
 <cubeSchema version="2" operation="createCalculationScenario" defaultLanguage="en">
  <calculationScenario name="TripRoutings3Segments">
   <calculationViews>
	<graph name="openCypher_node" defaultViewFlag="true" schema="TRAVEL" workspace="Flights" action="MATCH_SUBGRAPHS">
		<expression>
			<![CDATA[
				MATCH (a)-[e1]->(b)
				MATCH (b)-[e2]->(c)
				MATCH (c)-[e3]->(d)
				WHERE a.airportCode = ''$$airportCodeFrom$$'' AND d.airportCode = ''$$airportCodeTo$$'' $$customFilter$$
				RETURN e1.airlineName AS airlineName1, b.airportCode AS transferAirportCode1, e2.airlineName AS airlineName2, c.airportCode AS transferAirportCode2, e3.airlineName AS airlineName3
			]]>
		</expression>
		<viewAttributes>
			<viewAttribute name="airlineName1" datatype="string"/>
			<viewAttribute name="transferAirportCode1" datatype="string"/>
			<viewAttribute name="airlineName2" datatype="string"/>
			<viewAttribute name="transferAirportCode2" datatype="string"/>
			<viewAttribute name="airlineName3" datatype="string"/>
		</viewAttributes>
	</graph>
   </calculationViews>
   <variables>        
	<variable name="$$airportCodeFrom$$" type="graphVariable"/>   
	<variable name="$$airportCodeTo$$" type="graphVariable"/>
	<variable name="$$customFilter$$" type="graphVariable"/>  
   </variables>
  </calculationScenario>
 </cubeSchema>
 ' 
 WITH PARAMETERS ('EXPOSE_NODE'=('openCypher_node','TripRoutings3Segments'));

SELECT * FROM "TripRoutings3Segments" (
	placeholder."$$airportCodeFrom$$" => 'NTE',
	placeholder."$$airportCodeTo$$" => 'PDX',
	placeholder."$$customFilter$$" => ''
	);

SELECT * FROM "TripRoutings3Segments" (
	placeholder."$$airportCodeFrom$$" => 'NTE',
	placeholder."$$airportCodeTo$$" => 'PDX',
	placeholder."$$customFilter$$" => 'AND (e1.allianceName = e2.allianceName AND e2.allianceName = e3.allianceName)'
	);

SELECT * FROM "TripRoutings3Segments" (
	placeholder."$$airportCodeFrom$$" => 'NTE',
	placeholder."$$airportCodeTo$$" => 'PDX',
	placeholder."$$customFilter$$" => 'AND (e1.allianceName <> e2.allianceName OR e2.allianceName <> e3.allianceName)'
	);
