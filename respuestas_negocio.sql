--PERGUNTA 1
-- Liste usuários com aniversário de hoje cujo número de vendas realizadas em janeiro de 2020 seja superior a 1.500.
  

WITH

vendas_jan as ( --- conta as vendas de jan2020 de cada vendedor e traz apenas as maiores que 1500

    SELECT
    seller_id,
    count_orders

    FROM (
            SELECT
            seller_id,
            COUNT(DISTINCT order_id) as count_orders

            FROM Orders 
            WHERE
            DATE_FORMAT(order_datetime, '%Y-%m') = "2020-01"
            AND order_status = "CONFIRMED"
        )  

    WHERE count_orders > "1500"
    
)


SELECT 

 VJ.seller_id,
 VJ.count_orders,
 C.name,
 C.lastname,
 C.birth_date

 

 FROM vendas_jan as VJ
  LEFT JOIN Customers as C
   ON VJ.seller_id=C.customer_id

WHERE C.birth_date= CURRENT_DATE() 


-------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------


-- PERGUNTA 2
-- Para cada mês de 2020, são solicitados os 5 principais usuários que mais venderam ($) na categoria Celulares.
-- São obrigatórios o mês e ano da análise, nome e sobrenome do vendedor, quantidade de vendas realizadas, 
-- quantidade de produtos vendidos e valor total transacionado.


WITH

vendas_ano as (


    SELECT
        seller_id,
        DATE_FORMAT(order_datetime, '%Y-%m') as ano_mes,
        order_id,
        item_id,
        order_value,
        quantity,
        
        I.category_id
        CA.category_name
             
    FROM Orders as O
      LEFT JOIN Items as I ON O.item_id=I.item_id
      LEFT JOIN Categories as CA ON I.category_id=CA.category_id
    
    WHERE
        DATE_FORMAT(order_datetime, '%Y') = "2020"
        AND order_status = "CONFIRMED"
        AND CA.category_name="Celulares"

)

,agregado as (
    SELECT
        seller_id,
        ano_mes,
        COUNT(distinct order_id) as quantidade_vendas,
        SUM(order_value) as valor_transacionado,
        SUM(quantity) as quntidade_vendida

    FROM
     vendas_ano

     GROUP BY seller_id, ano_mes

)


SELECT
 A.seller_id,
 A.ano_mes,
 A.count_orders
 A.sum_order_value
 A.sum_quantity

 C.name
 C.lastname


 FROM agregado as A
   LEFT JOIN Customers as C ON  A.seller_id = C.customer_id
    


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- PERGUNTA 3

--- É solicitada uma nova tabela a ser preenchida com o preço e status dos Itens no final do dia. 
--Lembre-se de que deve ser reprocessável. 
--Vale ressaltar que na tabela Item teremos apenas o último status informado pelo PK definido. 
--(Pode ser resolvido através de StoredProcedure)




----CREATE TABLE 

CREATE TABLE ItemHistory (
    item_history_key VARCHAR(100),
    item_id INT,                       
    item_name VARCHAR(100) ,            
    price FLOAT ,                      
    currency VARCHAR(10),              
    category_id INT ,                   
    status_ativo BOOLEAN ,              
    created_at DATETIME ,               
    datetime_alteration DATETIME,                   
    datetime_record DATETIME ,                  
    FOREIGN KEY (item_id) REFERENCES Items(item_id) 
);


--- stored Procedure para inserir os dados na tabela criada 

CREATE PROCEDURE ProcedureItemsHistory(IN runDate DATE)
AS

    DELETE FROM ItemsHistory WHERE  DATE_FORMAT(datetime_record, '%Y-%m-%d') = runDate;


    INSERT INTO ItemHistory (
        item_history_key,
        item_id,
        item_name,
        price,
        currency,
        category_id,
        status_ativo,
        created_at,
        datetime_alteration,
        datetime_record
    )
    SELECT
        CONCAT(COALESCE(item_id, ''), ':', COALESCE(runDate, '')) AS chave_item_runDate -- coalesce para evitar problemas mas não deveriam ser campos nulos
        item_id,
        item_name,
        price,
        currency,
        category_id,
        status_ativo,
        created_at,
        datetime_alteration,
        runDate as datetime_record,  
    FROM Items
    WHERE 
     datetime_alteration = runDate;  -- pode ser retirado caso a idéia seja ter uma fotografia diária de todos os itens , a idéia é pegar apenas os alterados do dia





  