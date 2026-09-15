# Power BI Dashboard Requirements

## Objective
Provide management with an interactive view of e-commerce sales, customer and return performance.

## Audience
- Sales Manager
- Marketing Manager
- Operations Manager
- Finance Manager
- Product Owner

## Page 1 — Executive Sales Dashboard

### KPI Cards
- Total Revenue
- Completed Orders
- Average Order Value
- Return Rate
- Unique Customers

### Visuals
1. Monthly Revenue Trend — line chart
2. Revenue by Region — bar chart
3. Revenue by Category — column chart
4. Revenue Share by Category — donut chart
5. Top 10 Products — bar chart

### Slicers
- Date
- Region
- Category
- Product
- Order Status

## Page 2 — Customer Analysis

### Visuals
- New vs Repeat Customers
- Customer Revenue Distribution
- Top 10 Customers by Revenue
- Orders per Customer
- Revenue per Customer

### Business Questions
- Are repeat customers contributing meaningful revenue?
- Which customers are high value?
- Where should retention campaigns focus?

## Page 3 — Returns & Operations

### Visuals
- Return Rate by Category
- Returned Orders by Region
- Return Trend
- Category return comparison

### Business Questions
- Which categories have higher return rates?
- Are specific regions showing unusual return behavior?
- Which operational areas need investigation?

## Interactions
- Slicers cross-filter visuals.
- Users can drill from category to product.
- Tooltips show supporting KPIs.
- Date selections update all applicable pages.

## UAT Acceptance Criteria

- KPI cards match approved SQL/Excel calculations.
- Date slicer changes all relevant visuals.
- Region and category filters work consistently.
- Dashboard displays the latest refresh timestamp.
- No visual shows contradictory totals.
- Drill-down preserves filter context.
