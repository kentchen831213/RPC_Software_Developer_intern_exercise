INSERT INTO customer(id,ssn,first_name,favorite_color,last_updated)
VALUES(101,123456789,"Jon","Green",'2018-03-22');
INSERT INTO customer(id,ssn,last_name,favorite_color,last_updated)
VALUES(321,123456789,"Dough","Blue",'2018-03-23');
INSERT INTO customer(id,ssn,last_name,last_updated)
VALUES(456,123456789,"Doe",'2020-03-22');

SELECT *
FROM customer;

SELECT c.ssn,
	MAX(CASE WHEN id_num = 1 THEN id END) AS id,
    MAX(CASE WHEN first_name_num = 1 THEN first_name END) AS first_name,
    MAX(CASE WHEN last_name_num = 1 THEN last_name END) AS last_name,
    MAX(CASE WHEN favorite_color_num = 1 THEN favorite_color END) AS favorite_color,
    CURRENT_TIMESTAMP() AS last_updated
FROM (SELECT c.*,
		ROW_NUMBER() OVER(PARTITION BY ssn 
							ORDER BY (CASE WHEN id IS NOT NULL THEN 0 ELSE 1 END), last_updated DESC) AS id_num,
        ROW_NUMBER() OVER(PARTITION BY ssn 
							ORDER BY (CASE WHEN first_name IS NOT NULL THEN 0 ELSE 1 END), last_updated DESC) AS first_name_num,                    
		ROW_NUMBER() OVER(PARTITION BY ssn 
							ORDER BY (CASE WHEN last_name IS NOT NULL THEN 0 ELSE 1 END), last_updated DESC) AS last_name_num,    
		ROW_NUMBER() OVER(PARTITION BY ssn 
							ORDER BY (CASE WHEN favorite_color IS NOT NULL THEN 0 ELSE 1 END), last_updated DESC) AS favorite_color_num
		FROM customer AS c) AS c
GROUP BY ssn;