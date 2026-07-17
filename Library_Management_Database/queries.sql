 SELECT * FROM authors;

 SELECT * FROM books;

 SELECT * FROM members;

  SELECT * FROM book_issue
  ORDER BY days;
  
  -- Display All books name and author name 
  SELECT b.book_no , b.book_name , a.author_name 
  FROM books as b 
  INNER JOIN authors as a
  ON a.author_id = b.author_id;
  
  -- Find books written by particular author
  SELECT b.book_no , b.book_name 
  FROM books as b
  INNER JOIN authors as a
  ON (b.author_id = a.author_id ) AND (a.author_name = "Premchand");
  
  -- Display Members who borrowed more than 1 book
  SELECT m.member_name 
  FROM members as m 
  INNER JOIN book_issue as b
  ON m.member_id = b.member_id
  GROUP BY b.member_id
  HAVING COUNT(b.member_id) >1;
  
  -- Display books never borrowed
  SELECT b.book_no , b.book_name 
  FROM books as b 
  LEFT JOIN book_issue as bi
  ON b.book_no = bi.book_no
  WHERE bi.book_no is NULL;
  
  -- NO of books by each author 
  SELECT a.author_name , COUNT(a.author_id)
  FROM books as b 
  LEFT JOIN authors as a 
  ON a.author_id = b.author_id
  GROUP BY a.author_id;
  
  -- show members with the books they borrowed
  SELECT m.member_name , bi.book_no , b.book_name
  FROM book_issue as bi 
  LEFT JOIN members as m 
  ON m.member_id = bi.member_id 
  INNER JOIN books as b
  ON b.book_no = bi.book_no
  ORDER BY m.member_id;
  
  -- show who has overdues books 
  SELECT member_id , book_no , DATEDIFF(CURDATE() , issue_date)-days
  FROM book_issue AS bi
  WHERE DATEDIFF(CURDATE() , issue_date)>days;

-- add the fine money for overde books
   INSERT INTO fine 
  (member_id , book_no , fine_money)
  SELECT member_id , book_no , (DATEDIFF(CURDATE() , issue_date)-days)*10
  FROM book_issue AS bi
  WHERE DATEDIFF(CURDATE() , issue_date)>days;

  SELECT * FROM fine;
