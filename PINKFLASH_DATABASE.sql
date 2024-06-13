drop database if exists pinkflash_database;
CREATE DATABASE IF NOT EXISTS pinkflash_database;
USE pinkflash_database;

-- Tabel adminlogin
CREATE TABLE adminlogin (
	EMAIL VARCHAR(100) PRIMARY KEY,
    `ADMIN-PIN` VARCHAR(6),
    STATUS_DEL VARCHAR(1) DEFAULT '0',
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

-- Tabel DETAIL_PRODUK
CREATE TABLE IF NOT EXISTS detail_produk (
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

-- Tabel CUSTOMER
CREATE TABLE IF NOT EXISTS customer (
	ID_CUST VARCHAR(20) PRIMARY KEY,
    EMAIL VARCHAR(100),
    `NAME` VARCHAR(50),
    PHONE VARCHAR(20),
    ADDRESS TEXT,
    PASSWORD_HASH CHAR(64), -- Panjang hash SHA-256 adalah 64 karakter
    STATUS_DEL VARCHAR(1) DEFAULT '0',
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

-- Tabel TRANSAKSI
CREATE TABLE IF NOT EXISTS transaksi (
    ID_TRANS VARCHAR(20) PRIMARY KEY,
    ID_CUST VARCHAR(20),
    TANGGAL TIMESTAMP NOT NULL,
    TOTAL INT NOT NULL,
    FOREIGN KEY (ID_CUST) REFERENCES customer(ID_CUST),
    STATUS_DEL VARCHAR(1) DEFAULT '0',
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

-- Tabel DETAIL_TRANSAKSI
CREATE TABLE IF NOT EXISTS detail_transaksi(
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

-- Tabel keranjang
CREATE TABLE IF NOT EXISTS keranjang (
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

-- Tabel wishlist
CREATE TABLE IF NOT EXISTS wishlist (
    ID_CUST VARCHAR(20),
    ID_PROD VARCHAR(20),
    NAMA_PROD VARCHAR(255) NOT NULL,
    HARGA INT NOT NULL,
    IS_WAREHOUSE VARCHAR(1) DEFAULT '0',
    FOREIGN KEY (ID_CUST) REFERENCES customer(ID_CUST),
    FOREIGN KEY (ID_PROD) REFERENCES detail_produk(ID_PROD)
);

-- Tabel message
CREATE TABLE message (
    MSG_ID INT AUTO_INCREMENT PRIMARY KEY,
    EMAIL VARCHAR(100),
    `NAME` VARCHAR(50),
    MESSAGE TEXT,
    CREATED_AT TIMESTAMP,
    STATUS_DEL VARCHAR(1) DEFAULT '0',
	IS_WAREHOUSE VARCHAR(1) DEFAULT '0'
);

-- disc 5%: 'PF100102', 'PF100103', 'PF100202', 'PF100301', 'PF200503', 'PF301101', 'PF301201', 'PF301301'
-- Insert PRODUK
INSERT INTO detail_produk (ID_PROD, NAMA_PROD, SHADE, DESKRIPSI, HARGA, DISKON, KATEGORI, STOCK, STATUS_DEL, FOTO_PROD) VALUES 
('PF100101', 'PINKFLASH 2 IN 1 Dual-ended Lipstik Matte Velvet', 'V01', 'Brand new dual-ended design, more shades and more texture, satisfied with your variety of makeup finish. 💕TIPS：Before applying lipstick, use PINKFLASH lip oil to moisturize the lips.', 35000, 0, 'Lips', 100, '0', '0'),
('PF100102', 'PINKFLASH 2 IN 1 Dual-ended Lipstik Matte Velvet', 'M01', 'Brand new dual-ended design, more shades and more texture, satisfied with your variety of makeup finish. 💕TIPS：Before applying lipstick, use PINKFLASH lip oil to moisturize the lips.', 35000, 5, 'Lips', 100, '0', '0'),
('PF100103', 'PINKFLASH 2 IN 1 Dual-ended Lipstik Matte Velvet', 'D01', 'Brand new dual-ended design, more shades and more texture, satisfied with your variety of makeup finish. 💕TIPS：Before applying lipstick, use PINKFLASH lip oil to moisturize the lips.', 35000, 5, 'Lips', 100, '0', '0'),
('PF100201', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 'G01', 'Easy to use, unique color and brightness, different wearing produces different effects, choose different colors on different occasions to show a different you. 💜Contains coconut oil to perfectly moisturize the lips and provide a shiny effect on the lips.', 18900, 0, 'Lips', 100, '0', '0'),
('PF100202', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 'G03', 'Easy to use, unique color and brightness, different wearing produces different effects, choose different colors on different occasions to show a different you. 💜Contains coconut oil to perfectly moisturize the lips and provide a shiny effect on the lips.', 18900, 5, 'Lips', 100, '0', '0'),
('PF100203', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 'S01', 'Easy to use, unique color and brightness, different wearing produces different effects, choose different colors on different occasions to show a different you. 💜Contains coconut oil to perfectly moisturize the lips and provide a shiny effect on the lips.', 18900, 0, 'Lips', 100, '0', '0'),
('PF100301', 'PINKFLASH Natural Lip Oil Moisturize', '01', 'Effectively repair the lip skin barrier, making lips look healthier, softer and smoother.', 25900, 5, 'Lips', 100, '0', '0'),
('PF100401', 'PINKFLASH PinkDiary Velvet Matte Lip Cream', 'BB03', 'The lightweight, long-lasting velvet matte texture creates the same velvet makeup effect as Korean idols.', 29900, 0, 'Lips', 100, '0', '0'),
('PF100402', 'PINKFLASH PinkDiary Velvet Matte Lip Cream', 'NUO2', 'The lightweight, long-lasting velvet matte texture creates the same velvet makeup effect as Korean idols.', 29900, 0, 'Lips', 100, '0', '0'),
('PF100403', 'PINKFLASH PinkDiary Velvet Matte Lip Cream', 'PK02', 'The lightweight, long-lasting velvet matte texture creates the same velvet makeup effect as Korean idols.', 29900, 0, 'Lips', 100, '0', '0'),
('PF200501', 'PINKFLASH 3 Shades Eyeshadow Palette Giltter', 'PK01', 'High color pigmentation and easy to apply. Smooth and even color in one swipe, easy to create stunning eye makeup.', 45900, 0, 'Eyes', 100, '0', '0'),
('PF200502', 'PINKFLASH 3 Shades Eyeshadow Palette Giltter', 'BR02', 'High color pigmentation and easy to apply. Smooth and even color in one swipe, easy to create stunning eye makeup.', 45900, 0, 'Eyes', 100, '0', '0'),
('PF200503', 'PINKFLASH 3 Shades Eyeshadow Palette Giltter', 'RD01', 'High color pigmentation and easy to apply. Smooth and even color in one swipe, easy to create stunning eye makeup.', 45900, 5, 'Eyes', 100, '0', '0'),
('PF200601', 'PINKFLASH 2-in-1 Eyebrow Cream & Powder Gel', '01 Deep Brown', 'The two textures can be used alone or in combination to easily create different styles of eyebrow makeup!', 40000, 0, 'Eyes', 100, '0', '0'),
('PF200602', 'PINKFLASH 2-in-1 Eyebrow Cream & Powder Gel', '02 Soft Brown', 'The two textures can be used alone or in combination to easily create different styles of eyebrow makeup!', 40000, 0, 'Eyes', 100, '0', '0'),
('PF200603', 'PINKFLASH 2-in-1 Eyebrow Cream & Powder Gel', '03 Reddish Brown', 'The latest brow product adopts a two-in-one innovative design. One layer is brow powder and the other is brow gel, allowing you to have two brow products at the same time! The two textures can be used alone or in combination to easily create different styles of eyebrow makeup!', 40000, 0, 'Eyes', 100, '0', '0'),
('PF200701', 'PINKFLASH 1mm Micro Fine Eyebrow Pencil', 'GR01-NATURAL GREY', '1mm Micro Fine Retractable Eyebrow Pencil with a unique precision flat tip, helps you draw realistic hair-like strokes for naturally groomed eyebrows. This eyebrow pencil can draw ultra-thin lines of 1mm with accuracy, and its break-resistant, stay-sharp filling allows you to easily line, fill, and define brows!', 30699, 0, 'Eyes', 100, '0', '0'),
('PF200702', 'PINKFLASH 1mm Micro Fine Eyebrow Pencil', 'BR01-CHOCOLATE BROWN', '1mm Micro Fine Retractable Eyebrow Pencil with a unique precision flat tip, helps you draw realistic hair-like strokes for naturally groomed eyebrows. This eyebrow pencil can draw ultra-thin lines of 1mm with accuracy, and its break-resistant, stay-sharp filling allows you to easily line, fill, and define brows!', 30699, 0, 'Eyes', 100, '0', '0'),
('PF300801', 'PINKFLASH OhMyLove 4 in 1 Multiple Face Palette', '01 MANDARIN LATTE', 'Practical face palette, contains the eyeshadow, the blush, the contouring and the highlight, one palette has multi-purpose, convenient and efficient.', 75000, 0, 'Face', 100, '0', '0'),
('PF300802', 'PINKFLASH OhMyLove 4 in 1 Multiple Face Palette', '01 STRAWBERRY ICE', 'Practical face palette, contains the eyeshadow, the blush, the contouring and the highlight, one palette has multi-purpose, convenient and efficient.', 75000, 0, 'Face', 100, '0', '0'),
('PF300901', 'PINKFLASH OhMySelf Weightless Long Lasting All-day', '01-VANILLA', 'Sheer and long-lasting makeup, matte and waterproof, very tenacious and high coverage, I can bring the most comfortable experience to your face.', 33500, 0, 'Face', 100, '0', '0'),
('PF300902', 'PINKFLASH OhMySelf Weightless Long Lasting All-day', '03-WARM BEIGE', 'Sheer and long-lasting makeup, matte and waterproof, very tenacious and high coverage, I can bring the most comfortable experience to your face.', 33500, 0, 'Face', 100, '0', '0'),
('PF300903', 'PINKFLASH OhMySelf Weightless Long Lasting All-day', '04-MEDIUM PEACH', 'Sheer and long-lasting makeup, matte and waterproof, very tenacious and high coverage, I can bring the most comfortable experience to your face.', 33500, 0, 'Face', 100, '0', '0'),
('PF301001', 'PINKFLASH Breathable Liquid Concealer', '01-VANILLA', 'Effectively cover blemishes such as dark circles/acne/acne scar, make the face light and natural, easily create flawless makeup.', 29000, 0, 'Face', 100, '0', '0'),
('PF301002', 'PINKFLASH Breathable Liquid Concealer', '02-SAND BEIGE', 'Effectively cover blemishes such as dark circles/acne/acne scar, make the face light and natural, easily create flawless makeup.', 29000, 0, 'Face', 100, '0', '0'),
('PF301003', 'PINKFLASH Breathable Liquid Concealer', '03-WARM BEIGE', 'Effectively cover blemishes such as dark circles/acne/acne scar, make the face light and natural, easily create flawless makeup.', 29000, 0, 'Face', 100, '0', '0'),
('PF301101', 'PINKFLASH Oil Controller Loose Powder', '000-ALL SKIN TONES', 'Matte and natural flawless makeup effect. 💫Oil Controller - It can control oil in 1 second and not feel oily in all day, creat a extreme matte makeup.', 33000, 5, 'Face', 100, '0', '0'),
('PF301201', 'PINKFLASH OhMyHoney Blush', 'O01', 'RADIANT BLUSH: Richly pigmented，long lastinghighly and buildable, the beautiful matte and shimmery shades of Blush are the perfect cheeky pop of color for every skin tone. Shape and highlight your best facial features. Highly pigmented, easy to blend, give you a natural looking flush all day', 25000, 5, 'Face', 100, '0', '0'),
('PF301202', 'PINKFLASH OhMyHoney Blush', 'P04', 'RADIANT BLUSH: Richly pigmented，long lastinghighly and buildable, the beautiful matte and shimmery shades of Blush are the perfect cheeky pop of color for every skin tone. Shape and highlight your best facial features. Highly pigmented, easy to blend, give you a natural looking flush all day', 25000, 0, 'Face', 100, '0', '0'),
('PF301301', 'PINKFLASH OhMyShow Highlighter Contour', 'S01-FLOAT', 'PinkFlash new two color contouring powder. Easy to use, dense contour is used to emphasize the desired face shape. smooth, light and has excellent pigmentation, it can easily create a 3D effect on the face.', 25000, 5, 'Face', 100, '0', '0'),
('PF301302', 'PINKFLASH OhMyShow Highlighter Contour', 'S02-DROP', 'PinkFlash new two color contouring powder. Easy to use, dense contour is used to emphasize the desired face shape. smooth, light and has excellent pigmentation, it can easily create a 3D effect on the face.', 25000, 0, 'Face', 100, '0', '0')
;

-- Table CUSTOMER
INSERT INTO CUSTOMER (ID_CUST, EMAIL, NAME, PHONE, ADDRESS, PASSWORD_HASH, STATUS_DEL) VALUES 
('C001', 'john.doe@example.com', 'John Doe', '1234567890', '123 Main St, Springfield, IL, 62701, USA', 'hash1', '0'),
('C002', 'jane.smith@example.com', 'Jane Smith', '0987654321', '456 Elm St, Los Angeles, CA, 90001, USA', 'hash2', '0'),
('C003', 'michael.johnson@example.com', 'Michael Johnson', '5551234567', '789 Oak St, New York, NY, 10001, USA', 'hash3', '0'),
('C004', 'emily.davis@example.com', 'Emily Davis', '7778889999', '101 Maple St, Chicago, IL, 60601, USA', 'hash4', '0'),
('C005', 'chris.wilson@example.com', 'Chris Wilson', '4445556666', '202 Pine St, Houston, TX, 77001, USA', 'hash5', '0'),
('C006', 'sarah.brown@example.com', 'Sarah Brown', '1112223333', '303 Cedar St, San Francisco, CA, 94101, USA', 'hash6', '0'),
('C007', 'james.miller@example.com', 'James Miller', '6667778888', '404 Walnut St, Miami, FL, 33101, USA', 'hash7', '0'),
('C008', 'jessica.martinez@example.com', 'Jessica Martinez', '9990001111', '505 Birch St, Seattle, WA, 98101, USA', 'hash8', '0'),
('C009', 'david.taylor@example.com', 'David Taylor', '2223334444', '606 Oakwood St, Atlanta, GA, 30301, USA', 'hash9', '0'),
('C010', 'nicole.garcia@example.com', 'Nicole Garcia', '8889990000', '707 Elmwood St, Dallas, TX, 75201, USA', 'hash10', '0'),
('C011', 'william.rodriguez@example.com', 'William Rodriguez', '3334445555', '808 Maplewood St, Boston, MA, 02101, USA', 'hash11', '0'),
('C012', 'amanda.hernandez@example.com', 'Amanda Hernandez', '0001112222', '909 Pineview St, Denver, CO, 80201, USA', 'hash12', '0'),
('C013', 'daniel.gonzalez@example.com', 'Daniel Gonzalez', '7778889999', '101 Cedarview St, Philadelphia, PA, 19101, USA', 'hash13', '0'),
('C014', 'maria.lopez@example.com', 'Maria Lopez', '4445556666', '202 Walnutview St, Phoenix, AZ, 85001, USA', 'hash14', '0'),
('C015', 'joshua.perez@example.com', 'Joshua Perez', '1112223333', '303 Birchview St, Las Vegas, NV, 89101, USA', 'hash15', '0');

-- Insert adminlogin
INSERT INTO adminlogin (EMAIL, `ADMIN-PIN`) VALUES
('felicialewa@gmail.com', '123456');

-- Insert TRANSAKSI
INSERT INTO TRANSAKSI (ID_TRANS, ID_CUST, TANGGAL, TOTAL, STATUS_DEL) VALUES 
('T20240515C001001', 'C001', '2024-05-15', 170000, '0'),
('T20240516C002002', 'C002', '2024-05-16', 54810, '0'),
('T20240517C003003', 'C003', '2024-05-17', 153400, '0'),
('T20240518C004004', 'C004', '2024-05-18', 45900, '0'),
('T20240519C004005', 'C004', '2024-05-19', 40000, '0'),
('T20240520C005006', 'C005', '2024-05-20', 108500, '0'),
('T20240521C006007', 'C006', '2024-05-21', 29000, '0'),
('T20240522C007008', 'C007', '2024-05-22', 27550, '0'),
('T20240523C007009', 'C007', '2024-05-23', 30699, '0'),
('T20240524C007010', 'C007', '2024-05-24', 23750, '0'),
('T20240525C008011', 'C008', '2024-05-25', 101500, '0'),
('T20240526C009012', 'C009', '2024-05-26', 33250, '0'),
('T20240527C009013', 'C009', '2024-05-27', 52150, '0'),
('T20240528C009014', 'C009', '2024-05-28', 17955, '0'),
('T20240529C010015', 'C010', '2024-05-29', 169400, '0'),
('T20240530C011016', 'C011', '2024-05-30', 51300, '0'),
('T20240601C012017', 'C012', '2024-06-01', 23750, '0'),
('T20240602C012018', 'C012', '2024-06-02', 70000, '0'),
('T20240603C013019', 'C013', '2024-06-03', 99750, '0'),
('T20240604C014020', 'C014', '2024-06-04', 66500, '0'),
('T20240605C014021', 'C014', '2024-06-05', 36855, '0'),
('T20240606C014022', 'C014', '2024-06-06', 123500, '0'),
('T20240607C015023', 'C015', '2024-06-07', 45900, '0'),
('T20240608C015024', 'C015', '2024-06-08', 51300, '0'),
('T20240609C015025', 'C015', '2024-06-09', 23750, '0');

-- Insert DETAIL_TRANSAKSI
INSERT INTO DETAIL_TRANSAKSI (ID_TRANS, ID_PROD, HARGA, QTY, STATUS_DEL) VALUES 
('T20240515C001001', 'PF100101', 35000, 2, '0'), -- No discount
('T20240515C001001', 'PF100102', 31687.5, 3, '0'), -- With 5% discount
('T20240516C002002', 'PF100201', 18900, 1, '0'), -- No discount
('T20240516C002002', 'PF100202', 17057.25, 2, '0'), -- With 5% discount
('T20240517C003003', 'PF100301', 123500, 1, '0'), -- No discount
('T20240517C003003', 'PF100401', 29900, 2, '0'), -- No discount
('T20240518C004004', 'PF200501', 45900, 1, '0'), -- No discount
('T20240519C004005', 'PF200601', 40000, 1, '0'), -- No discount
('T20240520C005006', 'PF300801', 75000, 1, '0'), -- No discount
('T20240520C005006', 'PF300901', 31825, 2, '0'), -- With 5% discount
('T20240521C006007', 'PF301001', 29000, 1, '0'), -- No discount
('T20240522C007008', 'PF301101', 27550, 1, '0'), -- No discount
('T20240523C007009', 'PF200701', 30699, 1, '0'), -- No discount
('T20240524C007010', 'PF301301', 23750, 1, '0'), -- No discount
('T20240525C008011', 'PF100103', 31687.5, 2, '0'), -- With 5% discount
('T20240525C008011', 'PF100101', 35000, 1, '0'), -- No discount
('T20240526C009012', 'PF100102', 31687.5, 1, '0'), -- With 5% discount
('T20240527C009013', 'PF100103', 31687.5, 1, '0'), -- With 5% discount
('T20240527C009013', 'PF100201', 18900, 1, '0'), -- No discount
('T20240528C009014', 'PF100202', 17057.25, 1, '0'), -- With 5% discount
('T20240529C010015', 'PF100301', 123500, 1, '0'), -- No discount
('T20240529C010015', 'PF200503', 45900, 1, '0'), -- No discount
('T20240530C011016', 'PF301101', 27550, 1, '0'), -- No discount
('T20240530C011016', 'PF301201', 23750, 1, '0'), -- No discount
('T20240601C012017', 'PF301301', 23750, 1, '0'), -- No discount
('T20240602C012018', 'PF100101', 35000, 2, '0'), -- No discount
('T20240603C013019', 'PF100102', 31687.5, 3, '0'), -- With 5% discount
('T20240604C014020', 'PF100103', 31687.5, 2, '0'), -- With 5% discount
('T20240605C014021', 'PF100201', 18900, 1, '0'), -- No discount
('T20240605C014021', 'PF100202', 17057.25, 1, '0'), -- With 5% discount
('T20240606C014022', 'PF100301', 123500, 1, '0'), -- No discount
('T20240607C015023', 'PF200503', 45900, 1, '0'), -- No discount
('T20240608C015024', 'PF301101', 27550, 1, '0'), -- No discount
('T20240608C015024', 'PF301201', 23750, 1, '0'), -- No discount
('T20240609C015025', 'PF301301', 23750, 1, '0'); -- No discount

INSERT INTO KERANJANG (ID_CUST, ID_PROD, NAMA_PROD, HARGA, SHADE, QTY) VALUES
('C001', 'PF100101', 'PINKFLASH 2 IN 1 Dual-ended Liquid Lipstik ombrelips Matte Velvet High Pigment', 35000, 'V01', 1),
('C001', 'PF100102', 'PINKFLASH 2 IN 1 Dual-ended Liquid Lipstik ombrelips Matte Velvet High Pigment', 35000, 'M01', 2),
('C002', 'PF100201', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 18900, 'G01', 1),
('C002', 'PF100202', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 18900, 'G03', 3),
('C003', 'PF100301', 'PINKFLASH Natural Lip Oil Moisturize', 25900, '01', 1),
('C003', 'PF100401', 'PINKFLASH PinkDiary Velvet Matte Lipstick Lip Cream', 29900, 'BB03', 2),
('C004', 'PF200501', 'PINKFLASH 3 Shades Eyeshadow Palette Giltter', 45900, 'PK01', 1),
('C004', 'PF200601', 'PINKFLASH 2-in-1 Eyebrow Cream & Powder Gel', 40000, '01 Deep Brown', 1),
('C005', 'PF300801', 'PINKFLASH OhMyLove 4 in 1 Multiple Face Palette', 75000, '01 MANDARIN LATTE', 1),
('C005', 'PF300901', 'PINKFLASH OhMySelf Weightless Long Lasting All-day', 33500, '01-VANILLA', 2),
('C006', 'PF301001', 'PINKFLASH Breathable Liquid Concealer', 29000, '01-VANILLA', 1),
('C006', 'PF301101', 'PINKFLASH Oil Controller Loose Powder', 33000, '000-ALL SKIN TONES', 1),
('C007', 'PF200701', 'PINKFLASH 1mm Micro Fine Eyebrow Pencil', 30699, 'GR01-NATURAL GREY', 1),
('C007', 'PF301301', 'PINKFLASH OhMyShow Highlighter Contour', 25000, 'S01-FLOAT', 1),
('C008', 'PF100103', 'PINKFLASH 2 IN 1 Dual-ended Liquid Lipstik ombrelips Matte Velvet High Pigment', 35000, 'D01', 2);

INSERT INTO WISHLIST (ID_CUST, ID_PROD, NAMA_PROD, HARGA) VALUES 
('C001', 'PF100101', 'PINKFLASH 2 IN 1 Dual-ended Liquid Lipstik ombrelips Matte Velvet High Pigment', 35000),
('C001', 'PF100102', 'PINKFLASH 2 IN 1 Dual-ended Liquid Lipstik ombrelips Matte Velvet High Pigment', 35000),
('C002', 'PF100201', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 18900),
('C002', 'PF100202', 'PINKFLASH Lip Gloss Moisturizing Shine and Shimmer Plumping', 18900),
('C003', 'PF100301', 'PINKFLASH Natural Lip Oil Lip Balm Lip Gloss Moisturize', 130000),
('C003', 'PF100401', 'PINKFLASH PinkDiary Velvet Matte Lipstick Lip Cream', 29900),
('C004', 'PF200501', 'PINKFLASH 3 Shades Eyeshadow Palette Giltter', 45900),
('C004', 'PF200601', 'PINKFLASH 2-in-1 Eyebrow Cream & Powder Gel', 40000),
('C005', 'PF300801', 'PINKFLASH OhMyLove 4 in 1 Multiple Face Palette', 75000),
('C005', 'PF300901', 'PINKFLASH OhMySelf Weightless Long Lasting All-day', 33500),
('C006', 'PF301001', 'PINKFLASH Breathable Liquid Concealer', 29000),
('C006', 'PF301101', 'PINKFLASH Oil Controller Loose Powder', 29000),
('C007', 'PF200701', 'PINKFLASH 1mm Micro Fine Eyebrow Pencil', 30699),
('C007', 'PF301301', 'PINKFLASH OhMyShow Highlighter Contour', 25000),
('C008', 'PF100103', 'PINKFLASH 2 IN 1 Dual-ended Liquid Lipstik ombrelips Matte Velvet High Pigment', 35000);

INSERT INTO message (EMAIL, NAME, MESSAGE, STATUS_DEL, IS_WAREHOUSE) VALUES
('john.doe@example.com', 'John Doe', 'I am very happy with the new moisturizer I bought from your site. It works wonders!', '0', '0'),
('jane.smith@example.com', 'Jane Smith', 'The lipstick shade I ordered looks amazing! Thank you for the prompt delivery.', '0', '0'),
('michael.johnson@example.com', 'Michael Johnson', 'Can you recommend a good foundation for oily skin?', '0', '0'),
('emily.davis@example.com', 'Emily Davis', 'I am having issues with my recent order. The packaging was damaged.', '0', '0'),
('chris.wilson@example.com', 'Chris Wilson', 'Your customer service is excellent. I appreciate the quick response to my query.', '0', '0'),
('sarah.brown@example.com', 'Sarah Brown', 'I love the range of skincare products you offer. I will definitely be ordering again.', '0', '0'),
('james.miller@example.com', 'James Miller', 'The eye shadow palette I bought is perfect for my needs. Thank you!', '0', '0'),
('jessica.martinez@example.com', 'Jessica Martinez', 'Is there any discount available for first-time buyers?', '0', '0'),
('david.taylor@example.com', 'David Taylor', 'I have a question about the ingredients in your hair care products.', '0', '0'),
('nicole.garcia@example.com', 'Nicole Garcia', 'I received a wrong item in my order. Can you help me with the exchange?', '0', '0'),
('william.rodriguez@example.com', 'William Rodriguez', 'The sunscreen I bought from your store is amazing. No breakouts!', '0', '0'),
('amanda.hernandez@example.com', 'Amanda Hernandez', 'Thank you for the samples included in my order. It was a nice surprise!', '0', '0'),
('daniel.gonzalez@example.com', 'Daniel Gonzalez', 'I am looking for a vegan-friendly makeup line. Do you have any recommendations?', '0', '0'),
('maria.lopez@example.com', 'Maria Lopez', 'The serum I bought has significantly improved my skin texture. Thank you!', '0', '0'),
('joshua.perez@example.com', 'Joshua Perez', 'Do you offer gift wrapping services? I want to send a gift to a friend.', '0', '0');

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
    SET new_id = CONCAT('PF', category_code, LPAD(counter, 3, '0'), LPAD(shade_count, 2, '0'));
    
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