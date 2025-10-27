use context dcic2024
include csv
include lists
include data-source

student-score = load-table:
  Name :: String,
  Surname :: String,
  Email :: String,
  Score :: Number
  source: csv-table-file("students_gate_exam_score.csv", default-options)
  sanitize Score using num-sanitizer
end
student-score


# 1.1. Identify and extract (name, surname and score) of the top 3 students from the table, based on their scores.
order-by(student-score, "Score", false).row-n(0)
order-by(student-score, "Score", false).row-n(1)
order-by(student-score, "Score", false).row-n(2)

# 1.2. Define a Structured Data Type for the Student
data data-student:
  | student(name :: String, surname :: String, score :: Number)
end

# 1.3. Structured Data for the Top 3 Students 
s1 = student("Ethan", "Gray", 97)
s2 = student("Oscar", "Young", 92)
s3 = student("Adrian", "Bennett", 80)

# 1.4. Recursive Function: Count Students with Scores > 90 
scores :: List<Number> = link(s1.score, link(s2.score, link(s3.score, empty)))

fun greater-scores(score-list :: List<Number>) -> Number:
  doc: "function that uses cases to count how many of the top-3 students have scores greater than 90"
  cases (data-student) score-list:
    | empty => 0
    | link(f, r) => 
      (if f > 90: 1 else: 0 end) + greater-scores(r)
  end
where: 
  greater-scores(scores) is 2
end

# 2.1. Extract the Email Column as a List
all-emails = student-score.column("Email")
all-emails

# 2.2. Extract Domain Names and Find Unique Universities
fun get-domain(email :: String) -> String:
  doc: "extracts the univeristy name from an email address"
  domain = string-split(email, "@").get(1)
  university = string-split(domain, ".").get(0)
  university
end

uni-domain :: List<String> = map(get-domain, all-emails)

unique-uni = distinct(uni-domain)
unique-uni

# 2.3. Replace nulondon.ac.uk Domains with northeastern.edu
fun replace-domain(email :: String) -> String:
  doc: "replaces nulondon email with northeastern email address"
  parts = string-split(email, "@")
  username = parts.get(0)
  domain = parts.get(1)
  if domain == "nulondon.ac.uk":
    username + "@northeastern.edu"
  else:
    email
  end
end

all-emails-transformed :: List<String> = map(replace-domain, all-emails)

all-emails-transformed