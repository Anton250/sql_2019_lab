-- Выберете все противовоспалительные лекарства в аптеке рядом с метро Автозаводская.

SELECT medicine.name, pharmacy.address, pharmacy.code, available_medicine.count 
FROM available_medicine
JOIN medicine ON medicine.id = available_medicine.fk_medicine
JOIN pharmacy ON pharmacy.id = available_medicine.fk_pharmacy
JOIN category ON category.id = medicine.fk_category
WHERE category.name = 'Противовоспалительное' AND pharmacy.metro = 'Автозаводская';

