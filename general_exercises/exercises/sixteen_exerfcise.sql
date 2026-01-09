SELECT product.product_name, product.price, product.stock FROM products product 
    WHERE product.stock < 50 AND product.price > 100