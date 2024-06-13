DROP DATABASE IF EXISTS dior_database;
CREATE DATABASE dior_database;
USE dior_database;

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
    NAME VARCHAR(50),
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
    TANGGAL DATE NOT NULL,
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

INSERT INTO detail_produk (ID_PROD, NAMA_PROD, SHADE, DESKRIPSI, HARGA, DISKON, KATEGORI, STOCK, STATUS_DEL, FOTO_PROD) VALUES
('DR100101','Rouge Dior Couture Color Lipstick - Velvet and Satin Finishes','720 Icone satiny finish','A true couture accessory with the signature Dior style, the new Rouge Dior lipstick is adorned with the iconic cannage pattern and a silver-colored CD band. Its magnetic lid clips on and off as desired, in one simple step. A sensorial and designer object, Rouge Dior has become an addictive couture accessory, a daily essential to be kept close at hand.'
,'800000',0,'LIPS',0,'0','img/DR100101.png'),
('DR100102','Rouge Dior Couture Color Lipstick - Velvet and Satin Finishes',
'764 Rouge Gipsy velvet finish','A true couture accessory with the signature Dior style, the new Rouge Dior lipstick is adorned with the iconic cannage pattern and a silver-colored CD band. Its magnetic lid clips on and off as desired, in one simple step. A sensorial and designer object, Rouge Dior has become an addictive couture accessory, a daily essential to be kept close at hand.'
,'800000',0,'LIPS',0,'0','img/DR100102.png'),
('DR300201','Rouge Blush High-Pigmentation Blush - Clean Formula - Long Wear',
'625 Mitzah Shimmer Finish','Dior has reinvented Rouge Blush, the House of Dior’s iconic blush that enhances the cheeks with a long-wearing healthy glow effect. Its intense couture color is available in 4 finishes: matte, satin, shimmer, and holographic.The clean* blush formula is composed of 90%** natural-origin ingredients and infused with floral skincare ingredients. It maintains skin hydration and ensures comfort all day long. Its soft, lightweight texture is particularly silky and offers a second-skin feel.'
,'1000000',0,'FACE',0,'0','img/DR300201.jpg'),
('DR300202','Rouge Blush High-Pigmentation Blush - Clean Formula - Long Wear',
'999 Satin Finish','Dior has reinvented Rouge Blush, the House of Dior’s iconic blush that enhances the cheeks with a long-wearing healthy glow effect. Its intense couture color is available in 4 finishes: matte, satin, shimmer, and holographic.The clean* blush formula is composed of 90%** natural-origin ingredients and infused with floral skincare ingredients. It maintains skin hydration and ensures comfort all day long. Its soft, lightweight texture is particularly silky and offers a second-skin feel.'
,'1000000',0,'FACE',0,'0','img/DR300202.jpg'),
('DR100301','Dior Addict Lip Glow',
'001 Pink','The 1st Dior lip balm formulated with 97% natural-origin ingredients that subtly revives the natural color of lips with a custom glow and hydrates lips for 24h.
A new couture case, a unique formula made with natural-origin ingredients infused with cherry oil, and shades to suit all skin tones: the essential Dior Addict Lip Glow lip balm has been reinvented with an as always sensorial texture for lips that are both beautified and protected from dryness. Multi-use, Dior Addict Lip Glow can be worn on its own as a lip balm or as a primer under lipstick.'
,'700000',5,'LIPS',0,'0','img/DR100301.png'),
('DR100302','Dior Addict Lip Glow',
'007 Raspberry','The 1st Dior lip balm formulated with 97% natural-origin ingredients that subtly revives the natural color of lips with a custom glow and hydrates lips for 24h.
A new couture case, a unique formula made with natural-origin ingredients infused with cherry oil, and shades to suit all skin tones: the essential Dior Addict Lip Glow lip balm has been reinvented with an as always sensorial texture for lips that are both beautified and protected from dryness. Multi-use, Dior Addict Lip Glow can be worn on its own as a lip balm or as a primer under lipstick.'
,'700000',0,'LIPS',0,'0','img/DR100302.png'),
('DR100401','Dior Addict Lip Tint',
'651 Natural Rose','Dior Addict Lip Tint is the first no-transfer Dior lip tint with 12h wear, that highlights the lips with a bold color in a semi-matte finish and fuses with the skin for a bare-lip sensation.
Composed with 95%** natural-origin ingredients, Dior Addict Lip Tint is infused with Cherry Oil to hydrate lips for 24h*** and thereby provide long-lasting comfort.'
,'700000',5,'LIPS',0,'0','img/DR100401.png'),
('DR100402','Dior Addict Lip Tint',
'761 Natural Fuchsia','Dior Addict Lip Tint is the first no-transfer Dior lip tint with 12h wear, that highlights the lips with a bold color in a semi-matte finish and fuses with the skin for a bare-lip sensation.
Composed with 95%** natural-origin ingredients, Dior Addict Lip Tint is infused with Cherry Oil to hydrate lips for 24h*** and thereby provide long-lasting comfort.'
,'700000',0,'LIPS',0,'0','img/DR100402.png'),
('DR300501','Dior Backstage Glow Face Palette',
'001 Warm Neutrals','The iconic multi-use face makeup palette. The Dior Backstage Glow Face Palette is the Dior makeup artists secret for adding instant radiance with professional results, from a natural healthy glow to an intense luminosity.'
,'950000',0,'FACE',0,'0','img/DR300501.png'),
('DR300502','Dior Backstage Glow Face Palette',
'004 Rose Gold','The iconic multi-use face makeup palette. The Dior Backstage Glow Face Palette is the Dior makeup artists secret for adding instant radiance with professional results, from a natural healthy glow to an intense luminosity.'
,'950000',0,'FACE',0,'0','img/DR300502.png'),
('DR300601','Dior Forever Skin Glow',
'1N Neutral','Dior Forever Skin Glow is the radiant foundation by Dior that gives high perfection to the complexion with 24h wear. Its formula composed with 86%* skincare base enables this fluid foundation to intensely hydrate the skin, to let it breathe and to visibly improve the complexion. Formulated to hold even in conditions of heat and humidity, the Dior Forever Skin Glow foundation reveals a radiant makeup finish from morning to night. The complexion is evened out and the skin smoothed.'
,'1150000',5,'FACE',0,'0','img/DR300601.png'),
('DR300602','Dior Forever Skin Glow',
'2.5N Neutral','Dior Forever Skin Glow is the radiant foundation by Dior that gives high perfection to the complexion with 24h wear. Its formula composed with 86%* skincare base enables this fluid foundation to intensely hydrate the skin, to let it breathe and to visibly improve the complexion. Formulated to hold even in conditions of heat and humidity, the Dior Forever Skin Glow foundation reveals a radiant makeup finish from morning to night. The complexion is evened out and the skin smoothed.'
,'1150000',0,'FACE',0,'0','img/DR300602.png'),
('DR200701','Dior Backstage Eye Palette',
'001 Nude Essentials','Inspired by the energy backstage at the Dior runway shows, this makeup palette combines 9 ultra-pigmented, easy-to-blend eyeshadows with matte, pearlescent, metallic, holographic and glittery finishes. Each harmony is the interpretation of a colour theme, available in complementary shades to achieve a multitude of looks.'
,'1000000',0,'EYES',0,'0','img/DR200701.png'),
('DR200702','Dior Backstage Eye Palette',
'004 Rosewood Neutrals','Inspired by the energy backstage at the Dior runway shows, this makeup palette combines 9 ultra-pigmented, easy-to-blend eyeshadows with matte, pearlescent, metallic, holographic and glittery finishes. Each harmony is the interpretation of a colour theme, available in complementary shades to achieve a multitude of looks.'
,'1000000',0,'EYES',0,'0','img/DR200702.png'),
('DR200801','Diorshow On Stage Liner',
'091 Matte Black','Diorshow On Stage Liner is the Dior waterproof liquid eyeliner with an ultra-flexible felt tip that draws a precise line and lets you adjust the thickness based on the pressure applied. Its effective formula ensures 24 hours of intense color.'
,'650000',0,'EYES',0,'0','img/DR200801.png'),
('DR200901','Diorshow Brow Styler',
'032 Dark Brown','Diorshow Brow Styler is the Dior waterproof 24h* wear brow pencil with a retractable tip, to define and give fuller shape to the brow line with precision. This brow pencil features an ultra-precise tip and a spoolie to blend the product and tame the brows . Its soft texture blends comfortably into the brows with the 1st stroke for a natural finish.'
,'650000',0,'EYES',0,'0','img/DR200901.png'),
('DR200902','Diorshow Brow Styler',
'033 Grey Brown','Diorshow Brow Styler is the Dior waterproof 24h* wear brow pencil with a retractable tip, to define and give fuller shape to the brow line with precision. This brow pencil features an ultra-precise tip and a spoolie to blend the product and tame the brows . Its soft texture blends comfortably into the brows with the 1st stroke for a natural finish.'
,'650000',0,'EYES',0,'0','img/DR200902.png'),
('DR301001','Dior Forever Compact Foundation',
'1N Neutral','Dior Forever Natural Velvet is the 1st no-transfer Dior compact foundation with 24h* wear, composed with 90%** natural-origin ingredients. Ultra-soft and light, it brings a naturally matte perfection to the complexion, with a fine and creamy texture that lets the skin breathe while offering a sensation of comfort that lasts all day. Its high coverage corrects blemishes, smooths and evens out the complexion.'
,'1350000',10,'FACE',0,'0','img/DR301001.png'),
('DR301002','Dior Forever Compact Foundation',
'1N Neutral','Dior Forever Natural Velvet is the 1st no-transfer Dior compact foundation with 24h* wear, composed with 90%** natural-origin ingredients. Ultra-soft and light, it brings a naturally matte perfection to the complexion, with a fine and creamy texture that lets the skin breathe while offering a sensation of comfort that lasts all day. Its high coverage corrects blemishes, smooths and evens out the complexion.'
,'1350000',0,'FACE',0,'0','img/DR301002.png'),
('DR301101','Dior Forever Skin Correct',
'1N Neutral','Dior Forever Skin Correct is the clean high-perfection concealer by Dior that offers 24h wear and hydration. In a single sweep, this multi-use, full-coverage complexion concealer with a creamy texture hides undereye circles, localised redness, pigment spots and blemishes for flawless correcting and undereye circle concealing action with no transfer. From morning to night, it smooths the complexion and enhances the skin, without settling into facial lines. It stands up in all conditions of heat and humidity.'
,'850000',0,'FACE',0,'0','img/DR301101.png'),
('DR301102','Dior Forever Skin Correct',
'2N Neutral','Dior Forever Skin Correct is the clean high-perfection concealer by Dior that offers 24h wear and hydration. In a single sweep, this multi-use, full-coverage complexion concealer with a creamy texture hides undereye circles, localised redness, pigment spots and blemishes for flawless correcting and undereye circle concealing action with no transfer. From morning to night, it smooths the complexion and enhances the skin, without settling into facial lines. It stands up in all conditions of heat and humidity.'
,'850000',0,'FACE',0,'0','img/DR301102.png'),
('DR201201','Diorshow Iconic Overcurl Waterproof',
'091 Noir / Black','The iconic Diorshow Iconic Overcurl mascara is available in a waterproof version, for unbudgeable eye makeup with 24h wear. Designed for different types of lashes, the mascara defines, coats and fans the fringe of lashes to the extreme. This waterproof mascara lends lashes XXL volume, spectacular curl, and lasting shape.'
,'800000',0,'EYES',0,'0','img/DR201201.png'),
('DR301301','Dior Forever Perfect Fix',
'001','Dior Forever Perfect Fix is the 1st Dior triple-action face mist: it has lasting wear, sets makeup and delivers instant hydration, all in a single step. The micro-diffusion of the face mist creates a sheer veil of freshness on the skin and prolongs makeup hold without altering its colour. Face makeup remains fresh and flawless, without marking facial features or migrating into wrinkles and fine lines.
Concentrated in water and enriched with wild pansy flower, this face mist provides the skin with hydration and beneficial freshness.'
,'1000000',0,'FACE',0,'0','img/DR301301.png'),
('DR301401','Diorsnow - Brightening makeup base color correction spf35 - pa+++',
'01 Blue','The essential base for a radiant makeup, the Diorsnow Colour Correcting Makeup Base instantly targets and corrects skin imperfections for a perfectly unified finish and a fresh complexion. The ultra-fluid, weightless formula blends lightly and imperceptibly into the skin for perfect makeup hold and long-lasting foundation wear.
The pink shade revives dull areas of the face and illuminates lacklustre skin with a natural rosy glow. The complexion is purer, fresher and vitally radiant. Beige shade helps to neutralise and diminish redness of the skin. The complexion is perfectly even and translucent. The blue shade visibly conceals sallowness to reveal a perfect bright clarity, transparency and immaculate luminosity.'
,'1250000',0,'FACE',0,'0','img/DR301401.png'),
('DR301402','Diorsnow - Brightening makeup base color correction spf35 - pa+++',
'02 Rose','The essential base for a radiant makeup, the Diorsnow Colour Correcting Makeup Base instantly targets and corrects skin imperfections for a perfectly unified finish and a fresh complexion. The ultra-fluid, weightless formula blends lightly and imperceptibly into the skin for perfect makeup hold and long-lasting foundation wear.
The pink shade revives dull areas of the face and illuminates lacklustre skin with a natural rosy glow. The complexion is purer, fresher and vitally radiant. Beige shade helps to neutralise and diminish redness of the skin. The complexion is perfectly even and translucent. The blue shade visibly conceals sallowness to reveal a perfect bright clarity, transparency and immaculate luminosity.'
,'1250000',0,'FACE',0,'0','img/DR301402.png'),
('DR201501','Diorshow 10 Couleurs - Blooming Boudoir Limited Edition',
'002 Blooming Boudoir','Dior unveils the Diorshow 10 Couleurs eye palette featuring a Blooming Boudoir couture pattern created by artist Pietro Ruffo in which a lush floral decoration blossoms with a baroque aesthetic, reflected by the profusion of flowers and the vibrancy of their colours.
The eyeshadows of this sophisticated palette reveal a creamy and comfortable powder texture thanks to their formula enriched with cornflower floral water. High-colour and long-wear, the different shades invite you to create eye makeup looks with buildable intensity.
At the heart of this eye palette, a harmony of pink, brown and violet shades is presented, punctuated by a daring yellow or orange, available in a limited edition.'
,'2640000',0,'EYES',0,'0','img/DR201501.png'),
('DR101601','Dior Addict Set',
'123 Set Lips','Dior lip makeup star duo, Dior Addict Lip Glow lip balm and Dior Addict Lip Maximizer gloss are yours to discover in this case. Dior Addict Lip Glow is a lip balm that subtly revives the natural color of lips and hydrates them for 24h*. The Dior Addict Lip Maximizer gloss visibly plumps lips and enhances them with a mirror-shine effect.
For harmonious tone-on-tone lip makeup, the lip balm and gloss are both proposed in the regular retail size of 001 Pink, a light shade of pink. The set also includes a rosewood mini-gloss.'
,'1450000',0,'LIPS',0,'0','img/DR101601.png');


