CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT,
    profile JSONB
);

INSERT INTO users (name, profile)
VALUES (
    'Alice',
    '{"age": 30, "city": "New York", "hobbies": ["reading", "traveling"]}'
);

SELECT * FROM users


--@> for contains
select * from users where profile @> '{"age":30}'


-- ? for exists
SELECT * FROM users
WHERE profile ? 'hobbies';


-- Get each hobby of a user as a separate row
SELECT jsonb_array_elements(profile->'hobbies') AS hobby
FROM users

-- A @> B → “A contains B?”
-- A <@ B → “A is contained in B?”

--GIN (Generalized Inverted Index) works well for JSONB containment queries.
CREATE INDEX idx_profile ON users USING GIN (profile);


select avg(extract(year from age(birth_date))) from hc.users;

select age(birth_date) , first_name , birth_date from hc.users
select avg(age(birth_date))from hc.users

select r.role_name ,  count(*)  from hc.users as u 
join hc.roles as r on u.role_id = r.role_id
group by role_name;

select r.role_name from hc.roles r 
join hc.users u on r.role_id = u.role_id 
group by r.role_name
having count(u.user_id) > 1;


--  SELECT * from Orders o1 where 2=
-- (select  count(distinct amount) from Orders o2 where o2.amount >= o1.amount)

select * from hc.roles;

select * from hc.users;

select * from hc.service_types;

select * from hc.categories;

select * from hc.sub_categories;
