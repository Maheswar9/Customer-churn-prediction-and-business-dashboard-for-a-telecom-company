-- Loads the cleaned Telco churn CSV into the telco_customers table.
--
-- USAGE:
--   1. In your OS shell, cd into your project root (so that
--      data/cleaned/telco_churn_cleaned.csv is a valid relative path):
--        cd /path/to/churn-prediction-dashboard
--
--   2. Launch psql and connect to your churn_db:
--        psql -U postgres -d churn_db
--
--   3. From the psql> prompt, run this script:
--        \i scripts/sql/2_load_data.sql
--
--   4. You should see output like "COPY 7032", indicating rows loaded.


\copy telco_customers
  FROM 'C:\Users\NPG\Desktop\maheswar\churn_prediction\churn-prediction-dashboard\data\cleaned\telco_churn_cleaned.csv'
  WITH (FORMAT csv, HEADER true);
