-- Ligi olmayan takımı ekleme
INSERT INTO Takim (id, adi, id_league, kurulus_yili, attigi_gol, yedigi_gol, puan, seviye)
VALUES (1, 'Takim1', NULL, 2000, 50, 30, 70, 1);

-- İsmi “Türkiye” olan ülkenin liglerinin listesi
SELECT * FROM Lig WHERE id_country = (SELECT id FROM Country WHERE name = 'Türkiye');

-- İsmi “Türkiye” olan ülkenin takımlarının listesi
SELECT * FROM Takim WHERE id_league IN (SELECT id FROM Lig WHERE id_country = (SELECT id FROM Country WHERE name = 'Türkiye'));

-- İsmi “Türkiye” olan en üst seviyeli ligdeki puan tablosu
SELECT * FROM Takim WHERE id_league = (SELECT id FROM Lig WHERE id_country = (SELECT id FROM Country WHERE name = 'Türkiye') AND seviye = 1) ORDER BY puan DESC;

-- Türkiye liglerindeki puan ortalamaları
SELECT AVG(puan) FROM Takim WHERE id_league IN (SELECT id FROM Lig WHERE id_country = (SELECT id FROM Country WHERE name = 'Türkiye'));

-- Bir ligin Gol kralı
SELECT O.adi, O.soyadi, T.adi AS takim_adi, C.name AS nereli
FROM Oyuncu O
INNER JOIN Takim T ON O.id_team = T.id
INNER JOIN Country C ON O.id_country = C.id
WHERE O.attigi_gol = (SELECT MAX(attigi_gol) FROM Oyuncu WHERE id_team IN (SELECT id FROM Takim WHERE id_league = 'LIG_ID'));

-- Tüm liglerde attığı gol yediği golden daha küçük olan takımlar
SELECT * FROM Takim WHERE attigi_gol < yedigi_gol;

-- Bir takımın oyuncularının toplam gol sayısı ve takımın gol sayısı
SELECT T.id, T.adi, T.attigi_gol AS takim_gol, SUM(O.attigi_gol) AS oyuncu_gol_toplami
FROM Takim T
LEFT JOIN Oyuncu O ON T.id = O.id_team
WHERE T.id = 'TAKIM_ID'
GROUP BY T.id, T.adi, T.attigi_gol;
