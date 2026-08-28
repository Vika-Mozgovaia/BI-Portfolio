with ord as (
 select
   o.order_id,
      o.order_date,
      o.status,
      o.buyer_id,
      o.total_amount
 from marketplace.orders o
 WHERE o.order_date between '01-06-2024' and '31-05-2025'
), usr as (
 select
    u.user_id,
    u.name,
    u.email,
    u.registration_date,
    u.user_type,
    u.is_active
 from marketplace.users u
 WHERE u.registration_date <= '31-05-2025'
), cte as
(select
    u.user_id,
    u.name,
    u.email,
    u.registration_date,
    u.user_type,
    u.is_active,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
from usr u
LEFT JOIN ord o on o.buyer_id = u.user_id)
select
 user_id,
    name,
    email,
    user_type,
    registration_date,
    is_active,
    order_id,
    order_date,
    status,
    total_amount
from cte;
