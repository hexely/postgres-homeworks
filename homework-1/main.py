"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv
import os


customers_data_path = os.path.join(os.path.dirname(__file__), 'north_data/customers_data.csv')
employees_data_path = os.path.join(os.path.dirname(__file__), 'north_data/employees_data.csv')
orders_data_path = os.path.join(os.path.dirname(__file__), 'north_data/orders_data.csv')

with psycopg2.connect(host="localhost", database="north", user="postgres", password="12345") as conn:
    with conn.cursor() as cur:

        with open(employees_data_path, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for data in reader:
                cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)", (data['employee_id'],
                                                                                      data['first_name'],
                                                                                      data['last_name'],
                                                                                      data['title'],
                                                                                      data['birth_date'],
                                                                                      data['notes']))

        with open(customers_data_path, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for data in reader:
                cur.execute("INSERT INTO customers VALUES (%s, %s, %s)", (data['customer_id'],
                                                                          data['company_name'],
                                                                          data['contact_name']))

        with open(orders_data_path, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for data in reader:
                cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)", (data['order_id'],
                                                                               data['customer_id'],
                                                                               data['employee_id'],
                                                                               data['order_date'],
                                                                               data['ship_city']))

conn.close()
