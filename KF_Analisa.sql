-------------------------------

CREATE TABLE kf_analisis1 AS
SELECT 
    ft.transaction_id, 
    ft.date, 
    ft.branch_id, 
    kc.branch_name, 
    kc.kota, 
    kc.provinsi, 
    kc.rating AS rating_cabang, 
    ft.customer_name, 
    ft.product_id, 
    pc.product_name, 
    pc.price AS actual_price, 
    ft.discount_percentage, 
     CASE
        WHEN pc.price <= 50000 THEN 0.10
        WHEN pc.price > 50000 AND pc.price <= 100000 THEN 0.15
        WHEN pc.price > 100000 AND pc.price <= 300000 THEN 0.20
        WHEN pc.price > 300000 AND pc.price <= 500000 THEN 0.25
        WHEN pc.price > 500000 THEN 0.30
    END AS persentase_gross_laba,
    ft.price AS nett_sales,
    ft.price * (
        CASE
            WHEN pc.price <= 50000 THEN 0.10
            WHEN pc.price > 50000 AND pc.price <= 100000 THEN 0.15
            WHEN pc.price > 100000 AND pc.price <= 300000 THEN 0.20
            WHEN pc.price > 300000 AND pc.price <= 500000 THEN 0.25
            WHEN pc.price > 500000 THEN 0.30
        END
    ) AS nett_profit,
    ft.rating AS rating_transaksi
FROM
    kimia_farma.kf_final_transaction ft
LEFT JOIN
    kimia_farma.kf_kantor_cabang kc ON ft.branch_id = kc.branch_id
LEFT JOIN
    kimia_farma.kf_product pc ON ft.product_id = pc.product_id;

--
