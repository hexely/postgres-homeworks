-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT chk_products_unit_price CHECK(unit_price > 0)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT chk_products_discontinued CHECK(discontinued IN (0, 1))

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
SELECT * INTO withdrawn_from_sale FROM products
WHERE discontinued = 1

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.

     '''чес слово только до этого и додумался. удалить  ограничение foreign_key проблем не составляет'''
     """проблемы возникают когда этот ключ надо обратно подключить к таблице с PRIME KEY где некоторые уже отсутствуют"""
     '''и пока вы это читаете, я уже спрашиваю у однокурсников кто как справился с этим заданием и что там у них за код такой'''
--удалить связь NOT NULL в колонке discontinued, product_name
ALTER TABLE products ALTER COLUMN discontinued DROP NOT NULL;
ALTER TABLE products ALTER COLUMN product_name DROP NOT NULL;
--замена на NULL discontinued = 1
UPDATE products SET product_name=NULL, supplier_id=NULL, category_id=NULL, quantity_per_unit=NULL, unit_price=NULL, units_in_stock=NULL, units_on_order=NULL, reorder_level=NULL, discontinued=NULL
WHERE discontinued = 1
