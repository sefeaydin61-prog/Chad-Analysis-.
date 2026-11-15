# Empirical Analysis of the Environmental Kuznets Curve (EKC) in Chad (1970-2024)
# Student: Sukrettin Efe Aydin | Student ID: 137423018

# Step 0: Load raw World Bank WDI datasets and filter for Chad (TCD, 1970-2024)
co2_raw <- read.csv("API_EN.GHG.CO2.PC.CE.AR5_DS2_en_csv_v2_62354.csv", skip = 4, check.names = FALSE)
gdp_raw <- read.csv("API_NY.GDP.PCAP.KD_DS2_en_csv_v2_71952.csv", skip = 4, check.names = FALSE)

years <- as.character(1970:2024)
co2_tcd <- as.numeric(co2_raw[co2_raw[["Country Code"]] == "TCD", years])
gdp_tcd <- as.numeric(gdp_raw[gdp_raw[["Country Code"]] == "TCD", years])

data <- data.frame(
  year = 1970:2024,
  co2_pc = co2_tcd,
  gdp_pc = gdp_tcd
)

# Step 1: Natural logarithmic transformation and quadratic term
data$ln_co2 <- log(data$co2_pc)
data$ln_gdp <- log(data$gdp_pc)
data$ln_gdp_sq <- data$ln_gdp^2

# Export cleaned dataset
write.csv(data, "chad_data.csv", row.names = FALSE)

# Step 2: Scatter plots with linear and quadratic regression fits
par(mfrow = c(1, 2))

plot(data$ln_gdp, data$ln_co2,
     main = "Environmental Kuznets Curve",
     xlab = "Log GDP per capita",
     ylab = "Log CO2 emissions per capita",
     pch = 19)
abline(lm(ln_co2 ~ ln_gdp, data = data), col = "red", lwd = 2)

plot(data$ln_gdp, data$ln_co2,
     main = "Environmental Kuznets Curve",
     xlab = "Log GDP per capita",
     ylab = "Log CO2 emissions per capita",
     pch = 19)
model <- lm(ln_co2 ~ ln_gdp + ln_gdp_sq, data = data)
x_seq <- seq(min(data$ln_gdp), max(data$ln_gdp), length.out = 200)
lines(x_seq, predict(model, newdata = data.frame(ln_gdp = x_seq, ln_gdp_sq = x_seq^2)), col = "red", lwd = 2)

# Step 3: Quadratic OLS regression output
summary(model)
