# Optimizing Supply Chain Efficiency with Geospatial Data

## Problem Statement
Supply Chain Management (SCM) involves optimizing the flow of goods, from procurement to final delivery, to streamline operations, improve customer satisfaction, and reduce costs. Disruptions, particularly in last-mile delivery due to weather conditions, can lead to late or failed deliveries, negatively impacting revenue and customer trust. This project addresses these challenges by integrating predictive modeling and geospatial data to improve delivery success rates and enhance inventory management.

---

## Data Overview
### Dataset Details:
- **Total Rows**: 9,900
- **Total Columns**: 90 (filtered to 20 relevant columns)

### Selected Columns:
1. **Shipment Details**:
   - Days for shipment (scheduled), Late_delivery_risk, Order Item Quantity
2. **Categorical Variables**:
   - Category Name, Customer City, Department Name
   - weather_preciptype, weather_conditions, weather_description
3. **Weather Metrics**:
   - weather_tempmax, weather_tempmin, weather_temp
   - weather_precip, weather_snow, weather_snowdepth
   - weather_windspeed, weather_cloudcover, weather_visibility, weather_severerisk
4. **Date Information**:
   - shipping_date_day_month

### Data Insights:
- Deliveries are typically scheduled within 2–4 days.
- Late_delivery_risk is balanced at 53%.
- Weather metrics exhibit varied distributions, with notable outliers in precipitation and snow depth.

---

## Methodology
### Initial Data Analysis (IDA):
- **Numerical Summaries**: Mean, standard deviation, and percentiles calculated for key features.
- **Visualizations**: Histograms, boxplots, and heatmaps for univariate and multivariate analyses.
- **Handling Missing Values**: Imputed missing data for `weather_preciptype` with "Unknown."

### Feature Engineering:
- **Encoding**: Used label and binary encoding for categorical variables to reduce bias and high-dimensionality issues.
- **Datetime Splitting**: Extracted day and month from `shipping_date_day_month`.
- **Statistical Tests**:
  - T-tests for numerical features to assess class differences.
  - Chi-square tests for categorical features to evaluate independence.

### Data Preprocessing:
- **Class Balance**: Verified balance between failed (53%) and successful (47%) deliveries.
- **Standardization**: Applied Z-score standardization to numerical features for consistent scaling.

---

## Predictive Modeling
### Models Used:
1. **Logistic Regression**:
   - Balanced recall (0.59) and precision (0.78) but missed 41% of late deliveries.
   - Cross-validation accuracy: ~70% with a stable performance.
2. **Naïve Bayes Classifier**:
   - Higher recall for late deliveries (0.87) but lower precision (0.57), leading to misclassification of successful deliveries.
   - Cross-validation accuracy: Gaussian (67%), Multinomial (52%).

### Evaluation Metrics:
- Accuracy, Precision, Recall, F1-Score
- Cross-validation accuracy with confidence intervals
- Learning curves for bias-variance tradeoff assessment

---

## Confidence Interval and Bootstrapping Analysis
1. **Confidence Interval (CI):**
   - CI (2.89–2.94 days) quantifies the precision of the average shipment days estimate.
   - Formula:
     \[ CI = \bar{x} \pm t \times \frac{s}{\sqrt{n}} \]

2. **Bootstrapping:**
   - Resampling technique to estimate mean and confidence interval without assuming normality.
   - Bootstrap CI (2.89–2.94 days) aligns with traditional CI, validating robustness.

---

## Results and Key Insights
1. **Shipment Trends**:
   - Deliveries are consistent, with most scheduled within 2–4 days.
   - Late deliveries account for 53%.
2. **Weather Influence**:
   - Severe weather increases delivery risks.
3. **Geographic Impact**:
   - Logistical challenges vary by city.
4. **Model Comparisons**:
   - Logistic Regression outperforms Naïve Bayes in balancing recall and precision.

---

## Conclusion
We leveraged predictive modeling to identify delivery failures and reduce operational costs. Logistic Regression demonstrated better overall performance, but Naïve Bayes highlighted areas for improvement, such as capturing late deliveries. Geospatial data integration and weather analytics offer significant potential for enhancing supply chain strategies. Expanding the model with advanced techniques can further optimize delivery success rates.

Video Recording of the Project - [Optimizing Supply Chain Efficiency with Geospatial Data](https://drive.google.com/file/d/19DIb1_j31EkT_lklWGH8XbYHOvy7LuOZ/view?usp=drive_link)

---

## Concepts Covered
1. Correlation and Covariance
2. Logistic Regression and Naïve Bayes Classification
3. Bootstrapping and Confidence Intervals (CI)
4. Data encoding and preprocessing techniques
5. Statistical hypothesis testing

---

## References
1. Supply Chain Dataset: [DataCo SMART SUPPLY CHAIN](https://doi.org/10.17632/8gx2fvg2k6.5)
2. Weather Dataset: [Visual Crossing](https://www.visualcrossing.com/)
3. [Chi-squared test - Wikipedia](https://en.wikipedia.org/wiki/Chi-squared_test)
4. [NOAA: Weather and Climate Impacts](https://www.ncei.noaa.gov/news/noaa-data-helps-retail-and-manufacturing-business-minimize-impacts-weather-and-climate)
5. [The Impact of Weather on Supply Chain](https://parcelindustry.com/article-6377-The-Impact-of-Weather-on-the-Supply-Chain.html)
6. [Supply Chain - Wikipedia](https://en.wikipedia.org/wiki/Supply_chain)
