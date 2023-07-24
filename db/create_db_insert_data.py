import psycopg2
import pandas as pd
import logging
import os
from pathlib import Path

logging.basicConfig(
    level=logging.INFO,
    handlers=[logging.StreamHandler()],
    format="%(asctime)s [%(levelname)s] %(message)s",
)

logger = logging.getLogger(__name__)


def get_conn():
    logger.info("Creating Database Connection...")
    conn = psycopg2.connect(
        database=os.getenv('POSTGRES_DB'),
        user=os.getenv('POSTGRES_USER'),
        password=os.getenv('POSTGRES_PASSWORD'),
        host=os.getenv('POSTGRES_HOST'),
        port=os.getenv('POSTGRES_PORT'),
    )

    cur = conn.cursor()
    logger.info("Connection to Database stablished")

    return conn, cur


if __name__ == "__main__":
    conn, cur = get_conn()

    logger.info("Creating tables...")

    with open(Path(__file__).resolve().parent / "sql/make-tpch.sql", "r") as f:
        query = f.read()

    cur.execute(query)
    conn.commit()

    logger.info("Tables created")

    logger.info("Inserting data to DB...")

    #  Create file name to table name mapping
    files = {
        "region.sql": "region",
        "nation.sql": "nation",
        "customer.sql": "customer",
        "supplier.sql": "suppiler",
        "orders.sql": "orders",
        "part.sql": "part",
        "partsupp.sql": "partsupp",
        "lineitem.sql": "lineitem",
    }

    for file in files.keys():
        tablename = files[file]
    
        with open(Path(__file__).resolve().parent / "data/{}".format(file), "r") as f:
            query = f.read()

        try:
            logger.info(
                "Uploading data to the table {}...".format(tablename)
            )
            
            cur.execute(query)
            conn.commit()

            logger.info("{} uploaded to the Database".format(tablename))
        except Exception as e:
            logger.error("{}: {}".format(tablename, e))

    cur.close()
    conn.close()
