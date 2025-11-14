from sqlalchemy import create_engine, text

# create connection engine
engine = create_engine("mysql+pymysql://root:@localhost:3306/crypto_dw")

try:
    with engine.connect() as conn:
        result = conn.execute(text("SELECT DATABASE();"))
        print("Connected to:", result.scalar())
except Exception as e:
    print("Connection failed:", e)

