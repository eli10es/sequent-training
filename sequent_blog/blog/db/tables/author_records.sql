CREATE TABLE author_records%SUFFIX% (
    aggregate_id uuid NOT NULL,
    name character varying,
    email character varying,
    CONSTRAINT author_records_pkey%SUFFIX% PRIMARY KEY (aggregate_id)
);
