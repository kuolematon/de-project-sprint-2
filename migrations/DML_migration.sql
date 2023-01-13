--public.shipping_country_rates
insert into
    public.shipping_country_rates(
        shipping_country,
        shipping_country_base_rate
    )
select
    distinct shipping_country,
    shipping_country_base_rate
from
    public.shipping;

--public.shipping_agreement
insert into
    public.shipping_agreement(
        agreementid,
        agreement_number,
        agreement_rate,
        agreement_commission
    )
select
    array_vad [1] :: numeric agreementid,
    array_vad [2] agreement_number,
    array_vad [3] :: double precision agreement_rate,
    array_vad [4] :: double precision agreement_commission
from
    (
        select
            distinct regexp_split_to_array(vendor_agreement_description, ':+') array_vad
        from
            public.shipping
    ) shipping_agr;

--public.shipping_transfer
insert into
    public.shipping_transfer(
        transfer_type,
        transfer_model,
        shipping_transfer_rate
    )
select
    array_std [1] transfer_type,
    array_std [2] transfer_model,
    shipping_transfer_rate
from
    (
        select
            distinct regexp_split_to_array(shipping_transfer_description, ':+') array_std,
            shipping_transfer_rate
        from
            public.shipping
    ) transfer_t;

--public.shipping_info
insert into
    public.shipping_info(
        shippingid,
        vendorid,
        payment_amount,
        shipping_plan_datetime,
        transfer_type_id,
        shipping_country_id,
        agreementid
    )
select
    distinct ps.shippingid,
    ps.vendorid,
    ps.payment_amount,
    ps.shipping_plan_datetime,
    pst.transfer_type_id,
    pscr.shipping_country_id,
    (
        regexp_split_to_array(ps.vendor_agreement_description, ':+')
    ) [1] :: numeric agreementid
from
    public.shipping ps
    left join public.shipping_transfer pst on ps.shipping_transfer_description = concat_ws(':', pst.transfer_type, pst.transfer_model)
    left join public.shipping_country_rates pscr on ps.shipping_country = pscr.shipping_country;

--public.shipping_status
with wt_ps as (
    select
        shippingid,
        max(state_datetime) as max_state_datetime,
        min(
            case
                when state = 'booked' then state_datetime
            end
        ) as shipping_start_fact_datetime,
        max(
            case
                when state = 'recieved' then state_datetime
            end
        ) as shipping_end_fact_datetime
    from
        public.shipping
    group by
        shippingid
)
insert into
    public.shipping_status(
        shippingid,
        status,
        state,
        shipping_start_fact_datetime,
        shipping_end_fact_datetime
    )
select
    ps.shippingid,
    ps.status,
    ps.state,
    wt_ps.shipping_start_fact_datetime,
    wt_ps.shipping_end_fact_datetime
from
    public.shipping ps
    inner join wt_ps on ps.shippingid = wt_ps.shippingid
    and ps.state_datetime = wt_ps.max_state_datetime
order by
    shippingid;
