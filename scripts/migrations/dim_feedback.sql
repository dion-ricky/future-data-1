CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.feedback_dim;

CREATE TABLE warehouse.feedback_dim (
    feedback_sk serial,
    feedback_legacy_id varchar null,
    order_legacy_id varchar null,
    feedback_form_sent_date timestamp null,
    feedback_answer_date timestamp null,
    scd_start timestamp null, -- set equal to `fad`
    scd_end timestamp null, -- null by default
    scd_active boolean null, -- true by default
    CONSTRAINT feedback_dim_pkey PRIMARY KEY (feedback_sk)
);

DROP FUNCTION IF EXISTS wfd_scd2;

CREATE FUNCTION wfd_scd2() RETURNS trigger AS $wfd_scd2$
    BEGIN
        UPDATE warehouse.feedback_dim
            SET scd_end = NEW.feedback_answer_date - INTERVAL '1' HOUR,
                scd_active = FALSE
            WHERE feedback_legacy_id = NEW.feedback_legacy_id;
        
        RETURN NEW;
    END;
$wfd_scd2$ LANGUAGE plpgsql;

CREATE TRIGGER wfd_scd2 BEFORE INSERT ON warehouse.feedback_dim
    FOR EACH ROW EXECUTE PROCEDURE wfd_scd2();