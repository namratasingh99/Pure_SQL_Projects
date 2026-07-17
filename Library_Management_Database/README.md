# 📚 Library Management System (SQL)

A simple relational database project built in MySQL to manage a library's authors, books, members, book issues, and fines. This project demonstrates table design, foreign key relationships, joins, aggregation, and date-based fine calculation.

---

## 🗂️ Database

```sql
CREATE DATABASE Library_db;
USE Library_db;
```

---

## 🧱 Schema Overview

| Table         | Purpose                                             |
|---------------|------------------------------------------------------|
| `authors`     | Stores author details                                |
| `books`       | Stores book details, linked to an author              |
| `members`     | Stores library member details                         |
| `book_issue`  | Tracks which member borrowed which book, and when      |
| `fine`        | Stores fines calculated for overdue books              |

### Entity Relationships

```
authors (1) ──< (many) books
members (1) ──< (many) book_issue >── (many) books
members (1) ──< (many) fine >── (many) books
```

---

## 📋 Table Definitions

### `authors`
| Column        | Type        | Constraint   |
|---------------|-------------|--------------|
| author_id     | INT         | PRIMARY KEY  |
| author_name   | VARCHAR(50) |              |

### `books`
| Column      | Type        | Constraint                          |
|-------------|-------------|--------------------------------------|
| book_no     | INT         | PRIMARY KEY                          |
| book_name   | VARCHAR(50) |                                       |
| author_id   | INT         | FOREIGN KEY → authors(author_id)     |

### `members`
| Column        | Type        | Constraint                  |
|---------------|-------------|-------------------------------|
| member_id     | INT         | PRIMARY KEY, AUTO_INCREMENT   |
| member_name   | VARCHAR(50) |                                |

### `book_issue`
| Column      | Type | Constraint                                     |
|-------------|------|--------------------------------------------------|
| days        | INT  | allotted borrow period                            |
| member_id   | INT  | FOREIGN KEY → members(member_id)                  |
| book_no     | INT  | FOREIGN KEY → books(book_no)                      |
| issue_date  | DATE | DEFAULT `'2026-07-13'` (added via `ALTER TABLE`)  |
|             |      | **Composite PRIMARY KEY:** (book_no, member_id)   |

### `fine`
| Column      | Type | Constraint                                 |
|-------------|------|-----------------------------------------------|
| member_id   | INT  | FOREIGN KEY → members(member_id)               |
| fine_money  | INT  | calculated overdue fine                        |
| book_no     | INT  | FOREIGN KEY → books(book_no)                   |
|             |      | **Composite PRIMARY KEY:** (member_id, book_no)|

---

## 📥 Sample Data

### authors
| author_id | author_name          |
|-----------|----------------------|
| 1         | Ruskin Bond          |
| 2         | William Shakespeare  |
| 3         | Premchand            |
| 4         | Rabindranath Tagore  |
| 5         | RK Narayan           |

### books
| book_no | book_name             | author_id |
|---------|-----------------------|-----------|
| 101     | The Blue Umbrella     | 1         |
| 102     | Godaan                | 3         |
| 103     | Delhi Is Not Far      | 1         |
| 104     | Malgudi Days          | 5         |
| 105     | Gitanjali             | 4         |
| 106     | Romeo And Juliet      | 2         |
| 107     | The Room On The Roof  | 1         |
| 108     | Nirmala               | 3         |
| 109     | Hamlet                | 2         |

### members
| member_id | member_name |
|-----------|-------------|
| 1         | Neha        |
| 2         | Ashika      |
| 3         | Ansh        |
| 4         | Shiv        |

### book_issue
| days | member_id | book_no | issue_date |
|------|-----------|---------|------------|
| 1    | 4         | 105     | 2026-07-13 |
| 3    | 4         | 108     | 2026-07-13 |
| 4    | 3         | 106     | 2026-07-13 |
| 5    | 1         | 103     | 2026-07-13 |
| 7    | 2         | 103     | 2026-07-13 |
| 8    | 2         | 106     | 2026-07-13 |
| 9    | 2         | 101     | 2026-07-13 |
| 10   | 1         | 107     | 2026-07-13 |
| 11   | 4         | 103     | 2026-07-13 |

> Sorted by `days` (matches the `ORDER BY days` query). Note: multiple members can borrow the same `book_no` (e.g. book 103 is issued to members 1, 2, and 4), which assumes the library holds multiple physical copies of a title.

### fine
*(calculated as of the day this script is run — see note below)*

| member_id | book_no | fine_money |
|-----------|---------|------------|
| 4         | 105     | 30         |
| 4         | 108     | 10         |

⚠️ **This table is date-dependent.** Fines are calculated as `(DATEDIFF(CURDATE(), issue_date) - days) * 10`, and `issue_date` is a fixed default (`2026-07-13`). Since `CURDATE()` changes every day, re-running the fine query on a different date will change (or add to) these results. The values above reflect a run on **2026-07-17**, where the gap between issue date and today is 4 days.

---

## 🔍 Queries Included

| # | Description |
|---|-------------|
| 1 | List all books with their author names (`INNER JOIN`) |
| 2 | Find all books written by a specific author (`INNER JOIN` filtered) |
| 3 | Find members who have borrowed more than 1 book (`GROUP BY` + `HAVING`) |
| 4 | Find books that have never been borrowed (`LEFT JOIN` + `IS NULL`) |
| 5 | Count number of books per author (`LEFT JOIN` + `GROUP BY`) |
| 6 | Show each member alongside the books they borrowed |
| 7 | Find members with overdue books (`DATEDIFF` comparison) |
| 8 | Insert fine amounts for overdue books into the `fine` table |

---

## 🛠️ How to Run

1. Open MySQL Workbench / CLI / any MySQL client.
2. Run the full script top to bottom — it creates the database, tables, inserts sample data, and runs all queries.
3. Note: the `fine` INSERT is date-sensitive (see warning above). If you want reproducible fine amounts regardless of when the script is run, replace the single `issue_date` `DEFAULT` with explicit, fixed dates per row.

---


## 📄 License

Free to use for learning and portfolio purposes.
