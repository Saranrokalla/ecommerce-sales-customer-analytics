# Power BI Data Model

## Recommended Model

### Fact table
`ecommerce_sales_data`

Grain: one row per order record.

Key fields:
- order_id
- order_date
- customer_id
- region
- category
- product
- quantity
- unit_price
- discount_pct
- revenue
- order_status
- returned_flag

### Calendar dimension
Create a dedicated `Calendar` table:

```DAX
Calendar =
ADDCOLUMNS(
    CALENDAR(
        MIN(ecommerce_sales_data[order_date]),
        MAX(ecommerce_sales_data[order_date])
    ),
    "Year", YEAR([Date]),
    "Month Number", MONTH([Date]),
    "Month", FORMAT([Date], "MMM"),
    "Year Month", FORMAT([Date], "YYYY-MM")
)
```

Create relationship:

`Calendar[Date]` → `ecommerce_sales_data[order_date]`

Relationship: One-to-many, single direction from Calendar to fact.

## Modeling Principles

- Keep the fact table at order grain.
- Use Calendar for time slicing and trend analysis.
- Keep KPI logic in measures rather than hard-coded report values.
- Validate revenue, order and return definitions against business rules.
- Avoid unnecessary bidirectional relationships.
