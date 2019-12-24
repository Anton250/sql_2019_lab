-- Выберете провизора, который продал лекарств на самую большую сумму.


SELECT pharmacist.first_name, pharmacist.last_name, pharmacist.middle_name,
SUM(sell_medicine.count * medicine.price) as total_sells
FROM pharmacist 
JOIN sell_medicine ON pharmacist.id = sell_medicine.fk_pharmacist
JOIN medicine ON sell_medicine.fk_medicine = medicine.id
GROUP BY pharmacist.id
ORDER BY total_sells DESC
LIMIT 1;
