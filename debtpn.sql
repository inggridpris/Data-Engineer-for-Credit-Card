DROP TABLE category_db

create TABLE public.category_db
(
	card_categoryid INT,
	Card_Category VARCHAR
);

ALTER TABLE category_db
ADD PRIMARY KEY(card_categoryid);

DROP TABLE customer_data_history;

create TABLE public.customer_data_history
(
	CLIENTNUM INT,
	idstatus INT,
	Customer_Age INT,
	Gender VARCHAR,
	Dependent_count INT,
	Educationid INT,
	Maritalid INT,
	Income_Category VARCHAR,
	card_categoryid INT,
	Months_on_book INT,
	Total_Relationship_Count INT,
	Months_Inactive_12_mon INT,
	Contacts_Count_12_mon INT,
	Credit_Limit FLOAT,
	Total_Revolving_Bal FLOAT,
	Avg_Open_To_Buy FLOAT,
	Total_Trans_Amt FLOAT,
	Total_Trans_Ct FLOAT,
	Avg_Utilization_Ratio FLOAT
);

ALTER TABLE customer_data_history
ADD PRIMARY KEY(CLIENTNUM);
ALTER TABLE customer_data_history
ADD FOREIGN Key (idstatus) REFERENCES status_db (idstatus),
ADD FOREIGN KEY (Educationid) REFERENCES education_db (Educationid),
ADD FOREIGN KEY (Maritalid) REFERENCES marital_db (Maritalid),
ADD FOREIGN KEY (card_categoryid) REFERENCES category_db (card_categoryid);

DROP TABLE education_db

create TABLE public.education_db
(
	Educationid INT,
	Education_level VARCHAR
);
ALTER TABLE education_db
ADD PRIMARY KEY (Educationid);

DROP TABLE marital_db

create TABLE public.marital_db
(
	Maritalid INT,
	Marital_Status VARCHAR
);
ALTER TABLE marital_db
ADD PRIMARY KEY(maritalid);

DROP TABLE status_db

create TABLE public.status_db
(
	idstatus INT,
	status VARCHAR
);
ALTER TABLE status_db
ADD PRIMARY KEY(idstatus);


SELECT
	COUNT (ch.CLIENTNUM),
	ch.gender,
	s.status,
	ma.Marital_Status,
	e.Education_level,
	ca.Card_Category
FROM customer_data_history as ch
JOIN status_db as s on ch.idstatus = s.idstatus
JOIN marital_db as ma on ch.Maritalid = ma.Maritalid
JOIN education_db as e on ch.Educationid = e.Educationid
JOIN category_db as ca on ch.card_categoryid = ca.card_categoryid
GROUP BY 2,3,4,5,6
ORDER BY 3;

SELECT
	COUNT (ch.gender),
	ch.gender,
	s.status
FROM customer_data_history as ch
JOIN status_db as s on ch.idstatus = s.idstatus
GROUP BY 2,3;

SELECT
	COUNT (ch.gender),
	ch.gender,
	ma.Marital_Status
FROM customer_data_history as ch
JOIN marital_db as ma on ch.Maritalid = ma.Maritalid
GROUP BY 2,3;

SELECT
	COUNT (ch.gender),
	ch.gender,
	e.Education_level
FROM customer_data_history as ch
JOIN education_db as e on ch.Educationid = e.Educationid
GROUP BY 2,3;

SELECT
	COUNT (ch.gender),
	ch.gender,
	ca.Card_Category
FROM customer_data_history as ch
JOIN category_db as ca on ch.card_categoryid = ca.card_categoryid
GROUP BY 2,3;

SELECT
	COUNT(CLIENTNUM),
	CASE WHEN Customer_Age <=39 then 'Adults'
		 WHEN Customer_Age <=60 then 'Middle Age'
		 WHEN Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history
GROUP BY 2;

SELECT *,
	CASE WHEN Customer_Age <=39 then 'Adults'
		 WHEN Customer_Age <=60 then 'Middle Age'
		 WHEN Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history;

SELECT
	a.status,
	a.Category_age,
	Count(a.Category_age)
FROM(
	SELECT
		s.status,
		c.Customer_age,
	CASE WHEN c.Customer_Age <=39 then 'Adults'
		 WHEN c.Customer_Age <=60 then 'Middle Age'
		 WHEN c.Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history c
JOIN status_db as s on c.idstatus=s.idstatus
GROUP BY 1,2
)as a
GROUP BY 1,2;

SELECT *,
	CASE WHEN Customer_Age <=39 then 'Adults'
		 WHEN Customer_Age <=60 then 'Middle Age'
		 WHEN Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history;

SELECT
	b.Education_level,
	b.Category_age,
	Count(b.Category_age)
FROM(
	SELECT
		e.Education_level,
		c.Customer_age,
	CASE WHEN c.Customer_Age <=39 then 'Adults'
		 WHEN c.Customer_Age <=60 then 'Middle Age'
		 WHEN c.Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history c
JOIN education_db as e on c.idstatus= e.Educationid
GROUP BY 1,2
)as b
GROUP BY 1,2;

