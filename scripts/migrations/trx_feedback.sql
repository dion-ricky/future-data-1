DROP TABLE IF EXISTS public.feedback CASCADE;

CREATE TABLE public.feedback (
    feedback_id varchar NOT NULL,
    order_id varchar NOT NULL,
    feedback_score int4 NULL,
    feedback_form_sent_date timestamp NULL,
    feedback_answer_date timestamp NULL,
    CONSTRAINT feedback_pkey PRIMARY KEY (feedback_id, order_id)
);

ALTER TABLE public.feedback ADD CONSTRAINT feedback_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(order_id);