INSERT INTO customer (ID_CUST, EMAIL, NAME, PHONE, ADDRESS, PASSWORD_HASH, STATUS_DEL) VALUES
('C001', 'john.smith@gmail.com', 'John Smith', '1234567890', '123 Maple Street, New York, USA', SHA2(CONCAT('C001', 'john.smith@gmail.com'), 256), '0'),
('C002', 'emily.johnson@gmail.com', 'Emily Johnson', '2345678901', '456 Oak Avenue, Los Angeles, USA', SHA2(CONCAT('C002', 'emily.johnson@gmail.com'), 256), '0'),
('C003', 'michael.williams@gmail.com', 'Michael Williams', '3456789012', '789 Pine Road, London, UK', SHA2(CONCAT('C003', 'michael.williams@gmail.com'), 256), '0'),
('C004', 'jessica.brown@gmail.com', 'Jessica Brown', '4567890123', '012 Elm Lane, Manchester, UK', SHA2(CONCAT('C004', 'jessica.brown@gmail.com'), 256), '0'),
('C005', 'william.jones@gmail.com', 'William Jones', '5678901234', 'Venom Boulevard, Paris, France', SHA2(CONCAT('C005', 'william.jones@gmail.com'), 256), '0'),
('C006', 'sophia.davis@gmail.com', 'Sophia Davis', '6789012345', 'Cookie Monster Street, Berlin, Germany', SHA2(CONCAT('C006', 'sophia.davis@gmail.com'), 256), '0'),
('C007', 'daniel.wilson@gmail.com', 'Daniel Wilson', '1234567890', 'Luv Street, Bangkok, Thailand', SHA2(CONCAT('C007', 'daniel.wilson@gmail.com'), 256), '0'),
('C008', 'olivia.martinez@gmail.com', 'Olivia Martinez', '2345678901', 'Beige Percent Apartment, Bangkok, Thailand', SHA2(CONCAT('C008', 'olivia.martinez@gmail.com'), 256), '0'),
('C009', 'james.lee@gmail.com', 'James Lee', '3456789012', 'Heart Bingo Building, Bangkok, Thailand', SHA2(CONCAT('C009', 'james.lee@gmail.com'), 256), '0'),
('C010', 'isabella.taylor@gmail.com', 'Isabella Taylor', '4567890123', '012 Canggu Street, Bali, Indonesia', SHA2(CONCAT('C010', 'isabella.taylor@gmail.com'), 256), '0'),
('C011', 'david.thomas@gmail.com', 'David Thomas', '5678901234', 'More or Less Apartment, Surabaya, Indonesia', SHA2(CONCAT('C011', 'david.thomas@gmail.com'), 256), '0'),
('C012', 'sophie.clark@gmail.com', 'Sophie Clark', '6789012345', '88 Building, Jakarta, Indonesia', SHA2(CONCAT('C012', 'sophie.clark@gmail.com'), 256), '0'),
('C013', 'christopher.wong@gmail.com', 'Christopher Wong', '1234567890', 'Double Take Boulevard, Kuala Lumpur, Malaysia', SHA2(CONCAT('C013', 'christopher.wong@gmail.com'), 256), '0'),
('C014', 'charlotte.lim@gmail.com', 'Charlotte Lim', '2345678901', '456 Biscoff Road, Kuala Lumpur, Malaysia', SHA2(CONCAT('C014', 'charlotte.lim@gmail.com'), 256), '0'),
('C015', 'ethan.tan@gmail.com', 'Ethan Tan', '3456789012', '789 Yellow Lullaby Road, Kuala Lumpur, Malaysia', SHA2(CONCAT('C015', 'ethan.tan@gmail.com'), 256), '0'),
('C016', 'emma.white@gmail.com', 'Emma White', '4567890123', '321 Sunrise Avenue, Sydney, Australia', SHA2(CONCAT('C016', 'emma.white@gmail.com'), 256), '0'),
('C017', 'matthew.wilson@gmail.com', 'Matthew Wilson', '5678901234', '432 Bluebird Lane, Melbourne, Australia', SHA2(CONCAT('C017', 'matthew.wilson@gmail.com'), 256), '0'),
('C018', 'ava.martin@gmail.com', 'Ava Martin', '6789012345', '555 Coral Cove, Perth, Australia', SHA2(CONCAT('C018', 'ava.martin@gmail.com'), 256), '0'),
('C019', 'noah.taylor@gmail.com', 'Noah Taylor', '7890123456', '678 Sunset Street, Auckland, New Zealand', SHA2(CONCAT('C019', 'noah.taylor@gmail.com'), 256), '0'),
('C020', 'sophia.brown@gmail.com', 'Sophia Brown', '8901234567', '789 Moonlight Boulevard, Wellington, New Zealand', SHA2(CONCAT('C020', 'sophia.brown@gmail.com'), 256), '0'),
('C021', 'liam.wilson@gmail.com', 'Liam Wilson', '8901234567', '123 Seaside Boulevard, Sydney, Australia', SHA2(CONCAT('C021', 'liam.wilson@gmail.com'), 256), '0'),
('C022', 'mia.garcia@gmail.com', 'Mia Garcia', '9012345678', '456 Sunshine Avenue, Melbourne, Australia', SHA2(CONCAT('C022', 'mia.garcia@gmail.com'), 256), '0'),
('C023', 'alexander.rodriguez@gmail.com', 'Alexander Rodriguez', '0123456789', '789 Rainbow Road, Perth, Australia', SHA2(CONCAT('C023', 'alexander.rodriguez@gmail.com'), 256), '0'),
('C024', 'grace.smith@gmail.com', 'Grace Smith', '1234567890', '012 Ocean Drive, Auckland, New Zealand', SHA2(CONCAT('C024', 'grace.smith@gmail.com'), 256), '0'),
('C025', 'lucas.brown@gmail.com', 'Lucas Brown', '2345678901', '789 Beachfront Avenue, Wellington, New Zealand', SHA2(CONCAT('C025', 'lucas.brown@gmail.com'), 256), '0');

