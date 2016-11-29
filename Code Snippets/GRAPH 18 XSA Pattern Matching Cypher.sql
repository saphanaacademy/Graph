MATCH (A)-[E1]->(B), 
      (A)-[E2]->(C)
WHERE E1.TYPE = 'marriedTo' AND 
      E2.TYPE = 'hasDaughter' AND
      C.TYPE = 'god' AND
      C.RESIDENCE = 'Olymp' AND
      A.NAME < B.NAME
RETURN A.NAME AS PARENT1_NAME, 
       B.NAME AS PARENT2_NAME,
       C.NAME AS CHILD_NAME
