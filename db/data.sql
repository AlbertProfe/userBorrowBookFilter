INSERT INTO book (id, title, author, isbn, pages_qty, available, publication_date) VALUES
('B001', 'To Kill a Mockingbird', 'Harper Lee', '9780446310789', 281, true, '1960-07-11'),
('B002', '1984', 'George Orwell', '9780451524935', 328, true, '1949-06-08'),
('B003', 'Pride and Prejudice', 'Jane Austen', '9780141439518', 432, true, '1813-01-28'),
('B004', 'The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 180, true, '1925-04-10'),
('B005', 'One Hundred Years of Solitude', 'Gabriel García Márquez', '9780060883287', 417, true, '1967-05-30'),
('B006', 'The Catcher in the Rye', 'J.D. Salinger', '9780316769174', 234, true, '1951-07-16'),
('B007', 'Moby-Dick', 'Herman Melville', '9780142437247', 720, true, '1851-10-18'),
('B008', 'The Lord of the Rings', 'J.R.R. Tolkien', '9780618640157', 1178, true, '1954-07-29'),
('B009', 'The Hobbit', 'J.R.R. Tolkien', '9780547928227', 366, true, '1937-09-21'),
('B010', 'Brave New World', 'Aldous Huxley', '9780060850524', 311, true, '1932-01-01'),
('B011', 'The Diary of a Young Girl', 'Anne Frank', '9780553296983', 283, true, '1947-06-25'),
('B012', 'The Little Prince', 'Antoine de Saint-Exupéry', '9780156012195', 96, true, '1943-04-06'),
('B013', 'The Alchemist', 'Paulo Coelho', '9780062315007', 208, true, '1988-01-01'),
('B014', 'Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', '9780747532743', 223, true, '1997-06-26'),
('B015', 'The Da Vinci Code', 'Dan Brown', '9780307474278', 454, true, '2003-03-18'),
('B016', 'The Hunger Games', 'Suzanne Collins', '9780439023481', 374, true, '2008-09-14'),
('B017', 'The Girl with the Dragon Tattoo', 'Stieg Larsson', '9780307454546', 672, true, '2005-08-01'),
('B018', 'The Fault in Our Stars', 'John Green', '9780525478812', 313, true, '2012-01-10'),
('B019', 'The Kite Runner', 'Khaled Hosseini', '9781594631931', 371, true, '2003-05-29'),
('B020', 'The Help', 'Kathryn Stockett', '9780425232200', 451, true, '2009-02-10');
INSERT INTO user_app (id, user_app_name, email, password, age, address, archived, dob) VALUES
('U001', 'John Doe', 'john.doe@example.com', 'password123', 30, '123 Main St, Anytown, USA', false, '1995-05-15'),
('U002', 'Jane Smith', 'jane.smith@example.com', 'securepass456', 28, '456 Elm St, Somewhere, USA', false, '1997-08-22'),
('U003', 'Mike Johnson', 'mike.johnson@example.com', 'mikepass789', 35, '789 Oak Ave, Nowhere, USA', false, '1990-03-10'),
('U004', 'Emily Brown', 'emily.brown@example.com', 'emilyb2023', 26, '101 Pine Rd, Elsewhere, USA', false, '1999-11-30'),
('U005', 'David Lee', 'david.lee@example.com', 'leepass321', 40, '202 Cedar Ln, Anyplace, USA', false, '1985-07-18'),
('U006', 'Sarah Wilson', 'sarah.wilson@example.com', 'wilsonpass654', 32, '303 Birch Dr, Somewhere, USA', false, '1993-01-25'),
('U007', 'Tom Anderson', 'tom.anderson@example.com', 'andersonpass987', 45, '404 Maple Ave, Anywhere, USA', false, '1980-09-05'),
('U008', 'Lisa Taylor', 'lisa.taylor@example.com', 'taylorpass246', 29, '505 Spruce St, Someplace, USA', false, '1996-04-12'),
('U009', 'Chris Martin', 'chris.martin@example.com', 'martinpass135', 38, '606 Fir Ln, Otherplace, USA', false, '1987-12-08'),
('U010', 'Amanda Clark', 'amanda.clark@example.com', 'clarkpass579', 33, '707 Ash Rd, Thisplace, USA', false, '1992-06-20'),
('U011', 'Robert White', 'robert.white@example.com', 'whitepass864', 42, '808 Walnut St, Thatplace, USA', false, '1983-02-14'),
('U012', 'Jennifer Green', 'jennifer.green@example.com', 'greenpass753', 31, '909 Chestnut Ave, Hereplace, USA', false, '1994-10-07'),
('U013', 'Daniel Brown', 'daniel.brown@example.com', 'brownpass951', 36, '111 Sycamore Ln, Thereplace, USA', false, '1989-08-29'),
('U014', 'Michelle Lee', 'michelle.lee@example.com', 'leepass357', 27, '222 Poplar Rd, Whereplace, USA', false, '1998-03-17'),
('U015', 'Kevin Davis', 'kevin.davis@example.com', 'davispass159', 39, '333 Willow Dr, Howplace, USA', false, '1986-11-23'),
('U016', 'Laura Wilson', 'laura.wilson@example.com', 'wilsonpass852', 34, '444 Beech St, Whyplace, USA', false, '1991-05-09'),
('U017', 'Mark Thompson', 'mark.thompson@example.com', 'thompsonpass753', 41, '555 Hickory Ave, Whenplace, USA', false, '1984-01-31'),
('U018', 'Sophia Rodriguez', 'sophia.rodriguez@example.com', 'rodriguezpass951', 25, '666 Elm Ln, Whoplace, USA', false, '2000-09-14'),
('U019', 'William Chen', 'william.chen@example.com', 'chenpass357', 37, '777 Oak Rd, Whatplace, USA', false, '1988-07-26'),
('U020', 'Olivia Kim', 'olivia.kim@example.com', 'kimpass159', 30, '888 Pine Dr, Whichplace, USA', false, '1995-12-03');
INSERT INTO borrow (id, borrow_date, return_date, returned, points, user_id, book_id) VALUES
('BR001', '2025-02-15', '2025-03-15', true, 10, 'U001', 'B001'),
('BR002', '2025-02-16', '2025-03-16', false, 5, 'U002', 'B002'),
('BR003', '2025-02-17', '2025-03-17', true, 15, 'U003', 'B003'),
('BR004', '2025-02-18', '2025-03-18', false, 8, 'U004', 'B004'),
('BR005', '2025-02-19', '2025-03-19', true, 12, 'U005', 'B005'),
('BR006', '2025-02-20', '2025-03-20', false, 6, 'U006', 'B006'),
('BR007', '2025-02-21', '2025-03-21', true, 20, 'U007', 'B007'),
('BR008', '2025-02-22', '2025-03-22', false, 7, 'U008', 'B008'),
('BR009', '2025-02-23', '2025-03-23', true, 18, 'U009', 'B009'),
('BR010', '2025-02-24', '2025-03-24', false, 9, 'U010', 'B010'),
('BR011', '2025-02-25', '2025-03-25', true, 14, 'U011', 'B011'),
('BR012', '2025-02-26', '2025-03-26', false, 11, 'U012', 'B012'),
('BR013', '2025-02-27', '2025-03-27', true, 16, 'U013', 'B013'),
('BR014', '2025-02-28', '2025-03-28', false, 8, 'U014', 'B014'),
('BR015', '2025-03-01', '2025-03-31', true, 13, 'U015', 'B015'),
('BR016', '2025-03-02', '2025-04-01', false, 7, 'U016', 'B016'),
('BR017', '2025-03-03', '2025-04-02', true, 19, 'U017', 'B017'),
('BR018', '2025-03-04', '2025-04-03', false, 10, 'U018', 'B018'),
('BR019', '2025-03-05', '2025-04-04', true, 17, 'U019', 'B019'),
('BR020', '2025-03-06', '2025-04-05', false, 9, 'U020', 'B020'),
('BR021', '2025-03-07', '2025-04-06', false, 8, 'U001', 'B005'),
('BR022', '2025-03-08', '2025-04-07', true, 12, 'U001', 'B009'),
('BR023', '2025-03-09', '2025-04-08', false, 7, 'U001', 'B013'),
('BR024', '2025-03-10', '2025-04-09', true, 15, 'U001', 'B017'),
('BR025', '2025-03-11', '2025-04-10', false, 9, 'U002', 'B006'),
('BR026', '2025-03-12', '2025-04-11', true, 11, 'U002', 'B010'),
('BR027', '2025-03-13', '2025-04-12', false, 6, 'U002', 'B014'),
('BR028', '2025-03-14', '2025-04-13', true, 14, 'U002', 'B018'),
('BR029', '2025-03-15', '2025-04-14', false, 10, 'U003', 'B007'),
('BR030', '2025-03-16', '2025-04-15', true, 13, 'U003', 'B011'),
('BR031', '2025-03-17', '2025-04-16', false, 8, 'U003', 'B015'),
('BR032', '2025-03-18', '2025-04-17', true, 16, 'U003', 'B019'),
('BR033', '2025-03-19', '2025-04-18', false, 7, 'U004', 'B008'),
('BR034', '2025-03-20', '2025-04-19', true, 12, 'U004', 'B012'),
('BR035', '2025-03-21', '2025-04-20', false, 9, 'U004', 'B016'),
('BR036', '2025-03-22', '2025-04-21', true, 15, 'U004', 'B020');