SELECT
	pt.Income_Category,
	pt.Category_age,
	Count(pt.Category_age)
FROM(
	SELECT
		Income_Category,
		Customer_age,
	CASE WHEN Customer_Age <=39 then 'Adults'
		 WHEN Customer_Age <=60 then 'Middle Age'
		 WHEN Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history
GROUP BY 1,2
)as pt
GROUP BY 1,2;

SELECT
	sp.Income_Category,
	sp.Category_age,
	sp.status,
	Count(sp.Category_age)
FROM(
	SELECT
		s.status,
		c.Income_Category,
		c.Customer_age,
	CASE WHEN Customer_Age <=39 then 'Adults'
		 WHEN Customer_Age <=60 then 'Middle Age'
		 WHEN Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
GROUP BY 1,2,3
)as sp
GROUP BY 1,2,3
ORDER BY 2,3;

SELECT
	AVG(c.Credit_Limit),
	s.status
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
GROUP BY 2;

SELECT
	AVG(c.Credit_Limit),
	c.Income_Category,
	s.status
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
GROUP BY 2,3
ORDER BY 3;

SELECT
	COUNT(c.CLIENTNUM),
	s.status
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
GROUP BY 2;

SELECT
	count(c.Avg_Open_To_Buy),
	s.status,
	cc.Card_Category
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
GROUP BY 2,3
ORDER BY 2,3;

SELECT
	count(c.Avg_Open_To_Buy),
	s.status,
	cc.Card_Category
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
WHERE s.status = 'Attrited Customer'
GROUP BY 2,3
ORDER BY 2,3;

SELECT
	count(c.Total_trans_amt),
	s.status,
	cc.Card_Category
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
WHERE s.status = 'Attrited Customer'
GROUP BY 2,3
ORDER BY 2,3;

SELECT
	count(c.Total_trans_amt),
	s.status,
	cc.Card_Category
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
GROUP BY 2,3
ORDER BY 2,3;

SELECT
	count(c.Total_Relationship_Count),
	s.status,
	cc.Card_Category
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
GROUP BY 2,3
ORDER BY 2,3;

SELECT
	count(c.Total_Revolving_Bal),
	s.status,
	cc.Card_Category
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
GROUP BY 2,3
ORDER BY 2,3;

SELECT
	count(pa.Total_Revolving_Bal),
	pa.status,
	pa.Card_Category,
	pa.Category_Age
FROM( 
	SELECT
		c.Total_Revolving_Bal,
		c.Income_Category,
		c.Customer_age,
		s.status,
		cc.Card_Category,
	CASE WHEN Customer_Age <=39 then 'Adults'
		 WHEN Customer_Age <=60 then 'Middle Age'
		 WHEN Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
GROUP BY 1,2,3,4,5
)as pa
GROUP BY 2,3,4
ORDER BY 2,3,4;

SELECT
	count(pa.Total_Relationship_Count),
	pa.status,
	pa.Card_Category,
	pa.Category_Age
FROM( 
	SELECT
		c.Total_Relationship_Count,
		c.Income_Category,
		c.Customer_age,
		s.status,
		cc.Card_Category,
	CASE WHEN Customer_Age <=39 then 'Adults'
		 WHEN Customer_Age <=60 then 'Middle Age'
		 WHEN Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
GROUP BY 1,2,3,4,5
)as pa
GROUP BY 2,3,4
ORDER BY 2,3,4;

SELECT
	sum(pa.Total_Relationship_Count),
	pa.status,
	pa.Card_Category,
	pa.Category_Age
FROM( 
	SELECT
		c.Total_Relationship_Count,
		c.Income_Category,
		c.Customer_age,
		s.status,
		cc.Card_Category,
	CASE WHEN Customer_Age <=39 then 'Adults'
		 WHEN Customer_Age <=60 then 'Middle Age'
		 WHEN Customer_age >60 then 'Senior'
	end as Category_Age
FROM customer_data_history as c
JOIN status_db as s on c.idstatus = s.idstatus
JOIN category_db as cc on c.card_categoryid = cc.card_categoryid
GROUP BY 1,2,3,4,5
)as pa
GROUP BY 2,3,4
ORDER BY 2,3,4;

SELECT
	COUNT(ccb.CLIENTNUM),
	ccb.category_call_bank,
	ccb.status
FROM 
(
	SELECT 
		c.CLIENTNUM,
		s.status,
		c.Contacts_Count_12_mon,
		CASE WHEN (c.Contacts_Count_12_mon) <=4 then 'low'
			 WHEN (c.Contacts_Count_12_mon) <=8 then 'high'
		 	 WHEN (c.Contacts_Count_12_mon) >12 then 'high'
		end as category_call_bank
	FROM customer_data_history as c
	JOIN status_db as s on c.idstatus = s.idstatus
	GROUP BY 1,2,3
) as ccb
GROUP BY 2,3
ORDER BY 3;