INSERT INTO transaksi (ID_TRANS, ID_CUST, TANGGAL, TOTAL, STATUS_DEL) VALUES
('T020524C001001', 'C001', '2024-05-02', 800000, '0'),
('T030524C002002', 'C002', '2024-05-03', 1600000, '0'),
('T050524C003003', 'C003', '2024-05-05', 1000000, '0'),
('T090524C004004', 'C004', '2024-05-09', 1000000, '0'),
('T130524C005005', 'C005', '2024-05-13', 1995000, '0'),
('T170524C006006', 'C006', '2024-05-17', 700000, '0'),
('T180524C007007', 'C007', '2024-05-18', 2660000, '0'),
('T200524C008008', 'C008', '2024-05-20', 700000, '0'),
('T220524C009009', 'C009', '2024-05-22', 2850000, '0'),
('T230524C010010', 'C010', '2024-05-23', 950000, '0'),
('T240524C011011', 'C011', '2024-05-24', 1092500, '0'),
('T260524C012012', 'C012', '2024-05-26', 2300000, '0'),
('T270524C013013', 'C013', '2024-05-27', 2000000, '0'),
('T280524C014014', 'C014', '2024-05-28', 1250000, '0'),
('T290524C015015', 'C015', '2024-05-29', 2600000, '0'),
('T290524C016016', 'C016', '2024-05-29', 2640000, '0'),
('T300524C017017', 'C017', '2024-05-30', 650000, '0'),
('T300524C018018', 'C018', '2024-05-30', 3645000, '0'),
('T310524C019019', 'C019', '2024-05-31', 1350000, '0'),
('T310524C020020', 'C020', '2024-05-31', 850000, '0'),
('T020624C021021', 'C021', '2024-06-02', 800000, '0'),
('T030624C022022', 'C022', '2024-06-03', 1520000, '0'),
('T050624C023023', 'C023', '2024-06-05', 1000000, '0'),
('T090624C024024', 'C024', '2024-06-09', 1000000, '0'),
('T130624C025025', 'C025', '2024-06-13', 1995000, '0'),
('T120624C023026', 'C023', '2024-06-12', 700000, '0'),
('T010624C017027', 'C017', '2024-06-01', 2100000, '0'),
('T020624C022028', 'C022', '2024-06-02', 1900000, '0'),
('T030624C008029', 'C008', '2024-06-03', 700000, '0'),
('T040624C009030', 'C009', '2024-06-04', 3500000, '0'),
('T120524C010031', 'C010', '2024-05-12', 700000, '0'),
('T200524C002032', 'C002', '2024-05-20', 700000, '0'),
('T150524C021033', 'C021', '2024-05-15', 700000, '0'),
('T300524C019034', 'C019', '2024-05-30', 700000, '0'),
('T010524C018035', 'C018', '2024-05-01', 700000, '0'),
('T100524C020036', 'C020', '2024-05-10', 1400000, '0'),
('T020624C020037', 'C005', '2024-06-02', 700000, '0'),
('T030624C020038', 'C011', '2024-06-03', 950000, '0'),
('T130524C020039', 'C021', '2024-05-13', 700000, '0'),
('T200524C020040', 'C023', '2024-05-20', 700000, '0');


