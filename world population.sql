-- Membuat Database
CREATE DATABASE populasi_DB;

-- Menggunakan Database
\c populasi_DB;

-- Membuat Tabel Population
CREATE TABLE population (
    rank SERIAL PRIMARY KEY,
    country VARCHAR(100),
    population_2024 BIGINT,
    yearly_change FLOAT,
    net_change BIGINT,
    density FLOAT,
    land_area BIGINT,
    migrants_net BIGINT,
    fertility_rate FLOAT,
    median_age INT,
    urban_population_percent FLOAT,
    world_share FLOAT
);

-- Negara dengan Kepadatan Penduduk > 500
SELECT country, population_2024  
FROM population  
WHERE density > 500;

-- Negara dengan Populasi Urban > 80%
SELECT country, urban_population_percent
FROM population
WHERE CAST(NULLIF(urban_population_percent, 'N.A.') AS NUMERIC) > 80;

-- Negara dengan Pertumbuhan Populasi Negatif
SELECT country, population_2024, yearly_change
FROM population
WHERE yearly_change < 0;

-- 25 Negara dengan Tingkat Kesuburan Tertinggi
SELECT country, fertility_rate
FROM population
ORDER BY fertility_rate DESC
LIMIT 25;

-- Negara dengan Migrasi Positif
SELECT country, migrants_net
FROM population
WHERE migrants_net > 0;

-- Total Populasi Dunia
SELECT SUM(population_2024) AS total_population_world
FROM population;

-- Rata-rata Usia Median
SELECT AVG(median_age) AS average_median_age
FROM population;

-- Mengelompokkan Negara Berdasarkan Benua
SELECT 
    CASE 
        WHEN country IN ('Indonesia', 'China', 'Japan') THEN 'Asia'
        WHEN country IN ('United States', 'Canada', 'Mexico') THEN 'Amerika Utara'
        WHEN country IN ('Germany', 'France', 'UK') THEN 'Eropa'
        WHEN country IN ('Nigeria', 'South Africa', 'Egypt') THEN 'Afrika'
        WHEN country IN ('Brazil', 'Argentina', 'Chile') THEN 'Amerika Selatan'
        ELSE 'Other'
    END AS benua,
    SUM(population_2024) AS total_population
FROM population
GROUP BY 1;

-- Negara dengan Populasi di Atas Rata-rata
SELECT country, population_2024
FROM population
WHERE population_2024 > (SELECT AVG(population_2024) FROM population);

-- Negara dengan Tingkat Kesuburan di Bawah Rata-rata dan Urbanisasi Tinggi
SELECT country, urban_population_percent
FROM population
WHERE fertility_rate < (SELECT AVG(fertility_rate) FROM population);

