-- Описание сети аптек. Включает в себя: аптеки, лекарства, категории лекарств, 
-- провизоров, информацию о наличии и продажах лекарств. Аптеки описываются:
-- адресом, номером, ближайшей станцией метро. Лекарства характеризуются: 
-- названием, дозировкой, количеством (или объёмом), производителем, указанием 
-- требуется ли рецепт для приобретения или нет, указанием категорий, к которым 
-- данное лекарство относится, ценой. Категория лекарства описывается только 
-- названием. Провизоры характеризуются: фамилией, именем, отчеством, датой 
-- рождения, ИНН, серией и номером паспорта, указанием аптеки, в которой 
-- работают. Информация о наличии лекарств состоит из: указания аптеки, указания 
-- лекарства, количества упаковок. Информация о продаже лекарства состоит из:
-- указания аптеки, указания лекарства, указания провизора, который продал 
-- лекарство, даты продажи, количества упаковок.
-- Одно и тоже лекарство не может принадлежать разным категориям.

CREATE TABLE `std_847`.`pharmacy` ( `id` INT NOT NULL AUTO_INCREMENT , `address` VARCHAR(50) NOT NULL , `code` INT NOT NULL , `metro` VARCHAR(50) NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`medicine` ( `id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(100) NOT NULL , `dosage` VARCHAR(50) NOT NULL , `count` INT NOT NULL , `manufacturer` VARCHAR(100) NOT NULL , `need_recipe` BOOLEAN NOT NULL , `fk_category` INT NOT NULL , `price` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`category` ( `id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(100) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`pharmacist` ( `id` INT NOT NULL AUTO_INCREMENT , `last_name` VARCHAR(50) NOT NULL , `first_name` VARCHAR(50) NOT NULL , `middle_name` VARCHAR(50) NOT NULL , `birthday` DATE NOT NULL , `INN` SMALLINT NOT NULL , `passport` VARCHAR(11) NOT NULL , `fk_pharmacy` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`available_medicine` ( `fk_pharmacy` INT NOT NULL , `fk_medicine` INT NOT NULL , `count` INT NOT NULL , PRIMARY KEY(`fk_pharmacy`, `fk_medicine`)) ENGINE = InnoDB;
CREATE TABLE `std_847`.`sell_medicine` ( `id` INT NOT NULL AUTO_INCREMENT , `fk_medicine` INT NOT NULL , `fk_pharmacy` INT NOT NULL , `fk_pharmacist` INT NOT NULL , `date` DATE NOT NULL , `count` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE pharmacist ADD FOREIGN KEY (fk_pharmacy) REFERENCES pharmacy (id);
ALTER TABLE medicine ADD FOREIGN KEY (fk_category) REFERENCES category (id);
ALTER TABLE sell_medicine ADD FOREIGN KEY (fk_medicine) REFERENCES medicine (id);
ALTER TABLE sell_medicine ADD FOREIGN KEY (fk_pharmacy) REFERENCES pharmacy (id);
ALTER TABLE sell_medicine ADD FOREIGN KEY (fk_pharmacist) REFERENCES pharmacist (id);
ALTER TABLE available_medicine ADD FOREIGN KEY (fk_pharmacy) REFERENCES pharmacy (id);
ALTER TABLE available_medicine ADD FOREIGN KEY (fk_medicine) REFERENCES medicine (id);

INSERT INTO `pharmacy` (`id`, `address`, `code`, `metro`) VALUES
(1, 'Moscow', 1, 'Автозаводская'),
(2, 'Питер', 2, 'Щелковская'),
(3, 'Волоколамская ул', 3, 'Автозаводская'),
(4, 'Мос область', 4, NULL);

INSERT INTO `pharmacist` (`id`, `last_name`, `first_name`, `middle_name`, `birthday`, `INN`, `passport`, `fk_pharmacy`) VALUES
(1, 'Вася', 'ыыыы', 'Ывф', '2019-12-02', 12, '12133', 1),
(2, 'Коля', 'ыыыы', 'Ывф', '2019-12-02', 12, '12133', 1),
(3, 'Петя', 'ыыыы', 'Ывф', '2019-12-02', 12, '12133', 2),
(4, 'Григорий', 'ыыыы', 'Ывф', '2019-12-02', 12, '12133', 1),
(5, 'Вова', 'ыыыы', 'Ывф', '2019-12-02', 12, '12133', 3),
(6, 'Максим', 'ыыыы', 'Ывф', '2019-12-02', 12, '12133', 4),
(7, 'Игорь', 'ыыыы', 'Ывф', '2019-12-02', 12, '12133', 2),
(8, 'Николай', 'ыыыы', 'Ывф', '2019-12-02', 12, '12133', 4);

INSERT INTO `medicine` (`id`, `name`, `dosage`, `count`, `manufacturer`, `need_recipe`, `fk_category`, `price`) VALUES
(1, 'Нурофен', '1', 10, 'НЕ важно', 1, 2, 1000),
(2, 'Парацетамол', '2', 22, 'Не важно', 0, 1, 200),
(3, 'Анальгин', '2 грамма', 1, 'Не важно', 0, 1, 300);

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Противовоспалительное'),
(2, 'Жаропонижающее'),
(3, 'Слабительное');

INSERT INTO `available_medicine` (`fk_pharmacy`, `fk_medicine`, `count`) VALUES
(1, 2, 2),
(2, 3, 23),
(3, 2, 3),
(3, 3, 2),
(4, 1, 20);
