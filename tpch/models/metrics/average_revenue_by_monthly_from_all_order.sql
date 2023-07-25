select
    date_part('month', date_month) as date_month,
    round(avg(total_revenue)) as avg_revenue
from {{ metrics.calculate(
    metric('total_revenue'),
    grain='month',
) }}
group by 1
order by avg_revenue desc