INSERT INTO detail_transaksi (ID_TRANS, ID_PROD, HARGA, QTY, STATUS_DEL) VALUES
('T020524C001001', 'DR100101', 800000, 1, '0'),
('T030524C002002', 'DR100102', 800000, 2, '0'),
('T050524C003003', 'DR300201', 1000000, 1, '0'),
('T090524C004004', 'DR300202', 1000000, 1, '0'),
('T130524C005005', 'DR100301', 700000, 3, '0'),
('T170524C006006', 'DR100302', 700000, 1, '0'),
('T180524C007007', 'DR100401', 700000, 4, '0'),
('T200524C008008', 'DR100402', 700000, 1, '0'),
('T220524C009009', 'DR300501', 950000, 3, '0'),
('T230524C010010', 'DR300502', 950000, 1, '0'),
('T240524C011011', 'DR300601', 1150000, 1, '0'),
('T260524C012012', 'DR300602', 1150000, 2, '0'),
('T270524C013013', 'DR200701', 1000000, 2, '0'),
('T280524C014014', 'DR301402', 1250000, 1, '0'),
('T290524C015015', 'DR200801', 650000, 4, '0'),
('T290524C016016', 'DR201501', 2640000, 1, '0'),
('T300524C017017', 'DR200902', 650000, 1, '0'),
('T300524C018018', 'DR301001', 1350000, 3, '0'),
('T310524C019019', 'DR301002', 1350000, 1, '0'),
('T310524C020020', 'DR301101', 850000, 1, '0'),
('T020624C021021', 'DR100101', 800000, 1, '0'),
('T030624C022022', 'DR100102', 800000, 2, '0'),
('T050624C023023', 'DR300201', 1000000, 1, '0'),
('T090624C024024', 'DR300202', 1000000, 1, '0'),
('T130624C025025', 'DR100301', 700000, 3, '0'),
('T120624C023026', 'DR100301', 700000, 1, '0'),
('T010624C017027', 'DR100401', 700000, 3, '0'),
('T020624C022028', 'DR300502', 950000, 2, '0'),
('T030624C008029', 'DR300502', 950000, 1, '0'),
('T040624C009030', 'DR100302', 700000, 5, '0'),
('T120524C010031', 'DR300201', 1000000, 1, '0'),
('T200524C002032', 'DR100401', 700000, 1, '0'),
('T150524C021033', 'DR300201', 700000, 1, '0'),
('T300524C019034', 'DR100302', 700000, 1, '0'),
('T010524C018035', 'DR100302', 700000, 1, '0'),
('T100524C020036', 'DR100401', 700000, 2, '0'),
('T020624C020037', 'DR100301', 700000, 1, '0'),
('T030624C020038', 'DR300502', 950000, 1,'0'),
('T130524C020039', 'DR100302', 700000, 1,'0'),
('T200524C020040', 'DR100401', 700000, 1,'0');

