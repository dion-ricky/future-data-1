DROP TABLE
    IF EXISTS public.fact_order_feedback;

CREATE TABLE public.fact_order_feedback (
    order_date int8 NULL,
    feedback_answer_date int8 NULL,
    order_sk int8 NULL,
    avg_feedback_response_time interval NULL,
    min_feedback_score float8 NULL,
    max_feedback_score float8 NULL,
    avg_feedback_score float8 NULl
);