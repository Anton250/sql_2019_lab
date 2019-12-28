-- Выберете информацию об аптеках и объемах их продаж (в рублях), отсортировав от больших объемов к меньшим.

SELECT pharmacy.address, pharmacy.code, SUM(IF(sell_medicine.count, sell_medicine.count * medicine.price, 0)) as total_price 
FROM pharmacy 
LEFT JOIN sell_medicine ON pharmacy.id = sell_medicine.fk_pharmacy 
LEFT JOIN medicine ON sell_medicine.fk_medicine = medicine.id 
GROUP BY pharmacy.id 
ORDER BY total_price DESC;


