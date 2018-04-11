DROP CALCULATION SCENARIO "TripRoutings" CASCADE;

CREATE CALCULATION SCENARIO "TripRoutings" USING '
 <?xml version="1.0"?>
 <cubeSchema version="2" operation="createCalculationScenario" defaultLanguage="en">
  <calculationScenario name="TripRoutings">
   <calculationViews>
	<graph name="openCypher_node" defaultViewFlag="true" schema="TRAVEL" workspace="Flights" action="MATCH_SUBGRAPHS">
		<expression>
			<![CDATA[
				MATCH (a)-[e]->(b)
				WHERE a.country = ''$$country$$'' AND e.distance $$distance$$ AND b.altitude $$altitude$$ $$customFilter$$
				RETURN a.airportCode AS airportCodeFrom, b.airportCode AS airportCodeTo, e.airlineName AS airlineName, e.distance AS distance, b.altitude AS altitude
				ORDER BY b.altitude, e.distance DESC
			]]>
		</expression>
		<viewAttributes>
			<viewAttribute name="airportCodeFrom" datatype="string"/>
			<viewAttribute name="airportCodeTo" datatype="string"/>
			<viewAttribute name="airlineName" datatype="string"/>
			<viewAttribute name="distance" datatype="integer"/>
			<viewAttribute name="altitude" datatype="integer"/>
		</viewAttributes>
	</graph>
   </calculationViews>
   <variables>        
	<variable name="$$country$$" type="graphVariable"/>   
	<variable name="$$distance$$" type="graphVariable"/>   
	<variable name="$$altitude$$" type="graphVariable"/>   
	<variable name="$$customFilter$$" type="graphVariable"/>   
   </variables>
  </calculationScenario>
 </cubeSchema>
 ' 
 WITH PARAMETERS ('EXPOSE_NODE'=('openCypher_node','TripRoutings'));

SELECT * FROM "TripRoutings" (
	placeholder."$$country$$" => 'United States',
	placeholder."$$distance$$" => '> 4000',
	placeholder."$$altitude$$" => '< 50',
	placeholder."$$customFilter$$" => ''
	);

SELECT * FROM "TripRoutings" (
	placeholder."$$country$$" => 'United States',
	placeholder."$$distance$$" => '> 4000',
	placeholder."$$altitude$$" => '< 50',
	placeholder."$$customFilter$$" => 'AND e.airlineName STARTS WITH ''KLM'''
	);

SELECT * FROM "TripRoutings" (
	placeholder."$$country$$" => 'United States',
	placeholder."$$distance$$" => '> 4000',
	placeholder."$$altitude$$" => '< 50',
	placeholder."$$customFilter$$" => 'AND e.airlineName ENDS WITH ''lines'''
	);

SELECT * FROM "TripRoutings" (
	placeholder."$$country$$" => 'United States',
	placeholder."$$distance$$" => '> 4000',
	placeholder."$$altitude$$" => '< 50',
	placeholder."$$customFilter$$" => 'AND SYS.TEXT_CONTAINS(e.airlineName, ''*Airline*'', ''EXACT'')'
	);

SELECT * FROM "TripRoutings" (
	placeholder."$$country$$" => 'United States',
	placeholder."$$distance$$" => '> 4000',
	placeholder."$$altitude$$" => '< 50',
	placeholder."$$customFilter$$" => 'AND SYS.TEXT_CONTAINS(e.airlineName, ''Airline'', ''FUZZY(0.4)'')'
	);
