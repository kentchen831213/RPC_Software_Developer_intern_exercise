### insert data into table
---

```
INSERT INTO customer(id,ssn,first_name,favorite_color,last_updated)
VALUES(101,123456789,"Jon","Green",'2018-03-22');
INSERT INTO customer(id,ssn,last_name,favorite_color,last_updated)
VALUES(321,123456789,"Dough","Blue",'2018-03-23');
INSERT INTO customer(id,ssn,last_name,last_updated)
VALUES(456,123456789,"Doe",'2020-03-22');
```

### check the data
---
```
SELECT *
FROM customer;
```

![image](https://user-images.githubusercontent.com/32189071/173955030-92ef7697-ac55-411d-8c77-bd9f65d9828c.png)


### merge the data 
---
```
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
```


![image](https://user-images.githubusercontent.com/32189071/173955080-d62dc116-bfaf-4b2e-b5fc-2ae5f0105f84.png)


### explaining
---


![image](https://user-images.githubusercontent.com/32189071/173970799-0f40ed66-71f3-48b8-ae23-394034bc9d35.png)


### reference
---
- [ROW_NUMBER()](https://www.javatpoint.com/mysql-row_number-function)
- [UNPIVOT](https://ubiq.co/database-blog/unpivot-table-mysql/)
- [CASE_WHEN](https://www.w3schools.com/sql/sql_case.asp)
