MATCH (A)-[E1]->(B), 
      (A)-[E2]->(C)
WHERE E1.type = 'marriedTo' AND 
      E2.type = 'hasDaughter' AND
      C.type = 'god' AND
      C.residence = 'Olymp' AND
      A.name < B.name
RETURN A.name AS parent1, 
       B.name AS parent2,
       C.name AS child