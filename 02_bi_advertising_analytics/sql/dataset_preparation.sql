-- ============================================================
-- Advertising Analytics Dashboard
-- Dataset preparation query for Apache Superset
-- ============================================================

WITH sess_or AS (

    -- Combine sessions and orders into a single dataset
    SELECT
        CAST(COALESCE(ors.event_dt, sess.session_start) AS DATE) AS event_dt,
        COALESCE(ors.user_id, sess.user_id) AS user_id,
        ors.order_id,
        COALESCE(sess.channel, 'N/A') AS channel,
        ors.revenue,
        sess.device,

        AVG(
            DATE_PART('minute', session_end - session_start)
            + DATE_PART('hour', session_end - session_start) * 60
        ) AS session_length

    FROM pa_orders AS ors

    FULL JOIN pa_sessions AS sess
        ON ors.event_dt BETWEEN sess.session_start AND sess.session_end
       AND ors.user_id = sess.user_id

    GROUP BY
        CAST(COALESCE(ors.event_dt, sess.session_start) AS DATE),
        COALESCE(ors.user_id, sess.user_id),
        ors.order_id,
        COALESCE(sess.channel, 'N/A'),
        ors.revenue,
        sess.device
)

-- Aggregate advertising, session and order metrics
SELECT
    raw.event_dt,

    AVG(raw.session_length) AS session_length,
    COUNT(DISTINCT raw.order_id) AS orders,
    COUNT(DISTINCT raw.user_id) AS users,

    COUNT(
        DISTINCT CASE
            WHEN raw.order_id IS NOT NULL THEN raw.user_id
        END
    ) AS users_with_order,

    raw.channel,
    raw.ad_category,
    raw.device,

    MAX(pa_costs.costs) AS costs,
    SUM(raw.revenue) AS revenue

FROM (

    SELECT
        COALESCE(sess_or.event_dt, pa_costs.dt) AS event_dt,
        session_length,
        order_id,
        user_id,
        COALESCE(sess_or.channel, pa_costs.channel) AS channel,
        COALESCE(pa_costs.ad_category, 'N/A') AS ad_category,
        device,
        sess_or.revenue

    FROM sess_or

    FULL JOIN pa_costs
        ON sess_or.channel = pa_costs.channel
       AND sess_or.event_dt = pa_costs.dt

) AS raw

FULL JOIN pa_costs
    ON raw.channel = pa_costs.channel
   AND raw.event_dt = pa_costs.dt

GROUP BY
    raw.event_dt,
    raw.channel,
    raw.ad_category,
    raw.device

ORDER BY
    raw.event_dt;
