-- USE DbContabilly;
-- DELIMITER $$
-- CREATE PROCEDURE GetTimeNow(OUT ahora DATETIME)
-- BEGIN
-- 	SET ahora = NOW();
-- END $$
-- DELIMITER ;

DELIMITER $$
CREATE FUNCTION `getnow`() RETURNS DATETIME
DETERMINISTIC
BEGIN
    DECLARE ahora DATETIME;
    SET ahora = NOW();
    RETURN ahora;
END$$
DELIMITER ;