INSERT INTO keranjang (ID_CUST, ID_PROD, NAMA_PROD, HARGA, SHADE, QTY) VALUES 
('C009', 'DR100302', 'Dior Addict Lip Glow', 700000, '007 Raspberry', 5),
('C020', 'DR100401', 'Dior Addict Lip Tint', 700000, '651 Natural Rose', 2),
('C019', 'DR301002', 'Dior Forever Compact Foundation', 1350000, '1N Neutral', 1),
('C022', 'DR300502', 'Dior Backstage Glow Face Palette', 950000, '004 Rose Gold',2);

INSERT INTO adminlogin (EMAIL, `ADMIN-PIN`) VALUES
('jandriany@gmail.com', '123456');

INSERT INTO wishlist (ID_CUST, ID_PROD, NAMA_PROD, HARGA) VALUES 
('C009', 'DR100302', 'Dior Addict Lip Glow', 700000),
('C020', 'DR100401', 'Dior Addict Lip Tint', 700000),
('C019', 'DR301002', 'Dior Forever Compact Foundation', 1350000),
('C022', 'DR300502', 'Dior Backstage Glow Face Palette', 950000);

INSERT INTO message (EMAIL, `NAME`, MESSAGE, CREATED_AT, STATUS_DEL) VALUES
('john.smith@gmail.com', 'John Smith', 'Sample message for John Smith', '2024-06-10 15:23:45', '0'),
('emily.johnson@gmail.com', 'Emily Johnson', 'Sample message for Emily Johnson', '2024-06-08 08:12:30', '0'),
('michael.williams@gmail.com', 'Michael Williams', 'Sample message for Michael Williams', '2024-06-07 20:45:55', '0'),
('jessica.brown@gmail.com', 'Jessica Brown', 'Sample message for Jessica Brown', '2024-06-09 14:35:22', '0'),
('william.jones@gmail.com', 'William Jones', 'Sample message for William Jones', '2024-06-06 11:50:11', '0'),
('sophia.davis@gmail.com', 'Sophia Davis', 'Sample message for Sophia Davis', '2024-06-05 17:25:47', '0'),
('daniel.wilson@gmail.com', 'Daniel Wilson', 'Sample message for Daniel Wilson', '2024-06-04 19:55:33', '0'),
('olivia.martinez@gmail.com', 'Olivia Martinez', 'Sample message for Olivia Martinez', '2024-06-03 21:30:05', '0'),
('james.lee@gmail.com', 'James Lee', 'Sample message for James Lee', '2024-06-02 09:15:44', '0'),
('isabella.taylor@gmail.com', 'Isabella Taylor', 'Sample message for Isabella Taylor', '2024-06-01 12:40:56', '0'),
('david.thomas@gmail.com', 'David Thomas', 'Sample message for David Thomas', '2024-06-10 22:33:21', '0'),
('sophie.clark@gmail.com', 'Sophie Clark', 'Sample message for Sophie Clark', '2024-06-08 13:29:16', '0'),
('christopher.wong@gmail.com', 'Christopher Wong', 'Sample message for Christopher Wong', '2024-06-07 10:55:12', '0'),
('charlotte.lim@gmail.com', 'Charlotte Lim', 'Sample message for Charlotte Lim', '2024-06-09 18:47:23', '0'),
('ethan.tan@gmail.com', 'Ethan Tan', 'Sample message for Ethan Tan', '2024-06-06 16:22:14', '0');

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
    SET new_id = CONCAT('DR', category_code, LPAD(counter, 3, '0'), LPAD(shade_count, 2, '0'));
    
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
DELIMITER ;

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


