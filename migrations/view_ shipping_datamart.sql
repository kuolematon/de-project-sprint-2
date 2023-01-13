create
or replace view public.shipping_datamart as
select
    psi.shippingid,
    psi.vendorid,
    pst.transfer_type,
    full_day_at_shipping,
    case
        when pss.shipping_end_fact_datetime > psi.shipping_plan_datetime then 1
        when pss.shipping_end_fact_datetime is null then null
        else 0
    end is_delay,
    case
        when pss.status = 'finished' then 1
        else 0
    end is_shipping_finish,
    case
        when pss.shipping_end_fact_datetime > psi.shipping_plan_datetime then extract(
            day
            from
                (
                    pss.shipping_end_fact_datetime - pss.shipping_start_fact_datetime
                )
        )
        else 0
    end delay_day_at_shipping,
    psi.payment_amount,
    (
        psi.payment_amount * (
            pscr.shipping_country_base_rate + psa.agreement_rate + pst.shipping_transfer_rate
        )
    ) vat,
    (psi.payment_amount * psa.agreement_commission) profit
from
    public.shipping_info psi
    left join public.shipping_transfer pst on psi.transfer_type_id = pst.transfer_type_id
    left join public.shipping_status pss on psi.shippingid = pss.shippingid
    left join public.shipping_country_rates pscr on psi.shipping_country_id = pscr.shipping_country_id
    left join public.shipping_agreement psa on psi.agreementid = psa.agreementid;
