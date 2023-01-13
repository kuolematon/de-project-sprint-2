DROP TABLE IF EXISTS public.shipping_country_rates cascade;

DROP TABLE IF EXISTS public.shipping_agreement cascade;

DROP TABLE IF EXISTS public.shipping_transfer cascade;

DROP TABLE IF EXISTS public.shipping_info cascade;

DROP TABLE IF EXISTS public.shipping_status cascade;

--public.shipping_country_rates
create table public.shipping_country_rates (
    shipping_country_id serial not null primary key,
    shipping_country text not null,
    shipping_country_base_rate NUMERIC(14, 3)
);

---public.shipping_agreement
create table public.shipping_agreement (
    agreementid bigint not null primary key,
    agreement_number text null,
    agreement_rate double precision null,
    agreement_commission double precision null
);

---public.shipping_transfer
create table public.shipping_transfer (
    transfer_type_id serial not null primary key,
    transfer_type text null,
    transfer_model text null,
    shipping_transfer_rate double precision null
);

---public.shipping_info
create table public.shipping_info (
    shippingid bigint not null primary key,
    vendorid bigint not null,
    payment_amount numeric(14, 2) null,
    shipping_plan_datetime timestamp null,
    transfer_type_id bigint not null,
    shipping_country_id bigint not null,
    agreementid bigint not null,
    foreign key (transfer_type_id) references public.shipping_transfer (transfer_type_id) on update cascade,
    foreign key (shipping_country_id) references public.shipping_country_rates (shipping_country_id) on update cascade,
    foreign key (agreementid) references public.shipping_agreement (agreementid) on update cascade
);

---public.shipping_status
create table public.shipping_status (
    shippingid bigint not null primary key,
    status text null,
    state text null,
    shipping_start_fact_datetime timestamp null,
    shipping_end_fact_datetime timestamp null
);
