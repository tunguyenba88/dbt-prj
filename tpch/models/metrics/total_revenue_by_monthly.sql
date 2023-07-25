select
    *
from {{ metrics.calculate(
    metric('total_revenue_by_monthly'),
    grain='month',
) }}
order by total_revenue_by_monthly desc