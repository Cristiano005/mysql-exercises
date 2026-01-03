ALTER TABLE orders ADD COLUMN status VARCHAR(25) NOT NULL DEFAULT "PENDING";

DELIMITER $$

    CREATE PROCEDURE cancel_order(IN orderId int unsigned) 

    BEGIN 

        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            -- Trava pedido enquanto a transação realiza sua operação.
            IF EXISTS (SELECT 1 FROM orders WHERE id = orderId AND status = "PENDING" FOR UPDATE) = 1 THEN

                UPDATE orders SET status = "CANCELLED" WHERE id = orderId;

                -- Preciso travar pedido - feito
                -- Esse pedido tem items/produtos dentro dele 
                -- Esses items estão na tabela produtos que tem o estoque onde  aquantidade na tabela ordeR_items precisa ser adicionado com o estoque atual

                -- Travei Os items do pedido e os produtos que são os itens do pedido
                SELECT id FROM products INNER JOIN order_items AS item ON item.product_id = products.id WHERE item.order_id = orderId FOR UPDATE;
                -- FOR UPDATE bloqueia todas as linhas reais que o MySQL precisa tocar para montar o resultado da query, resumindo...
                -- Quando você usa FOR UPDATE com JOIN, o InnoDB trava as linhas de TODAS as tabelas envolvidas no resultado.
                
                UPDATE products INNER JOIN order_items AS item ON  item.order_id = orderId AND item.product_id = products.id
                    SET products.stock = products.stock + item.quantity WHERE item.order_id = orderId;

                -- UPDATE products SET products.stock = (
                --     SELECT products.stock + order_items.quantity FROM order_items WHERE order_items.order_id = orderId FOR UPDATE
                -- );

                COMMIT;
                
            ELSE
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "It wasn't possible update order!";
            END IF;

    END $$

DELIMITER ;

drop procedure cancel_order;

CALL cancel_order(14); // 14, 85, 70

SELECT * FROM orders;

SELECT * FROM order_items WHERE order_id = 14;

select * from products WHERE id in (1, 3, 7); --14, 85, 70

select (products.stock + item.quantity) AS cancelado from products inner join order_items as item ON products.id = item.product_id;

SELECT EXISTS (SELECT 1 FROM orders WHERE id = 10 AND status = "PENDING")

SELECT products.stock + order_items.quantity FROM order_items WHERE order_items.order_id = orderId

SELECT product_id FROM products INNER JOIN order_items AS item ON item.product_id = products.id WHERE item.order_id = 14 ;