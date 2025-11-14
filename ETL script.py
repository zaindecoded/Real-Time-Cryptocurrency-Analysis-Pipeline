import pandas as pd
from sqlalchemy import create_engine, text

# Database Connection
engine = create_engine("mysql+pymysql://root:@localhost/crypto_dw")

csv_path = "C:/Users/admin/Downloads/coingecko_market.csv"
df = pd.read_csv(csv_path)
print("CSV Loaded Successfully!")
print(df.head())

dim_currency = df[['id', 'symbol', 'name']].drop_duplicates().reset_index(drop=True)
dim_currency.rename(columns={'id': 'currency_id'}, inplace=True)

dim_market = df[['market_cap_rank']].drop_duplicates().reset_index(drop=True)
dim_market['market_id'] = dim_market.index + 1

fact_market_data = df.merge(dim_currency, left_on='id', right_on='currency_id', how='left')
fact_market_data['market_id'] = fact_market_data['market_cap_rank']

with engine.begin() as conn:
    conn.execute(text("SET FOREIGN_KEY_CHECKS=0;"))

    dim_currency.to_sql("dim_currency", con=conn, if_exists="replace", index=False)
    dim_market.to_sql("dim_market", con=conn, if_exists="replace", index=False)
    fact_market_data.to_sql("fact_market_data", con=conn, if_exists="replace", index=False)

    conn.execute(text("SET FOREIGN_KEY_CHECKS=1;"))

print("CSV data successfully loaded into crypto_dw database!")
