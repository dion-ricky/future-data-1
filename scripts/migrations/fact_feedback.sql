DROP TABLE
    IF EXISTS warehouse.fact_feedback;

CREATE TABLE warehouse.fact_feedback (
    feedback_answer_date int4,
    feedback_sk int4,
    order_legacy_id varchar,
    is_using_voucher boolean null,
    response_time interval null,
    feedback_score int4 null,
    CONSTRAINT fact_feedback_pkey PRIMARY KEY (feedback_answer_date, feedback_sk, order_legacy_id)
);

ALTER TABLE warehouse.fact_feedback
    ADD CONSTRAINT ff_feedback_sk_fkey
        FOREIGN KEY (feedback_sk)
            REFERENCES warehouse.feedback_dim(feedback_sk);

ALTER TABLE warehouse.fact_feedback
    ADD CONSTRAINT ff_feedback_answer_date_fkey
        FOREIGN KEY (feedback_answer_date) REFERENCES warehouse.date_dim(date_id);