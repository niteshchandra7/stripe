ALTER TABLE transactions 
ADD COLUMN payment_intent VARCHAR(50)
DEFAULT "";


ALTER TABLE transactions 
ADD COLUMN payment_method VARCHAR(50)
DEFAULT "";
