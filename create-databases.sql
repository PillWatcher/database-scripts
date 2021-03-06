DROP DATABASE PILLWATCHER;

CREATE DATABASE IF NOT EXISTS PILLWATCHER
  CHARACTER SET UTF8
  COLLATE UTF8_GENERAL_CI;
  
USE PILLWATCHER;

DROP TABLE SUPPLY;
DROP TABLE APPLIED_MEDICATION;
DROP TABLE CUP;
DROP TABLE MEDICATION;
DROP TABLE MEDICINE;
DROP TABLE PRESCRIPTION;
DROP TABLE NURSE_PATIENT;
DROP TABLE PATIENT;
DROP TABLE NURSE;
DROP TABLE ADMIN;
DROP TABLE USER;

CREATE TABLE IF NOT EXISTS USER (
    ID_USER BIGINT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    DOCUMENT VARCHAR(11) NOT NULL,
    IMAGE_URL VARCHAR(200),
    ENRYPTED_PASS VARCHAR(200),
    CONSTRAINT USER_AK UNIQUE (ID_USER)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS ADMIN (
    ID_ADMIN BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_USER BIGINT NOT NULL,
    EMAIL VARCHAR(50) NOT NULL,
    INCLUSION_DATE DATE NOT NULL,
    UPDATE_DATE DATE NOT NULL,
    CONSTRAINT ADMIN_FK FOREIGN KEY (ID_USER)
        REFERENCES USER (ID_USER),
    CONSTRAINT ADMIN_AK UNIQUE (EMAIL)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS NURSE (
    ID_NURSE BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_USER BIGINT NOT NULL,
    EMAIL VARCHAR(50) NOT NULL,
    COREN VARCHAR(15) NOT NULL,
    FEDERATIVE_UNIT VARCHAR(2) NOT NULL,
    BIOMETRY BOOLEAN NOT NULL,
    PHONE VARCHAR(15) NOT NULL,
    INCLUSION_DATE DATE NOT NULL,
    UPDATE_DATE DATE NOT NULL,
    CONSTRAINT NURSE_FK FOREIGN KEY (ID_USER)
        REFERENCES USER (ID_USER),
    CONSTRAINT NURSE_AK UNIQUE (EMAIL)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS PATIENT (
    ID_PATIENT BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_USER BIGINT NOT NULL,
    BORN_DATE DATE NOT NULL,
    OBSERVATION VARCHAR(250),
    INCLUSION_DATE DATE NOT NULL,
    UPDATE_DATE DATE NOT NULL,
    CONSTRAINT PATIENT_FK FOREIGN KEY (ID_USER)
        REFERENCES USER (ID_USER)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS NURSE_PATIENT (
    ID_NURSE_PAT BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_NURSE BIGINT NOT NULL,
    ID_PATIENT BIGINT NOT NULL,
    CONSTRAINT NURSE_PATIENT_FK FOREIGN KEY (ID_PATIENT)
        REFERENCES PATIENT (ID_PATIENT),
    CONSTRAINT NURSE_PATIENT_FK_2 FOREIGN KEY (ID_NURSE)
        REFERENCES NURSE (ID_NURSE)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS PRESCRIPTION (
    ID_PRESCRIPTION BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_PATIENT BIGINT NOT NULL,
    IMAGE_URL VARCHAR(200),
    INCLUSION_DATE DATE NOT NULL,
    UPDATE_DATE DATE NOT NULL,
    VALIDITY_DATE DATE NOT NULL,
    CONSTRAINT PRESCRIPTION_FK FOREIGN KEY (ID_PATIENT)
        REFERENCES PATIENT (ID_PATIENT)
)  ENGINE=INNODB;

-- Atualizar
CREATE TABLE IF NOT EXISTS MEDICINE (
    ID_MEDICINE BIGINT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(150) NOT NULL,
    DOSAGE INT NOT NULL,
    DOSAGE_TYPE VARCHAR(50) NOT NULL,
    INCLUSION_DATE DATE NOT NULL,
    UPDATE_DATE DATE NOT NULL,
    CONSTRAINT MEDICINE_AK UNIQUE (DOSAGE_TYPE , DOSAGE, NAME)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS CUP (
    ID_CUP BIGINT AUTO_INCREMENT PRIMARY KEY,
    COLOR VARCHAR(50) NOT NULL,
    TAG VARCHAR(255) NOT NULL,
    CONSTRAINT CUP_AK UNIQUE (TAG)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS MEDICATION (
    ID_MEDICATION BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_PRESCRIPTION BIGINT NOT NULL,
    ID_MEDICINE BIGINT NOT NULL,
    QUANTITY INT NOT NULL,
    INTERVAL_TIME INT NOT NULL,
    BATCH VARCHAR(200) NOT NULL,
    OBSERVATION VARCHAR(255) NOT NULL,
    AVAILABLE_QUANTITY INT NOT NULL,
    START_DATE DATE NOT NULL,
    UPDATE_DATE DATE NOT NULL,
    INCLUSION_DATE DATE NOT NULL,
    EXPIRATION_DATE DATE NOT NULL,
    LOCATION INT NOT NULL,
    ID_CUP BIGINT NOT NULL,
    CONSTRAINT MEDICATION_FK FOREIGN KEY (ID_PRESCRIPTION)
        REFERENCES PRESCRIPTION (ID_PRESCRIPTION),
    CONSTRAINT MEDICATION_FK2 FOREIGN KEY (ID_MEDICINE)
        REFERENCES MEDICINE (ID_MEDICINE),
    CONSTRAINT MEDICATION_FK3 FOREIGN KEY (ID_CUP)
        REFERENCES CUP (ID_CUP),
    CONSTRAINT MEDICATION_AK UNIQUE (ID_PRESCRIPTION , ID_MEDICINE)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS APPLIED_MEDICATION (
    ID_APPLIED_MEDICATION BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_NURSE BIGINT NOT NULL,
    ID_MEDICATION BIGINT NOT NULL,
    MEDICATION_DATE DATE NOT NULL,
    NEXT_MEDICATION_DATE DATE NOT NULL,
    CONSTRAINT NURSE_MEDICATION_FK FOREIGN KEY (ID_NURSE)
        REFERENCES NURSE (ID_NURSE),
    CONSTRAINT APPLIED_MEDICATION_FK2 FOREIGN KEY (ID_MEDICATION)
        REFERENCES MEDICATION (ID_MEDICATION)
)  ENGINE=INNODB;

-- ATUALIZAR
CREATE TABLE IF NOT EXISTS SUPPLY (
    ID_SUPPLY BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_NURSE BIGINT NOT NULL,
    ID_MEDICATION BIGINT NOT NULL,
    QUANTITY INT NOT NULL,
    INCLUSION_DATE DATE NOT NULL,
    UPDATE_DATE DATE NOT NULL,
    CONFIRMED_DATE DATE NOT NULL,
    SUCCESS INT NOT NULL,
    CONSTRAINT SUPPLY_FK FOREIGN KEY (ID_NURSE)
        REFERENCES NURSE (ID_NURSE),
    CONSTRAINT SUPPLY_FK2 FOREIGN KEY (ID_MEDICATION)
        REFERENCES MEDICATION (ID_MEDICATION)
)  ENGINE=INNODB;

COMMIT;



