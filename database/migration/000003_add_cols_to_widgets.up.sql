ALTER TABLE widgets
ADD COLUMN is_recurring BOOLEAN 
DEFAULT 0;


ALTER TABLE widgets 
ADD COLUMN plan_id VARCHAR(50)
DEFAULT "";