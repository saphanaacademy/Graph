SELECT * FROM "DEVUSER"."GET_NEIGHBORHOOD" WITH PARAMETERS ( 
  'placeholder' = ('$$startVertices$$', 'Zeus'), 
  'placeholder' = ('$$direction$$', 'outgoing'), 
  'placeholder' = ('$$minDepth$$', '1'), 
  'placeholder' = ('$$maxDepth$$', '2'), 
  'placeholder' = ('$$vertexFilter$$', '\"TYPE\"=''god'' AND \"RESIDENCE\"=''Olymp'''), 
  'placeholder' = ('$$edgeFilter$$', '')
 )
