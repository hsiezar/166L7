SELECT  COUNT(n.part_number) 
FROM part_nyc n
WHERE n.on_hand > 70
GROUP BY n.on_hand;

SELECT ny.total + sf.total
FROM (SELECT SUM(n.on_hand) AS total
      FROM part_nyc n, color c
      WHERE n.color = c.color_id AND c.color_name = 'Red') ny, 
      (SELECT SUM(s.on_hand) AS total
      FROM part_sfo s, color c
      WHERE s.color = c.color_id AND c.color_name = 'Red') sf;

SELECT * 
FROM (SELECT s.supplier_name, COUNT(ny.on_hand) AS nycount
     FROM part_nyc ny, supplier s
     WHERE s.supplier_id = ny.supplier 
     GROUP BY s.supplier_name) tempny,
     (SELECT s.supplier_name, COUNT(sf.on_hand) AS sfcount
     FROM part_sfo sf, supplier s
     WHERE s.supplier_id = sf.supplier 
     GROUP BY s.supplier_name) tempsf
WHERE tempny.supplier_name = tempsf.supplier_name AND tempny.nycount > tempsf.sfcount;

SELECT s.supplier_name
FROM  part_nyc n, supplier s
WHERE n.supplier = s.supplier_id AND n.part_number
IN (SELECT ny.part_number
    FROM part_nyc ny--, supplier s
    --WHERE ny.supplier = s.supplier_id
    EXCEPT
    SELECT sf.part_number 
    FROM part_sfo sf--, supplier s
    --WHERE sf.supplier = s.supplier_id
    ) 
GROUP BY s.supplier_name;

UPDATE part_nyc
SET on_hand = on_hand - 10;

DELETE FROM part_nyc
WHERE on_hand < 30;


