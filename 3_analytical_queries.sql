-- churn rate by tenure bucket

WITH churn_by_tenure AS (
  SELECT
    CASE
      WHEN tenure < 12 THEN '<12 months'
      WHEN tenure BETWEEN 12 AND 24 THEN '12–24 months'
      ELSE '>24 months'
    END                                AS tenure_bucket,
    COUNT(*) FILTER (WHERE churn = 1)  AS churned,
    COUNT(*) FILTER (WHERE churn = 0)  AS retained,
    ROUND(100.0 * AVG(churn), 1)       AS churn_rate_pct,
    MIN(tenure)                        AS min_tenure
  FROM telco_customers
  GROUP BY 1
)
SELECT
  tenure_bucket,
  churned,
  retained,
  churn_rate_pct
FROM churn_by_tenure
ORDER BY min_tenure;

-- churn rate by contract type 

SELECT
  'Month-to-month' AS contract_type,
  ROUND(
    100.0 * COUNT(*) FILTER (
      WHERE churn=1
        AND contract_one_year=0
        AND contract_two_year=0
    ) / COUNT(*)
  , 1) AS churn_rate_pct
FROM telco_customers

UNION ALL

SELECT
  'One year',
  ROUND(100.0 * AVG(churn) FILTER (WHERE contract_one_year = 1), 1)
FROM telco_customers

UNION ALL

SELECT
  'Two year',
  ROUND(100.0 * AVG(churn) FILTER (WHERE contract_two_year = 1), 1)
FROM telco_customers;

--churn rate by payment method 

SELECT
  payment_method,
  ROUND(100.0 * AVG(churn), 1) AS churn_rate_pct
FROM (
  SELECT
    CASE
      WHEN paymentmethod_electronic_check      = 1 THEN 'Electronic check'
      WHEN paymentmethod_mailed_check          = 1 THEN 'Mailed check'
      WHEN paymentmethod_credit_card_automatic = 1 THEN 'Credit card (auto)'
      ELSE 'Bank transfer (auto)'
    END AS payment_method,
    churn
  FROM telco_customers
) AS sub
GROUP BY payment_method
ORDER BY churn_rate_pct DESC
LIMIT 5;

--Compare Spending & Tenure Between Churners vs. Retained


SELECT
  CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS status,
  ROUND(AVG(monthlycharges), 2)   AS avg_monthly_charge,
  ROUND(AVG(totalcharges),   2)   AS avg_total_revenue,
  ROUND(AVG(tenure),          1)   AS avg_tenure_months
FROM telco_customers
GROUP BY status;


--lost revenue 
SELECT
  SUM(monthlycharges * tenure) AS lost_revenue
FROM telco_customers
WHERE churn = 1;

--Churn Rate by Senior Citizen & Dependents


SELECT
  seniorcitizen,
  dependents,
  100.0 * AVG(churn) AS churn_rate_pct
FROM telco_customers
GROUP BY seniorcitizen, dependents
ORDER BY seniorcitizen DESC, dependents DESC;


-- tenure survival curve 

WITH tenure_counts AS (
  SELECT
    tenure,
    COUNT(*) AS total_at_tenure,
    SUM(churn) FILTER (WHERE churn = 1) AS churned_at_tenure
  FROM telco_customers
  GROUP BY tenure
), cum AS (
  SELECT
    tenure,
    SUM(total_at_tenure) OVER (ORDER BY tenure DESC)       AS still_active,
    SUM(churned_at_tenure) OVER (ORDER BY tenure)           AS cumulative_churned
  FROM tenure_counts
)
SELECT
  tenure,
  still_active,
  cumulative_churned,
  ROUND(100.0 * cumulative_churned / (still_active + cumulative_churned), 1) AS cumulative_churn_pct
FROM cum
ORDER BY tenure;

--High-Risk Segment Identification via Revenue & Churn
SELECT
  customerid,
  tenure,
  monthlycharges,
  totalcharges
FROM telco_customers
WHERE churn = 1
ORDER BY totalcharges DESC
LIMIT 10;
