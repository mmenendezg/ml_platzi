from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import psycopg2
import pg8000

# Setting the service name in docker-compose file
host = 'postgres' 

Engine = create_engine(f'postgresql+psycopg2://mmenendezg:PassMimgPostgres@{host}/newspaper')
Session = sessionmaker(bind=Engine)
Base = declarative_base()