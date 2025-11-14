import requests
import pandas as pd
from sqlalchemy import create_engine, text
from datetime import datetime


engine = create_engine("mysql+pymysql://root:@localhost:3306/crypto_dw")

try:
    with engine.connect() as conn:
        result = conn.execute(text("SELECT DATABASE();"))
        print(f"Connected to:", result.scalar())
except Exception as e:
    print("Connection failed:", e)
    exit()

# ==============================
print("Fetching data from CoinGecko...")
url = "https://api.coingecko.com/api/v3/coins/markets"
params = {"vs_currency": "usd", "order": "market_cap_desc", "per_page": 100, "page": 1}
response = requests.get(url, params=params)
data = response.json()

df = pd.DataFrame(data)
print(f"Fetched {len(df)} records from CoinGecko")


# Currency dimension (no image)
dim_currency = df[["id", "symbol", "name"]].copy()
dim_currency.rename(columns={"id": "currency_id"}, inplace=True)
dim_currency.drop_duplicates(subset=["currency_id"], inplace=True)

# Date dimension
today = datetime.now()
dim_date = pd.DataFrame({
    "date_id": [today.strftime("%Y%m%d")],
    "date": [today.date()],
    "day": [today.day],
    "month": [today.month],
    "year": [today.year],
    "weekday": [today.strftime("%A")]
})

fact_market = df[[
    "id", "current_price", "market_cap", "total_volume", "high_24h", "low_24h"
]].copy()
fact_market.rename(columns={"id": "currency_id"}, inplace=True)
fact_market["date_id"] = today.strftime("%Y%m%d")
fact_market["load_time"] = datetime.now()

# Upload to MySQL
with engine.begin() as conn:
    conn.execute(text("SET FOREIGN_KEY_CHECKS = 0;"))

    dim_currency.to_sql("dim_currency", con=conn, if_exists="replace", index=False)
    dim_date.to_sql("dim_date", con=conn, if_exists="replace", index=False)
    fact_market.to_sql("fact_market", con=conn, if_exists="replace", index=False)

    conn.execute(text("SET FOREIGN_KEY_CHECKS = 1;"))

print("Data Warehouse updated successfully!")
