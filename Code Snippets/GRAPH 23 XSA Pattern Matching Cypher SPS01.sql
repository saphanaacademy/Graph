-- undirected edges
MATCH (a)-[e]-(b)
WHERE a.NAME = 'Uranus'
RETURN b.NAME AS NAME
ORDER BY b.NAME

-- limited length paths
MATCH p = (a)-[*1..2]->(b)
WHERE a.NAME = 'Uranus'
RETURN b.NAME AS NAME
ORDER BY b.NAME

-- all edges in path
MATCH p = (a)-[*1..2]->(b)
WHERE a.NAME = 'Uranus' AND ALL (e IN RELATIONSHIPS(p) WHERE e.TYPE = 'hasDaughter')
RETURN b.NAME AS NAME
ORDER BY b.NAME
