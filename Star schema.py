from sqlalchemy import create_engine, Table, Column, Integer, String, Float, MetaData, ForeignKey

engine = create_engine("mysql+pymysql://root:@localhost:3306/crypto_dw")
meta = MetaData()

dim_currency = Table(
    'dim_currency', meta,
    Column('currency_id', Integer, primary_key=True, autoincrement=True),
    Column('symbol', String(10)),
    Column('name', String(50)),
    Column('category', String(50))
)

dim_date = Table(
    'dim_date', meta,
    Column('date_id', Integer, primary_key=True, autoincrement=True),
    Column('date', String(20)),
    Column('day', Integer),
    Column('month', Integer),
    Column('year', Integer)
)

fact_market_data = Table(
    'fact_market_data', meta,
    Column('market_id', Integer, primary_key=True, autoincrement=True),
    Column('currency_id', Integer, ForeignKey('dim_currency.currency_id')),
    Column('date_id', Integer, ForeignKey('dim_date.date_id')),
    Column('price_usd', Float),
    Column('market_cap_usd', Float),
    Column('volume_usd', Float)
)

meta.create_all(engine)
print("Tables created successfully!")
