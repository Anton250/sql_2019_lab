Описание сети аптек. Включает в себя: аптеки, лекарства, категории лекарств, 
провизоров, информацию о наличии и продажах лекарств. Аптеки описываются:
адресом, номером, ближайшей станцией метро. Лекарства характеризуются: 
названием, дозировкой, количеством (или объёмом), производителем, указанием 
требуется ли рецепт для приобретения или нет, указанием категорий, к которым 
данное лекарство относится, ценой. Категория лекарства описывается только 
названием. Провизоры характеризуются: фамилией, именем, отчеством, датой 
рождения, ИНН, серией и номером паспорта, указанием аптеки, в которой 
работают. Информация о наличии лекарств состоит из: указания аптеки, указания 
лекарства, количества упаковок. Информация о продаже лекарства состоит из:
указания аптеки, указания лекарства, указания провизора, который продал 
лекарство, даты продажи, количества упаковок.
Одно и тоже лекарство не может принадлежать разным категориям.

CREATE TABLE `std_847`.`pharmacy` ( `id` INT NOT NULL AUTO_INCREMENT , `address` VARCHAR(50) NOT NULL , `code` INT NOT NULL , `metro` VARCHAR(50) NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`medicine` ( `id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(100) NOT NULL , `dosage` VARCHAR(50) NOT NULL , `count` INT NOT NULL , `manufacturer` VARCHAR(100) NOT NULL , `need_recipe` BOOLEAN NOT NULL , `fk_category` INT NOT NULL , `price` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`category` ( `id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(100) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`pharmacist` ( `id` INT NOT NULL AUTO_INCREMENT , `last_name` VARCHAR(50) NOT NULL , `first_name` VARCHAR(50) NOT NULL , `middle_name` VARCHAR(50) NOT NULL , `birthday` DATE NOT NULL , `INN` SMALLINT NOT NULL , `passport` VARCHAR(11) NOT NULL , `fk_pharmacy` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`available_medicine` ( `fk_pharmacy` INT NOT NULL , `fk_medicine` INT NOT NULL , `count` INT NOT NULL , UNIQUE `pharmacy_medicine` (`fk_pharmacy`, `fk_medicine`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`sell_medicine` ( `id` INT NOT NULL AUTO_INCREMENT , `fk_medicine` INT NOT NULL , `fk_pharmacy` INT NOT NULL , `fk_pharmacist` INT NOT NULL , `date` DATE NOT NULL , `count` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE pharmacist ADD FOREIGN KEY (fk_pharmacy) REFERENCES pharmacy (id);
ALTER TABLE medicine ADD FOREIGN KEY (fk_category) REFERENCES category (id);
ALTER TABLE sell_medicine ADD FOREIGN KEY (fk_medicine) REFERENCES medicine (id);
ALTER TABLE sell_medicine ADD FOREIGN KEY (fk_pharmacy) REFERENCES pharmacy (id);
ALTER TABLE sell_medicine ADD FOREIGN KEY (fk_pharmacist) REFERENCES pharmacist (id);
ALTER TABLE available_medicine ADD FOREIGN KEY (fk_pharmacy) REFERENCES pharmacy (id);
ALTER TABLE available_medicine ADD FOREIGN KEY (fk_medicine) REFERENCES medicine (id);

Выборки, есть в отдельных файлах.
SELECT pharmacy.address, pharmacy.code, SUM(sell_medicine.count * medicine.price) as total_price FROM pharmacy 
LEFT JOIN sell_medicine ON pharmacy.id = sell_medicine.fk_pharmacy
JOIN medicine ON sell_medicine.fk_medicine = medicine.id
GROUP BY pharmacy.id
ORDER BY total_price DESC;

SELECT pharmacist.first_name, pharmacist.last_name, pharmacist.middle_name,
SUM(sell_medicine.count * medicine.price) as total_sells
FROM pharmacist 
JOIN sell_medicine ON pharmacist.id = sell_medicine.fk_pharmacist
JOIN medicine ON sell_medicine.fk_medicine = medicine.id
GROUP BY pharmacist.id
ORDER BY total_sells DESC
LIMIT 1;

SELECT medicine.name, pharmacy.address, pharmacy.code, available_medicine.count 
FROM available_medicine
JOIN medicine ON medicine.id = available_medicine.fk_medicine
JOIN pharmacy ON pharmacy.id = available_medicine.fk_pharmacy
JOIN category ON category.id = medicine.fk_category
WHERE category.name = 'Противовоспалительное' AND pharmacy.metro = 'Автозаводская';

