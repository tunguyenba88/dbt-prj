select
    *
from {{ metrics.calculate(
    metric('total_revenue'),
    grain='year',
) }}
order by total_revenue desc