INSERT INTO authors
 (author_id , author_name)
 VALUES
 (1 , "Ruskin Bond"),
 (2 , "William Shakespeare"),
 (3 , "Premchand"),
 (4,"Rabindranath Tagore"),
 (5 , "RK Narayan");

 INSERT INTO books
 (book_no , book_name,author_id)
 VALUES
 (101 , "The Blue Umbrella" , 1),
 (102 ,"Godaan" , 3),
 (103,"Delhi Is Not Far" , 1),
 (104 , "Malgudi Days",5),
 (105 , "Gitanjali" , 4),
 (106 , "Romeo And Juliet " , 2),
 (107 , "The Room On The Roof" , 1),
 (108 , "Nirmala" , 3),
 (109 , "Hamlet" , 2);

INSERT INTO members
  (member_name)
  VALUES
  ("Neha"),
  ("Ashika"),
  ("Ansh"),
  ("Shiv");

 INSERT INTO book_issue
  (days , member_id , book_no)
  VALUES
  (5 , 1 , 103),
  (10 , 1 , 107),
  (7 , 2 , 103),
  (1 , 4 , 105),
  (9 , 2 , 101),
  (4 , 3 , 106),
  (8 , 2 , 106),
  (11 , 4 , 103),
  (3 , 4 , 108);

 UPDATE members
  SET member_name = 'Abhi'
  WHERE member_id = 4;

 ALTER TABLE book_issue
  ADD  issue_date DATE DEFAULT '2026-07-13';
