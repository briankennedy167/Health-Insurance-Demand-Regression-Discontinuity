library(readr)
library(dplyr)
library(ggplot2)

# Load the dataset
dat <- read_csv("fhs.csv", show_col_types = FALSE)
        
dim(dat); names(dat)
head(dat, 3)
        
# Problem Two
dat <- subset(dat, income_bin >= 135)
        
summary(dat$income_bin)
summary(dat$min_prem)

dat <- dat %>%
  mutate(fpl_group = case_when(
    income_bin < 150 ~ "135–149%",
    income_bin < 200 ~ "150–199%",
    income_bin < 250 ~ "200–249%",
    TRUE             ~ "250–300%"
  ))

# Calculate average premium for each group
group_summary <- dat %>%
  group_by(fpl_group) %>%
  summarise(
    avg_min_prem = mean(min_prem, na.rm = TRUE),
    .groups = "drop"
  )

print(group_summary)

# Problem Three: RD regression for total monthly enrollment

# 1. Create indicator variables for each cutoff
dat <- dat %>%
  mutate(
    i150 = ifelse(income_bin >= 150, 1, 0),
    i200 = ifelse(income_bin >= 200, 1, 0),
    i250 = ifelse(income_bin >= 250, 1, 0)
  )

# 2. Run the RD regression
m_enr <- lm(nTotEnr ~ income_bin +
              i150 + i200 + i250 +
              income_bin:i150 + income_bin:i200 + income_bin:i250,
            data = dat)

# 3. View summary and extract the RD jumps
summary(m_enr)

# Extract only the discontinuity coefficients (β150, β200, β250)
library(broom)
rd_jumps <- tidy(m_enr) %>%
  filter(term %in% c("i150", "i200", "i250")) %>%
  mutate(threshold = c("150%", "200%", "250%"))

print(rd_jumps)


rd_at <- function(cut) {
  b <- coef(m_enr)[paste0("i", cut)]
  g <- coef(m_enr)[paste0("income_bin:i", cut)]
  as.numeric(b + g * cut)
}

rd_150 <- rd_at(150)
rd_200 <- rd_at(200)
rd_250 <- rd_at(250)

data.frame(
  threshold = c("150%", "200%", "250%"),
  RD_jump = c(rd_150, rd_200, rd_250)
)

# Problem 4: RD regression with insurer cost (Figure 5B)

# model (same indicators and interactions as in Problem 3)
m_cost <- lm(cost_ins ~ income_bin +
               i150 + i200 + i250 +
               income_bin:i150 + income_bin:i200 + income_bin:i250,
             data = dat)

summary(m_cost)

# RD jump at each cutoff: beta_c + gamma_c * cutoff
rd_cost_at <- function(cut){
  b <- coef(m_cost)[paste0("i", cut)]
  g <- coef(m_cost)[paste0("income_bin:i", cut)]
  as.numeric(b + g * cut)
}

rdc_150 <- rd_cost_at(150)
rdc_200 <- rd_cost_at(200)
rdc_250 <- rd_cost_at(250)

rd_cost_tbl <- data.frame(
  threshold = c("150% FPL","200% FPL","250% FPL"),
  RD_jump   = c(rdc_150, rdc_200, rdc_250)
)
rd_cost_tbl

