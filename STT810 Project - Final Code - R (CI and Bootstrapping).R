# Load necessary libraries
library(dplyr)
library(boot)
library(ggplot2)

# ---------------Confidence Intervals---------------
# Load the dataset
data <- read.csv("matched_cities_data.csv")

# Filter the relevant columns
filtered_data <- data %>%
  select(`Days.for.shipment..scheduled.`, `Late_delivery_risk`, `Category.Name`, `Customer.City`, 
         `Department.Name`, `Order.Item.Quantity`, `shipping_date_day_month`, `weather_tempmax`,
         `weather_tempmin`, `weather_temp`, `weather_precip`, `weather_preciptype`, 
         `weather_snow`, `weather_snowdepth`, `weather_windspeed`, `weather_cloudcover`, 
         `weather_visibility`, `weather_severerisk`, `weather_conditions`, `weather_description`)

# Rename for simplicity
colnames(filtered_data)[1] <- "Days_for_shipment_scheduled"

# Confidence Interval for 'Days for shipment (scheduled)'
shipment_days <- filtered_data$Days_for_shipment_scheduled
mean_days <- mean(shipment_days)
sem_days <- sd(shipment_days) / sqrt(length(shipment_days))
error_margin <- qt(0.975, df = length(shipment_days) - 1) * sem_days
lower_bound <- mean_days - error_margin
upper_bound <- mean_days + error_margin

cat("Mean:", mean_days, "\n")
cat("95% Confidence Interval:", lower_bound, "-", upper_bound, "\n")

# Visualize Confidence Interval
ci_plot <- ggplot(data.frame(x = shipment_days), aes(x = shipment_days)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black", alpha = 0.7) +
  geom_vline(aes(xintercept = mean_days), color = "red", linetype = "dashed", size = 1.2) +
  geom_vline(aes(xintercept = lower_bound), color = "blue", linetype = "dotted", size = 1) +
  geom_vline(aes(xintercept = upper_bound), color = "blue", linetype = "dotted", size = 1) +
  labs(title = "Histogram of Days for Shipment (Scheduled) with Confidence Interval",
       x = "Days for Shipment (Scheduled)", y = "Frequency") +
  theme_minimal()

# Display the plots
print(ci_plot)

# ---------------Bootstrapping-----------------------------------------------------------
# Bootstrapping
bootstrap_mean <- function(data, indices) {
  return(mean(data[indices]))
}

set.seed(123) # For reproducibility
boot_result <- boot(data = shipment_days, statistic = bootstrap_mean, R = 1000)

# Calculate bootstrap confidence interval
boot_ci <- boot.ci(boot_result, type = "perc")

cat("Bootstrapped Mean:", mean(boot_result$t), "\n")
cat("95% Bootstrap Confidence Interval:", boot_ci$percent[4], "-", boot_ci$percent[5], "\n")

# Visualize Bootstrapping
boot_means <- boot_result$t
boot_plot <- ggplot(data.frame(boot_means), aes(x = boot_means)) +
  geom_histogram(binwidth = 0.01, fill = "lightgreen", color = "black", alpha = 0.7) +
  geom_vline(aes(xintercept = mean(boot_means)), color = "red", linetype = "dashed", size = 1.2) +
  geom_vline(aes(xintercept = boot_ci$percent[4]), color = "blue", linetype = "dotted", size = 1) +
  geom_vline(aes(xintercept = boot_ci$percent[5]), color = "blue", linetype = "dotted", size = 1) +
  labs(title = "Bootstrapping Distribution of Means with Confidence Interval",
       x = "Bootstrapped Means", y = "Frequency") +
  theme_minimal()

# Display the plots
print(boot_plot)
