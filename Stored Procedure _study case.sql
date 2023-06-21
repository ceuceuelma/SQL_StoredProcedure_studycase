SELECT * FROM ds.studentsperformance;

-- Jawaban 1 membuat stored procedure dasar
DELIMITER $$
CREATE PROCEDURE get_all_data () 
BEGIN
    SELECT * FROM ds.studentsperformance;
END $$
DELIMITER ;

CALL get_all_data();

-- Jawaban 2 membuat stored procedure dengan memasukan parameter IN
-- Buatlah stored procedure untuk memunculkan seluruh data dengan memasukkan race_or_ethnicity
DELIMITER $$
CREATE PROCEDURE get_all_data_by_race (IN race_group VARCHAR(100))
BEGIN
    SELECT * FROM ds.studentsperformance WHERE race_or_ethnicity = race_group;
END $$ 
DELIMITER ;

SET @race = 'group A' ;
CALL get_all_data_by_race(@race);

-- Jawaban 3.a. membuat stored procedure dengan menggunakan parameter OUT
-- Buatlah stored procedure untuk mendapatkan rata-rata nilai math pada tabel ds.studentsperformance
DELIMITER $$
CREATE PROCEDURE get_math_score_avg (OUT math_score_avg FLOAT)
BEGIN
    SELECT AVG(ds.studentsperformance.math_score) INTO math_score_avg
    FROM ds.studentsperformance;
END $$
DELIMITER ;

CALL get_math_score_avg(@rerata_nilai_math);
SELECT @rerata_nilai_math;

-- Jawaban 3.b.
SELECT * FROM ds.studentsperformance WHERE reading_score > @rerata_nilai_math;

-- Jawaban 4
DELIMITER $$
CREATE PROCEDURE get_gend_math_score_avg (IN gender_var VARCHAR(255), OUT math_score_avg FLOAT)
BEGIN
    SELECT AVG(ds.studentsperformance.math_score) INTO math_score_avg
    FROM ds.studentsperformance WHERE gender = gender_var;
END $$ DELIMITER ;

SET @jenis_gender = 'male';
CALL get_gend_math_score_avg(@jenis_gender, @rerata_nilai_math);
SELECT @jenis_gender, @rerata_nilai_math;

-- Jawaban 5

DROP TABLE IF EXISTS id_buku;
DROP PROCEDURE IF EXISTS buatidbuku;

CREATE TABLE id_buku (id INT);

SELECT * FROM id_buku;

INSERT INTO id_buku VALUES (0);

DELIMITER $$
CREATE PROCEDURE buatidbuku() 
BEGIN 
	DECLARE Counter Int ;
	SET
		Counter = 0;
	WHILE Counter <= 5 DO
		INSERT INTO
			id_buku (id)
		VALUES
			(Counter);
		SET
			Counter = Counter + 1;
	END WHILE;
END $$ DELIMITER ;

CALL buatidbuku();

SELECT * FROM id_buku;


-- Jawaban 6
DELIMITER $$
CREATE PROCEDURE hitung_luas (
    IN jenis VARCHAR (255),
    IN x FLOAT,
    IN y FLOAT,
    OUT hasil FLOAT,
    OUT keterangan VARCHAR (255)
) BEGIN
    CASE
        WHEN jenis = 'segitiga' THEN SET hasil = 0.5 * x * y, keterangan = 'Perhitungan berhasil!';
        WHEN jenis = 'persegi panjang' THEN SET hasil = x * y, keterangan = 'Perhitungan berhasil!';
        ELSE SET hasil = NULL ; SET keterangan = 'Perhitungan gagal. Bangun datar tidak didukung';
    END CASE;
END $$
DELIMITER ;

SET @jenis_bangun_datar = 'segitiga';-- atau SET @jenis_bangun_datar = 'persegi panjang'
SET @x = 10 ; -- atau angka berapapun, jenis data FLOAT
SET @y = 20 ; -- atau angka berapapun, jenis data FLOAT

CALL hitung_luas(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
SELECT @jenis_bangun_datar, @x, @y, @luas, @keterangan;

-- Persegi panjang
SET @jenis_bangun_datar = 'persegi panjang';-- atau SET @jenis_bangun_datar = 'persegi panjang'
SET @x = 10 ; -- atau angka berapapun, jenis data FLOAT
SET @y = 20 ; -- atau angka berapapun, jenis data FLOAT

CALL hitung_luas(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
SELECT @jenis_bangun_datar, @x, @y, @luas, @keterangan;

-- Lingkarang
SET @jenis_bangun_datar = 'lingkaran';-- atau SET @jenis_bangun_datar = 'persegi panjang'
SET @x = 10 ; -- atau angka berapapun, jenis data FLOAT
SET @y = 20 ; -- atau angka berapapun, jenis data FLOAT

CALL hitung_luas(@jenis_bangun_datar, @x, @y, @luas, @keterangan);
SELECT @jenis_bangun_datar, @x, @y, @luas, @keterangan;