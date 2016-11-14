SELECT count(eleme_order_id) order_num 
	FROM dw_aly.dw_al_tms_apollo_waybill_wide 
WHERE dt = '2016-11-08' 
    AND created_at > get_date(-1) 
    AND shipping_state = 40 
GROUP BY taker_id


limit 200;


SELECT a.taker_id, 
            overtime_sum/sum overtime_ratio 
FROM 
      (SELECT taker_id, 
            count(*) sum 
      FROM dw_aly.dw_al_tms_apollo_waybill_wide 
      WHERE dt = '2016-11-09' 
                  AND created_at > get_date(-1) 
                  AND shipping_state = 40 
      GROUP BY taker_id ) a 
JOIN 
      (SELECT taker_id, 
            count(*) overtime_sum 
      FROM dw_aly.dw_al_tms_apollo_waybill_wide 
      WHERE dt = '2016-11-09' 
                  AND created_at > get_date(-1) 
                  AND shipping_state = 40 
                  AND is_overtime = 1 
      GROUP BY taker_id ) b 
      ON a.taker_id = b.taker_id
      order by overtime_ratio desc
      limit 500; 


select * from dw_aly.dw_al_tms_apollo_waybill_wide 
where dt = '2016-11-09' 
                  AND created_at > get_date(-1) 
                  AND shipping_state = 40 
                  and taker_id in
(
SELECT a.taker_id
FROM 
      (SELECT taker_id, 
            count(*) sum 
      FROM dw_aly.dw_al_tms_apollo_waybill_wide 
      WHERE dt = '2016-11-09' 
                  AND created_at > get_date(-1) 
                  AND shipping_state = 40 
      GROUP BY taker_id ) a 
JOIN 
      (SELECT taker_id, 
            count(*) overtime_sum 
      FROM dw_aly.dw_al_tms_apollo_waybill_wide 
      WHERE dt = '2016-11-09' 
                  AND created_at > get_date(-1) 
                  AND shipping_state = 40 
                  AND is_overtime = 1 
      GROUP BY taker_id ) b 
ON a.taker_id = b.taker_id
order by overtime_sum/sum desc limit 200
)