CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.feedback_dim;

CREATE TABLE warehouse.feedback_dim (
    feedback_key varchar null,
    order_key varchar null,
    feedback_score int4 null,
    feedback_form_sent_date timestamp null,
    feedback_answer_date timestamp null,
    scd_start timestamp null, -- set equal to `fad`
    scd_end timestamp null, -- null by default
    scd_active boolean null -- true by default
);

DROP FUNCTION IF EXISTS wfd_scd2;

CREATE FUNCTION wfd_scd2() RETURNS trigger AS $wfd_scd2$
    BEGIN
        UPDATE warehouse.feedback_dim
            SET scd_end = NEW.feedback_answer_date - INTERVAL '1' HOUR,
                scd_active = FALSE
            WHERE feedback_key = NEW.feedback_key;
        
        RETURN NEW;
    END;
$wfd_scd2$ LANGUAGE plpgsql;

CREATE TRIGGER wfd_scd2 BEFORE INSERT ON warehouse.feedback_dim
    FOR EACH ROW EXECUTE PROCEDURE wfd_scd2();