INSERT INTO customer (ID_CUST, EMAIL, NAME, PHONE, ADDRESS, PASSWORD_HASH, STATUS_DEL) VALUES
('C013', 'christopher.wong@gmail.com', 'Christopher Wong', '1234567890', 'Double Take Boulevard, Kuala Lumpur, Malaysia', SHA2(CONCAT('C013', 'christopher.wong@gmail.com'), 256), '0'),
('C014', 'charlotte.lim@gmail.com', 'Charlotte Lim', '2345678901', '456 Biscoff Road, Kuala Lumpur, Malaysia', SHA2(CONCAT('C014', 'charlotte.lim@gmail.com'), 256), '0'),
('C015', 'ethan.tan@gmail.com', 'Ethan Tan', '3456789012', '789 Yellow Lullaby Road, Kuala Lumpur, Malaysia', SHA2(CONCAT('C015', 'ethan.tan@gmail.com'), 256), '0'),
('C016', 'emma.white@gmail.com', 'Emma White', '4567890123', '321 Sunrise Avenue, Sydney, Australia', SHA2(CONCAT('C016', 'emma.white@gmail.com'), 256), '0'),
('C017', 'matthew.wilson@gmail.com', 'Matthew Wilson', '5678901234', '432 Bluebird Lane, Melbourne, Australia', SHA2(CONCAT('C017', 'matthew.wilson@gmail.com'), 256), '0'),
('C018', 'ava.martin@gmail.com', 'Ava Martin', '6789012345', '555 Coral Cove, Perth, Australia', SHA2(CONCAT('C018', 'ava.martin@gmail.com'), 256), '0'),
('C019', 'noah.taylor@gmail.com', 'Noah Taylor', '7890123456', '678 Sunset Street, Auckland, New Zealand', SHA2(CONCAT('C019', 'noah.taylor@gmail.com'), 256), '0'),
('C020', 'sophia.brown@gmail.com', 'Sophia Brown', '8901234567', '789 Moonlight Boulevard, Wellington, New Zealand', SHA2(CONCAT('C020', 'sophia.brown@gmail.com'), 256), '0'),
('C021', 'liam.wilson@gmail.com', 'Liam Wilson', '8901234567', '123 Seaside Boulevard, Sydney, Australia', SHA2(CONCAT('C021', 'liam.wilson@gmail.com'), 256), '0'),
('C022', 'mia.garcia@gmail.com', 'Mia Garcia', '9012345678', '456 Sunshine Avenue, Melbourne, Australia', SHA2(CONCAT('C022', 'mia.garcia@gmail.com'), 256), '0'),
('C023', 'alexander.rodriguez@gmail.com', 'Alexander Rodriguez', '0123456789', '789 Rainbow Road, Perth, Australia', SHA2(CONCAT('C023', 'alexander.rodriguez@gmail.com'), 256), '0'),
('C024', 'grace.smith@gmail.com', 'Grace Smith', '1234567890', '012 Ocean Drive, Auckland, New Zealand', SHA2(CONCAT('C024', 'grace.smith@gmail.com'), 256), '0'),
('C025', 'lucas.brown@gmail.com', 'Lucas Brown', '2345678901', '789 Beachfront Avenue, Wellington, New Zealand', SHA2(CONCAT('C025', 'lucas.brown@gmail.com'), 256), '0');