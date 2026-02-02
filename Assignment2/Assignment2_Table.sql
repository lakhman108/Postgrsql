-- roles table
 
CREATE TABLE IF NOT EXISTS hc.roles (
    role_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role_name VARCHAR(50) UNIQUE NOT NULL
);


INSERT INTO hc.roles (role_name) VALUES 
('admin'),
('customer'),
('service_provider'),
('support_staff');

SELECT * FROM hc.roles;


--update users table 

ALTER TABLE hc.users
ADD COLUMN role_id UUID;

ALTER TABLE hc.users
ADD CONSTRAINT fk_user_role
FOREIGN KEY (role_id) REFERENCES hc.roles(role_id);

UPDATE hc.users SET role_id = (SELECT role_id FROM hc.roles WHERE role_name = 'customer'); 
UPDATE hc.users SET role_id = (SELECT role_id FROM hc.roles WHERE role_name = 'admin') WHERE hc.users.email = 'bhargav@gmail.com';
UPDATE hc.users SET role_id = (SELECT role_id FROM hc.roles WHERE role_name = 'service_provider')WHERE hc.users.email = 'parth@gmail.com'; 
UPDATE hc.users SET role_id = (SELECT role_id FROM hc.roles WHERE role_name = 'support_staff')WHERE hc.users.email IN ('jay@example.com','akash@gmail.com') ; 

-- service_type table
 
CREATE TABLE  IF NOT EXISTS hc.service_types (
    service_type_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    service_type_name VARCHAR(100) NOT NULL
);

INSERT INTO hc.service_types (service_type_name)
VALUES ('home_cleaning'),
('senior_care'),
('nursing_care');

select * from hc.service_types;

-- categories
 
CREATE TABLE  IF NOT EXISTS hc.categories (
    category_id UUID PRIMARY KEY DEFAULT  uuid_generate_v4(),
    category_name VARCHAR(100) NOT NULL,
	service_type_id UUID NOT NULL CONSTRAINT fk_service_type REFERENCES hc.service_types(service_type_id)
);

select * from hc.categories;

INSERT INTO hc.categories (category_name, service_type_id)
VALUES
('regular_cleaning',
 (SELECT service_type_id FROM hc.service_types WHERE service_type_name = 'home_cleaning')),
('deep_cleaning',
 (SELECT service_type_id FROM hc.service_types WHERE service_type_name = 'home_cleaning')),
('kitchen_cleaning',
 (SELECT service_type_id FROM hc.service_types WHERE service_type_name = 'home_cleaning')),
('bathroom_cleaning',
 (SELECT service_type_id FROM hc.service_types WHERE service_type_name = 'home_cleaning')),

('daily_assistance',
 (SELECT service_type_id FROM hc.service_types WHERE service_type_name = 'senior_care')),

('icu_nursing',
 (SELECT service_type_id FROM hc.service_types WHERE service_type_name = 'nursing_care')),
('general_nursing',
 (SELECT service_type_id FROM hc.service_types WHERE service_type_name = 'nursing_care')),


-- sub_categories
 select * from hc.sub_categories;
CREATE TABLE hc.sub_categories (
    sub_category_id UUID PRIMARY KEY DEFAULT  uuid_generate_v4(),
    sub_category_name VARCHAR(100) NOT NULL,
    category_id UUID NOT NULL CONSTRAINT fk_category REFERENCES hc.categories(category_id)
);


INSERT INTO hc.sub_categories (sub_category_name, category_id)
VALUES
('daily_cleaning',
 (SELECT category_id FROM hc.categories WHERE category_name = 'regular_cleaning')),
('weekly_cleaning',
 (SELECT category_id FROM hc.categories WHERE category_name = 'regular_cleaning')),
('full_house_cleaning',
 (SELECT category_id FROM hc.categories WHERE category_name = 'deep_cleaning')),

('chimney_cleaning',
 (SELECT category_id FROM hc.categories WHERE category_name = 'kitchen_cleaning')),
('cabinet_cleaning',
 (SELECT category_id FROM hc.categories WHERE category_name = 'kitchen_cleaning')),

('tile_cleaning',
 (SELECT category_id FROM hc.categories WHERE category_name = 'bathroom_cleaning')),

('personal_hygiene',
 (SELECT category_id FROM hc.categories WHERE category_name = 'daily_assistance')),
('meal_support',
 (SELECT category_id FROM hc.categories WHERE category_name = 'daily_assistance')),

('ventilator_support',
 (SELECT category_id FROM hc.categories WHERE category_name = 'icu_nursing')),
('critical_patient_monitoring',
 (SELECT category_id FROM hc.categories WHERE category_name = 'icu_nursing')),

('injection_service',
 (SELECT category_id FROM hc.categories WHERE category_name = 'general_nursing')),
('wound_dressing',
 (SELECT category_id FROM hc.categories WHERE category_name = 'general_nursing')),



