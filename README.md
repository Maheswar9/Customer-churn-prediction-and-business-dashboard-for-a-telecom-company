# Customer Churn Prediction & Dashboard

**Tech stack:** Python (Pandas, scikit-learn, TensorFlow/Keras), SQL, Tableau

## Project Structure

churn-prediction-dashboard/
├── .gitignore
├── README.md
├── requirements.txt
├── data/
│ ├── raw/
│ └── cleaned/
├── notebooks/
│ ├── 1_data_cleaning.ipynb
│ ├── 2_eda.ipynb
│ ├── 3_logistic_regression.ipynb
│ ├── 4_random_forest.ipynb
│ ├── 5_xgboost.ipynb
│ └── 6_neural_network.ipynb
├── scripts/
│ └── sql/
└── dashboards/


## Setup

1. Create & activate a virtual environment:
   ```bash
   python -m venv .venv
   source .venv/bin/activate     # macOS/Linux
   .\.venv\Scripts\Activate.ps1  # Windows PowerShell
2. Install Python dependencies:

pip install -r requirements.txt

See requirements.txt for exact package versions.


3. Place the raw Telco CSV in data/raw/ and run notebooks/1_data_cleaning.ipynb to produce data/cleaned/telco_churn_cleaned.csv.

## Usage & Outputs

1. **1_data_cleaning.ipynb**  
   - Run all cells to load `data/raw/WA_Fn-UseC_-Telco-Customer-Churn.csv`, clean it, and write `data/cleaned/telco_churn_cleaned.csv`.  
   - Output: cleaned CSV in `data/cleaned/`.

2. **3_logistic_regression.ipynb**  
   - Runs a Logistic Regression model end-to-end (train/test split, scaling, training, evaluation).  
   - Outputs:  
     - Metrics printed (accuracy, precision, recall, ROC-AUC).  
     - Confusion matrix .
     - ROC curve plot .
     - Coefficient table. 

4. **4_random_forest.ipynb**  
   - Similar flow with a Random Forest (including 5-fold CV).  
   - Outputs: best hyperparameters, CV AUC scores, test-set metrics, ROC curve, and feature‐importance bar chart.

5. **5_xgboost.ipynb**  
   - Trains and evaluates an XGBoost classifier.  
   - Outputs: model performance summary, ROC curve, and top‐10 feature importances.

6. **6_neural_network.ipynb**  
   - Builds, compiles, and trains a Keras neural net with EarlyStopping.  
   - Outputs: training vs. validation loss & AUC plots, test‐set metrics, and ROC curve.



