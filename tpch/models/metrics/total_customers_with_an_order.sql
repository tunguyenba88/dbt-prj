select
    *
from {{ metrics.calculate(
    metric('total_customers'),
) }}