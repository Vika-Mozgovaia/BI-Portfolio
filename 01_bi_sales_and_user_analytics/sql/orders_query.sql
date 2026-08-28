-- Orders dataset for Sales Analytics
-- The query combines orders, order items, products, categories,
-- buyers, sellers, and reviews into a single analytical dataset.

WITH ord AS (

    -- Select orders within the analysis period
    SELECT
        o.order_id,
        o.order_date,
        o.status,
        o.buyer_id,
        o.total_amount
    FROM marketplace.orders o
    WHERE o.order_date BETWEEN '01-06-2024' AND '31-05-2025'

),

cte AS (

    SELECT

        -- Order information
        o.order_id,
        o.order_date,
        o.status AS order_status,
        o.total_amount AS order_total_amount,

        -- Order item information
        oi.order_item_id,
        oi.quantity,
        oi.price_at_order_time,

        -- Product information
        p.product_id,
        p.title AS product_title,
        p.description AS product_description,
        p.price AS product_price,
        p.stock_quantity,

        -- Product category
        c.category_id,
        c.name AS category_name,

        -- Buyer information
        ub.user_id AS buyer_user_id,
        ub.name AS buyer_name,
        ub.email AS buyer_email,
        ub.registration_date AS buyer_registration_date,
        ub.is_active AS buyer_is_active,

        -- Seller information
        us.user_id AS seller_user_id,
        us.name AS seller_name,
        us.email AS seller_email,
        us.registration_date AS seller_registration_date,
        us.is_active AS seller_is_active,

        -- Product review information
        r.review_id,
        r.rating,
        r.comment,
        r.review_date

    FROM ord o

    -- Join buyer information
    LEFT JOIN marketplace.users ub
        ON o.buyer_id = ub.user_id

    -- Join order items
    LEFT JOIN marketplace.order_items oi
        ON o.order_id = oi.order_id

    -- Join product information
    LEFT JOIN marketplace.products p
        ON oi.product_id = p.product_id

    -- Join seller information
    LEFT JOIN marketplace.users us
        ON p.seller_id = us.user_id

    -- Join product category
    LEFT JOIN marketplace.categories c
        ON p.category_id = c.category_id

    -- Join reviews left by the buyer for the purchased product
    LEFT JOIN marketplace.reviews r
        ON r.user_id = ub.user_id
        AND r.product_id = p.product_id

)

SELECT

    -- Core order fields
    order_id,
    order_date,
    order_status,
    order_total_amount,

    -- Order item fields
    order_item_id,
    quantity,
    price_at_order_time,

    -- Product fields
    product_id,
    product_description,
    product_title,
    product_price,
    stock_quantity,

    -- Category fields
    category_id,
    category_name,

    -- Buyer fields
    buyer_user_id,
    buyer_name,
    buyer_email,
    buyer_registration_date,
    buyer_is_active,

    -- Seller fields
    seller_user_id,
    seller_name,
    seller_email,
    seller_registration_date,
    seller_is_active,

    -- Review fields
    review_id,
    rating,
    comment,
    review_date,

    -- Row number within each order.
    -- Used to identify the first row of an order after joining order items.
    CASE
        WHEN order_id IS NULL THEN NULL
        ELSE ROW_NUMBER() OVER (PARTITION BY order_id)
    END AS rn_order_id,

    -- Row number within each review.
    -- Used to identify the first occurrence of a review after joins.
    CASE
        WHEN review_id IS NULL THEN NULL
        ELSE ROW_NUMBER() OVER (PARTITION BY review_id)
    END AS rn_review_id,

    -- Total number of items in each order
    SUM(quantity) OVER (
        PARTITION BY order_id
    ) AS items_per_order,

    -- Average rating for each product
    AVG(rating) OVER (
        PARTITION BY product_id
    ) AS avg_product_rating

FROM cte;
