DROP DATABASE IF EXISTS romand_database;
CREATE DATABASE romand_database;
USE romand_database;

CREATE TABLE detail_produk (
    ID_PROD VARCHAR(20) PRIMARY KEY,
    NAMA_PROD VARCHAR(255) NOT NULL,
    SHADE VARCHAR(100) NOT NULL,
    DESKRIPSI TEXT,
    HARGA INT NOT NULL,
    DISKON INT NOT NULL DEFAULT 0,
    KATEGORI VARCHAR(50),
    STOCK INT NOT NULL DEFAULT 0,
    STATUS_DEL VARCHAR(1) DEFAULT '0',
    FOTO_PROD VARCHAR(255),
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

CREATE TABLE customer (
    ID_CUST VARCHAR(20) PRIMARY KEY,
    EMAIL VARCHAR(100),
    `NAME` VARCHAR(50),
    PHONE VARCHAR(20),
    ADDRESS TEXT,
    PASSWORD_HASH CHAR(64), -- Panjang hash SHA-256 adalah 64 karakter
    STATUS_DEL VARCHAR(1) DEFAULT '0',
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

CREATE TABLE adminlogin (
	EMAIL VARCHAR(100) PRIMARY KEY,
    `ADMIN-PIN` VARCHAR(6),
    STATUS_DEL VARCHAR(1) DEFAULT '0',
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

CREATE TABLE transaksi (
    ID_TRANS VARCHAR(20) PRIMARY KEY,
    ID_CUST VARCHAR(20),
    TANGGAL TIMESTAMP NOT NULL,
    TOTAL INT NOT NULL,
    FOREIGN KEY (ID_CUST) REFERENCES customer(ID_CUST),
    STATUS_DEL VARCHAR(1) DEFAULT '0',
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

CREATE TABLE detail_transaksi(
    ID_TRANS VARCHAR(20),
    ID_PROD VARCHAR(20),
    HARGA INT NOT NULL,
    QTY INT NOT NULL,
    FOREIGN KEY (ID_PROD) REFERENCES detail_produk(ID_PROD),
    FOREIGN KEY (ID_TRANS) REFERENCES transaksi(ID_TRANS),
    STATUS_DEL VARCHAR(1) DEFAULT '0',
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
    -- PRIMARY KEY (ID_TRANS, ID_PROD)
);

CREATE TABLE keranjang (
    ID_CUST VARCHAR(20),
    ID_PROD VARCHAR(20),
    NAMA_PROD VARCHAR(255) NOT NULL,
    HARGA INT NOT NULL,
    SHADE VARCHAR(100) NOT NULL,
    QTY INT NOT NULL,
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0',
    FOREIGN KEY (ID_CUST) REFERENCES customer(ID_CUST),
    FOREIGN KEY (ID_PROD) REFERENCES detail_produk(ID_PROD)
);

CREATE TABLE wishlist (
    ID_CUST VARCHAR(20),
    ID_PROD VARCHAR(20),
    NAMA_PROD VARCHAR(255) NOT NULL,
    HARGA INT NOT NULL,
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0',
    FOREIGN KEY (ID_CUST) REFERENCES customer(ID_CUST),
    FOREIGN KEY (ID_PROD) REFERENCES detail_produk(ID_PROD)
);

CREATE TABLE message (
    MSG_ID INT AUTO_INCREMENT PRIMARY KEY,
    EMAIL VARCHAR(100),
    `NAME` VARCHAR(50),
    MESSAGE TEXT,
    CREATED_AT TIMESTAMP,
    STATUS_DEL VARCHAR(1) DEFAULT '0',
	IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

-- DISKON 5% = RM100902 RM101004 RM301008 RM101009
INSERT INTO detail_produk (ID_PROD, NAMA_PROD, SHADE, DESKRIPSI, HARGA, DISKON, KATEGORI, STOCK, STATUS_DEL, FOTO_PROD) VALUES
('RM100101', 'Juicy Lasting Tint', 'Bare Grape', 'Effortlessly achieve plump lips with high pigmented tints offered in fruity shades. Get a glossy look without the heavy or sticky feeling! Lips are lightly tinted after the shine wears off.', 229000, 0, 'Lips', 0, '0', 'img/romand-juicy.jpg'),
('RM200202', 'Juicy Lasting Tint', 'Nucademia', 'Effortlessly achieve plump lips with high pigmented tints offered in fruity shades. Get a glossy look without the heavy or sticky feeling! Lips are lightly tinted after the shine wears off.', 229000, 0, 'Lips', 0, '0', 'img/romand-juicy.jpg'),
('RM300401', 'The Universe Liquid Glitter', 'Mystic Moon', 'Daily point glitter eyeshadow with fine particles for radiant aegyo-sal looks.', 179000, 0, 'Eyes', 0, '0', 'img/romand-universe.jpg'),
('RM300601', 'The Universe Liquid Glitter', 'Minty Way','Daily point glitter eyeshadow with fine particles for radiant aegyo-sal looks.', 179000, 0, 'Eyes', 0, '0', 'img/romand-universe.jpg'),
('RM200801', 'Bare Water Cushion', 'Beige','Long lasting cushion that perfectly hides your textured skin and even pores.', 429000, 0, 'Face', 0, '0', 'img/romand-water.jpg'),
('RM200802', 'Bare Water Cushion', 'Sand', 'Long lasting cushion that perfectly hides your textured skin and even pores.', 429000, 0, 'Face', 0, '0', 'img/romand-water.jpg'),
('RM300901', 'Better Than Palette', 'Secret Garden', 'Secret Garden eyeshadow palettes provide remarkable contrast between dark and light shades for improved layerability. In #Mahogany Garden, you get an impressive spectrum of honey golds ranging from light beige to deep umber in matte and glittery finishes.', 500000, 0, 'Face', 0, '0', 'img/romand-palette.jpg'),
('RM100902', 'See-Through Veil Lighter', 'Moonkissed Veil', 'A new powder highlighter to brighten, draw attention, and stun. This Veilighter contours and reflects light beautifully for a goddess-like glow.', 199000, 5, 'Face', 0, '0', 'img/romand-veil.jpg'),
('RM300903', 'Better Than Cheek', 'Blueberry Chip', 'Featuring pastel colors inspired by dried fruits, this blush series helps to create a “my cheeks but better” look with natural hues and silky finishes. Formulated with sweat and sebum-absorbing powder for a long-lasting, refreshing finish.', 179000, 0, 'Face', 0, '0', 'img/romand-cheek.jpg'),
('RM101004', 'Han All Sharp Brow', 'Gentle Brown', 'A three-pronged attack for gorgeous eyebrows! Design detailed strokes with a 1.5mm tip and shading without flattening your eyebrows texture. Comes with a powder brush tip to minimize product fallout.', 189000, 5, 'Eyes', 0, '0', 'img/romand-sharp.jpg'),
('RM201005', 'Han All Brow Cara', 'Mild Woody', 'Comb, shape, and texturize your eyebrows with rom&nds Han All Brow Cara. Leaves a non-greasy, natural-looking matte finish without clumping or stickiness.', 199000, 0, 'Eyes', 0, '0', 'img/romand-brow.jpg'),
('RM301006', 'Zero Sun Clean SPF50+', 'Fresh', 'A daily sun cream that perfectly matches with different kinds of foundation for your changing skin condition every day. Its mild formula provides powerful UV protection (SPF 50+ / PA++++). Free of harmful ingredients such as PEG, BHT.', 169000, 0, 'Face', 0, '0', 'img/romand-sunscreen.jpg'),
('RM101007', 'Glasting Melting Balm', 'Sorbet Balm', 'The Glasting Melting Balm is a moisturizing balm with plant-based moisturizing oil that does not dry out! It provides a transparent and smooth watery glow without feeling stuffy.', 189000, 0, 'Lips', 0, '0', 'img/romand-glasting.jpg'),
('RM301008', 'Dewyful Water Tint', 'In Coral', 'Boost the color with a glossy glow! A dewy-ful & long-lasting lip tint that forms like a welcome rain on my lips.', 189000, 5, 'Lips', 0, '0', 'img/romand-dewyful.jpg'),
('RM101009', 'Blur Fudge Tint', 'Cool Rose Up', 'Fudge spreading on your lips! Its a completely matte finish without any glow.', 189000, 5, 'Lips', 0, '0', 'img/romand-blur.jpg'),
('RM301010', 'Better Than Shape', 'Walnut Grain', 'A seamless contour with finely ground dried grain features a warm or cool tone shade to help sculpt your face to your desired look! A not-too-dark-or-too-light shade that does not appear shiny or has a dirt-like look.', 199000, 0, 'Face', 0, '0', 'img/romand-shape.jpg');

INSERT INTO customer (ID_CUST, EMAIL, NAME, PHONE, ADDRESS, PASSWORD_HASH, STATUS_DEL) 
VALUES
('C001', 'minji@gmail.com', 'Minji', '1234567890', '123 La Vare, Seoul, South Korea', SHA2(CONCAT('C001', 'minji@gmail.com'), 256), '0'),
('C002', 'jihyun@gmail.com', 'Jihyun', '2345678901', '456 HYBS Building, Seoul, South Korea', SHA2(CONCAT('C002', 'jihyun@gmail.com'), 256), '0'),
('C003', 'soojin@gmail.com', 'Soojin', '3456789012', '789 Moonsun Apartment, Tokyo, Japan', SHA2(CONCAT('C003', 'soojin@gmail.com'), 256), '0'),
('C004', 'yeonwoo@gmail.com', 'Yeonwoo', '4567890123', '012 Huai Palace, Tokyo, Japan', SHA2(CONCAT('C004', 'yeonwoo@gmail.com'), 256), '0'),
('C005', 'sora@gmail.com', 'Sora', '5678901234', 'Venom Boulevard Block 9Q, Kyoto, Japan', SHA2(CONCAT('C005', 'sora@gmail.com'), 256), '0'),
('C006', 'haneul@gmail.com', 'Haneul', '6789012345', 'Cookie Monster Street, Kyoto, Japan', SHA2(CONCAT('C006', 'haneul@gmail.com'), 256), '0'),
('C007', 'jiwoo@gmail.com', 'Jiwoo', '1234567890', 'Luv Street, Bangkok, Thailand', SHA2(CONCAT('C007', 'jiwoo@gmail.com'), 256), '0'),
('C008', 'eunji@gmail.com', 'Eunji', '2345678901', 'Beige Percent Apartment, Bangkok, Thailand', SHA2(CONCAT('C008', 'eunji@gmail.com'), 256), '0'),
('C009', 'hyeonseo@gmail.com', 'Hyeonseo', '3456789012', 'Heart Bingo Building, Bangkok, Thailand', SHA2(CONCAT('C009', 'hyeonseo@gmail.com'), 256), '0'),
('C010', 'seunghee@gmail.com', 'Seunghee', '4567890123', '012 Canggu Street, Bali, Indonesia', SHA2(CONCAT('C010', 'seunghee@gmail.com'), 256), '0'),
('C011', 'jiyeon@gmail.com', 'Jiyeon', '5678901234', 'More or Less Apartment, Surabaya, Indonesia', SHA2(CONCAT('C011', 'jiyeon@gmail.com'), 256), '0'),
('C012', 'hayoon@gmail.com', 'Hayoon', '6789012345', 'Grand 88 Building, Jakarta, Indonesia', SHA2(CONCAT('C012', 'hayoon@gmail.com'), 256), '0'),
('C013', 'choiung@gmail.com', 'Choi Ung', '1234567890', 'Double Take Boulevard, Kuala Lumpur, Malaysia', SHA2(CONCAT('C013', 'choiung@gmail.com'), 256), '0'),
('C014', 'bubbi@gmail.com', 'Bubbi', '2345678901', '456 Biscoff Road, Kuala Lumpur, Malaysia', SHA2(CONCAT('C014', 'bubbi@gmail.com'), 256), '0'),
('C015', 'rijji@gmail.com', 'Rijji', '3456789012', '789 Yellow Lullaby Road, Kuala Lumpur, Malaysia', SHA2(CONCAT('C015', 'rijji@gmail.com'), 256), '0');

INSERT INTO transaksi (ID_TRANS, ID_CUST, TANGGAL, TOTAL, STATUS_DEL) VALUES
('T010424C001001', 'C001', '2024-04-01', 637550, '0'),
('T020424C002002', 'C002', '2024-04-02', 179000, '0'),
('T030424C003003', 'C003', '2024-04-03', 450000, '0'),
('T040424C004004', 'C004', '2024-04-04', 567000, '0'),
('T050424C005005', 'C005', '2024-04-05', 359100, '0'),
('T060424C006006', 'C006', '2024-04-06', 199000, '0'),
('T070424C007007', 'C007', '2024-04-07', 458000, '0'),
('T080424C008008', 'C008', '2024-04-08', 179000, '0'),
('T090424C009009', 'C009', '2024-04-09', 450000, '0'),
('T100424C010010', 'C010', '2024-04-10', 1287000, '0'),
('T110424C011011', 'C011', '2024-04-11', 359100, '0'),
('T120424C012012', 'C012', '2024-04-12', 179000, '0'),
('T130424C013013', 'C013', '2024-04-13', 458000, '0'),
('T140424C014014', 'C014', '2024-04-14', 179000, '0'),
('T150424C015015', 'C015', '2024-04-15', 450000, '0'),
('T160424C002016', 'C002', '2024-04-16', 598000, '0'),
('T170424C003017', 'C003', '2024-04-17', 527050, '0'),
('T180424C004018', 'C004', '2024-04-18', 686550, '0'),
('T190424C005019', 'C005', '2024-04-19', 517550, '0'),
('T200424C006020', 'C006', '2024-04-20', 348550, '0'),
('T210424C007021', 'C007', '2024-04-21', 657000, '0'),
('T220424C008022', 'C008', '2024-04-22', 429000, '0'),
('T230424C009023', 'C009', '2024-04-23', 358000, '0'),
('T240424C010024', 'C010', '2024-04-24', 1716000, '0'),
('T250424C011025', 'C011', '2024-04-25', 699000, '0'),
('T260424C009023', 'C009', '2024-04-26', 358000, '0'),
('T260424C009024', 'C010', '2024-04-26', 179000, '0'),
('T260424C009025', 'C011', '2024-04-26', 429000, '0'),
('T270424C004004', 'C004', '2024-04-27', 169000, '0'),
('T280424C004004', 'C004', '2024-04-28', 199000, '0'),
('T290424C004004', 'C004', '2024-04-29', 189000, '0');

-- DISKON 5% = RM100902 RM101004 RM301008 RM101009 T1 T5 T11
INSERT INTO detail_transaksi (ID_TRANS, ID_PROD, HARGA, QTY, STATUS_DEL) VALUES
('T010424C001001', 'RM100101', 229000, 2, '0'),
('T010424C001001', 'RM301008', 179550, 1, '0'),
('T020424C002002', 'RM200202', 179000, 1, '0'),
('T030424C003003', 'RM300401', 500000, 1, '0'),
('T040424C004004', 'RM300601', 189000, 3, '0'),
('T050424C005005', 'RM101004', 179550, 2, '0'),
('T060424C006006', 'RM201005', 199000, 1, '0'),
('T070424C007007', 'RM100101', 229000, 2, '0'),
('T080424C008008', 'RM200202', 179000, 1, '0'),
('T090424C009009', 'RM300401', 500000, 1, '0'),
('T100424C010010', 'RM200802', 429000, 3, '0'),
('T110424C011011', 'RM101004', 179550, 2, '0'),
('T120424C012012', 'RM300601', 179000, 1, '0'),
('T130424C013013', 'RM100101', 229000, 2, '0'),
('T140424C014014', 'RM300901', 179000, 1, '0'),
('T150424C015015', 'RM300601', 500000, 1, '0'),
('T160424C002016', 'RM200801', 429000, 1, '0'),
('T160424C002016', 'RM301006', 169000, 1, '0'),
('T170424C003017', 'RM301006', 169000, 2, '0'),
('T170424C003017', 'RM100902', 199000 - (199000 * 0.05), 1, '0'),
('T180424C004018', 'RM301006', 169000, 3, '0'),
('T180424C004018', 'RM101007', 189000 - (189000 * 0.05), 1, '0'),
('T190424C005019', 'RM301006', 169000, 2, '0'),
('T190424C005019', 'RM101007', 189000 - (189000 * 0.05), 1, '0'),
('T200424C006020', 'RM301006', 169000, 1, '0'),
('T200424C006020', 'RM101007', 189000 - (189000 * 0.05), 1, '0'),
('T210424C007021', 'RM100101', 229000, 2, '0'),
('T210424C007021', 'RM301010', 199000, 1, '0'),
('T220424C008022', 'RM200801', 429000, 1, '0'),
('T230424C009023', 'RM300903', 179000, 2, '0'),
('T240424C010024', 'RM200802', 429000, 4, '0'),
('T250424C011025', 'RM300401', 500000, 1, '0'),
('T250424C011025', 'RM301010', 199000, 1, '0'),
('T260424C009023', 'RM300903', 179000, 2, '0'),
('T260424C009024', 'RM300601', 179000, 1, '0'),
('T260424C009025', 'RM200801', 429000, 1, '0'),
('T270424C004004', 'RM301006', 169000, 1, '0'),
('T280424C004004', 'RM301010', 199000, 1, '0'),
('T290424C004004', 'RM101007', 189000, 1, '0');

INSERT INTO keranjang (ID_CUST, ID_PROD, NAMA_PROD, HARGA, SHADE, QTY) VALUES 
('C001', 'RM101009', 'PINKFLASH 2 IN 1 Dual-ended Liquid Lipstik ombrelips Matte Velvet High Pigment', 35000, 'V01', 1),
('C001', 'RM100902', 'PINKFLASH 2 IN 1 Dual-ended Liquid Lipstik ombrelips Matte Velvet High Pigment', 35000, 'M01', 2),
('C002', 'RM300903', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 18900, 'G01', 1),
('C002', 'RM301006', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 18900, 'G03', 3),
('C003', 'RM100101', 'Juicy Lasting Tint', 229000, 'Bare Grape', 1),
('C003', 'RM300401', 'The Universe Liquid Glitter', 179000, 'Mystic Moon', 2),
('C004', 'RM200801', 'Bare Water Cushion', 429000, 'Beige', 1),
('C004', 'RM101004', 'Han All Sharp Brow', 189000, 'Gentle Brown', 3),
('C005', 'RM301006', 'Zero Sun Clean SPF50+', 169000, 'Fresh', 2),
('C005', 'RM101009', 'Blur Fudge Tint', 189000, 'Cool Rose Up', 1),
('C006', 'RM300601', 'The Universe Liquid Glitter', 179000, 'Minty Way', 1),
('C006', 'RM301010', 'Better Than Shape', 199000, 'Walnut Grain', 1),
('C007', 'RM200802', 'Bare Water Cushion', 429000, 'Sand', 2),
('C007', 'RM301008', 'Dewyful Water Tint', 189000, 'In Coral', 1),
('C008', 'RM300903', 'Better Than Cheek', 179000, 'Blueberry Chip', 1);

INSERT INTO wishlist (ID_CUST, ID_PROD, NAMA_PROD, HARGA, IS_WAREHOUSE) VALUES
('C001', 'RM100101', 'Juicy Lasting Tint', 229000, '0'),
('C001', 'RM200202', 'Juicy Lasting Tint', 229000, '0'),
('C002', 'RM300401', 'The Universe Liquid Glitter', 179000, '0'),
('C002', 'RM300601', 'The Universe Liquid Glitter', 179000, '0'),
('C003', 'RM200801', 'Bare Water Cushion', 429000, '0'),
('C003', 'RM200802', 'Bare Water Cushion', 429000, '0'),
('C004', 'RM300901', 'Better Than Palette', 500000, '0'),
('C004', 'RM100902', 'See-Through Veil Lighter', 199000, '0'),
('C005', 'RM300903', 'Better Than Cheek', 179000, '0'),
('C005', 'RM101004', 'Han All Sharp Brow', 189000, '0'),
('C006', 'RM201005', 'Han All Brow Cara', 199000, '0'),
('C006', 'RM301006', 'Zero Sun Clean SPF50+', 169000, '0'),
('C007', 'RM101007', 'Glasting Melting Balm', 189000, '0'),
('C007', 'RM301008', 'Dewyful Water Tint', 189000, '0'),
('C008', 'RM101009', 'Blur Fudge Tint', 189000, '0');

INSERT INTO adminlogin (EMAIL, `ADMIN-PIN`) VALUES
('alfredwitono@gmail.com', '123456');

INSERT INTO message (EMAIL, NAME, MESSAGE, CREATED_AT, STATUS_DEL, IS_WAREHOUSE) VALUES
('minji@gmail.com', 'Minji', 'Im excited to try out some new beauty products! Do you have any recommendations?', NOW(), '0', '0'),
('minji@gmail.com', 'Minji', 'The packaging of your products is so cute! Cant wait to see how they look on.', NOW(), '0', '0'),
('jihyun@gmail.com', 'Jihyun', 'I have been looking for a good lip gloss. Do you have any that are long-lasting?', NOW(), '0', '0'),
('jihyun@gmail.com', 'Jihyun', 'Your eyeshadow palettes look stunning! Which one would you recommend for everyday wear?', NOW(), '0', '0'),
('soojin@gmail.com', 'Soojin', 'I need a good moisturizing lip balm. Any suggestions?', NOW(), '0', '0'),
('soojin@gmail.com', 'Soojin', 'Your lipsticks are gorgeous! Cant wait to try them out.', NOW(), '0', '0'),
('yeonwoo@gmail.com', 'Yeonwoo', 'I am in love with your highlighters! They look so pigmented.', NOW(), '0', '0'),
('yeonwoo@gmail.com', 'Yeonwoo', 'Do you have any tips for contouring? I am a beginner.', NOW(), '0', '0'),
('sora@gmail.com', 'Sora', 'Your face palettes look so versatile! Can they be used for different skin tones?', NOW(), '0', '0'),
('sora@gmail.com', 'Sora', 'I have heard great things about your concealers! Excited to try them out.', NOW(), '0', '0'),
('haneul@gmail.com', 'Haneul', 'Your brow pencils look very precise! Perfect for achieving natural-looking brows.', NOW(), '0', '0'),
('haneul@gmail.com', 'Haneul', 'Do you have any recommendations for a good setting powder?', NOW(), '0', '0'),
('jiwoo@gmail.com', 'Jiwoo', 'I love a good matte lipstick! Which shade would you recommend for everyday wear?', NOW(), '0', '0'),
('eunji@gmail.com', 'Eunji', 'Thank you for the fast delivery! Cant wait to try out the products.', NOW(), '0', '0'),
('hyeonseo@gmail.com', 'Hyeonseo', 'Your lip glosses look amazing! Cant wait to add them to my collection.', NOW(), '0', '0');

-- Customer ID
DELIMITER //
CREATE FUNCTION generate_cust_id() 
RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
    DECLARE new_id VARCHAR(10);
    SET new_id = (SELECT CONCAT('C', LPAD(COALESCE(MAX(SUBSTRING(ID_CUST, 2)), 0) + 1, 3, '0')) FROM CUSTOMER);
    RETURN new_id;
END //
DELIMITER ;

-- New Customer Trigger
DELIMITER //
CREATE TRIGGER before_customer_insert
BEFORE INSERT ON customer
FOR EACH ROW
BEGIN
    SET NEW.ID_CUST = generate_cust_id();
END //
DELIMITER ;

-- Generate Product ID Trigger
DELIMITER $$

CREATE TRIGGER generate_product_id
BEFORE INSERT ON detail_produk
FOR EACH ROW
BEGIN
    DECLARE category_code CHAR(1);
    DECLARE shade_count INT;
    DECLARE counter INT;
    DECLARE new_id CHAR(10);
    
    -- Determine the category code
    IF NEW.KATEGORI = 'Lips' THEN
        SET category_code = '1';
    ELSEIF NEW.KATEGORI = 'Eyes' THEN
        SET category_code = '2';
    ELSEIF NEW.KATEGORI = 'Face' THEN
        SET category_code = '3';
    END IF;
    
    -- Count the existing products in the same category
    SELECT COUNT(*) + 1 INTO counter 
    FROM detail_produk 
    WHERE LEFT(ID_PROD, 4) = CONCAT('RM', category_code);

    -- Count the existing shades for the product
    SELECT COUNT(*) + 1 INTO shade_count 
    FROM detail_produk 
    WHERE NAMA_PROD = NEW.NAMA_PROD;
    
    -- Generate the new ID
    SET new_id = CONCAT('RM', category_code, LPAD(counter, 3, '0'), LPAD(shade_count, 2, '0'));
    
    -- Set the new ID to the NEW row
    SET NEW.ID_PROD = new_id;
END$$

DELIMITER ;

-- Generate Transaction ID Function
DELIMITER //

CREATE FUNCTION generate_id_trans() 
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
    DECLARE new_id VARCHAR(20);
    DECLARE prefix VARCHAR(1);
    DECLARE formatted_date VARCHAR(6);
    DECLARE seq_num INT;
    
    SET prefix = 'T';
    SET formatted_date = DATE_FORMAT(CURRENT_DATE, '%y%m%d');
    
    SELECT COALESCE(MAX(CAST(SUBSTRING(ID_TRANS, 10) AS UNSIGNED)), 0) + 1 INTO seq_num
    FROM transaksi
    WHERE SUBSTRING(ID_TRANS, 2, 6) = formatted_date;
    
    SET new_id = CONCAT(prefix, formatted_date, 'C', LPAD(seq_num, 6, '0'));
    RETURN new_id;
END //

DELIMITER ;

-- Trigger for Inserting new Transaction
DELIMITER //

CREATE TRIGGER before_transaksi_insert
BEFORE INSERT ON transaksi
FOR EACH ROW
BEGIN
    SET NEW.ID_TRANS = generate_id_trans();
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_transaksidetail_insert
BEFORE INSERT ON detail_transaksi
FOR EACH ROW
BEGIN
	DECLARE last_id_trans VARCHAR(20);
    
    -- Get the last inserted ID_TRANS from TRANSAKSI
    SELECT ID_TRANS INTO last_id_trans 
    FROM TRANSAKSI 
    ORDER BY TANGGAL DESC 
    LIMIT 1;

    SET NEW.ID_TRANS = last_id_trans;
END //

DELIMITER ;

-- View for product sales
DROP VIEW IF EXISTS ProductSales;
CREATE VIEW ProductSales AS
SELECT 
    D.ID_PROD,
    D.NAMA_PROD,
    D.SHADE,
    SUM(T.QTY) AS TotalSales
FROM 
    detail_produk D
INNER JOIN 
    detail_transaksi T ON D.ID_PROD = T.ID_PROD
GROUP BY 
    D.ID_PROD, D.NAMA_PROD, D.SHADE;
    
-- View for Monthly Sales
DROP VIEW IF EXISTS MonthlySales;
CREATE VIEW MonthlySales AS
SELECT
    YEAR(TANGGAL) AS Year,
    MONTH(TANGGAL) AS Month,
    SUM(TOTAL) AS TotalSales
FROM
    transaksi
GROUP BY
    Year,
    Month;
    
-- View for Brand Sales
CREATE VIEW BrandPurchaseFreq AS
SELECT
    CASE
        WHEN S.TransOrigin = 'Dior' THEN 'Dior'
        WHEN S.TransOrigin = 'Pinkflash' THEN 'Pinkflash'
        WHEN S.TransOrigin = 'Romand' THEN 'Romand'
        ELSE 'Other' -- You can handle other brands if needed
    END AS Brand,
    COUNT(*) AS PurchaseFreq
FROM
    sales_fact S
INNER JOIN
    detail_produk D ON S.ID_PROD = D.ID_PROD
GROUP BY
    Brand;
