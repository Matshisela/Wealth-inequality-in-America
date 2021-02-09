#################################################################################
#           Weath Inequality in America
#             TidyTuesday: 9 February 2021
################################################################################


# Loading packages ----
install.packages("tidytuesdayR")
library(tidytuesdayR)
library(tidyverse)


# Loading data ----
tuesdata <- tidytuesdayR::tt_load('2021-02-09')
tuesdata <- tidytuesdayR::tt_load(2021, week = 7)


race_wealth <- tuesdata$race_wealth # race wealth
std_debt <- tuesdata$student_debt #Student debt


# Descriptives ----
summary(race_wealth) #Summary stats
summary(std_debt) # Summary stats

grouped_race_wealth <- race_wealth %>%
  group_by(race) %>%
  summarise(mean = mean(wealth_family, na.rm=TRUE), 
            mean_se(wealth_family))

grouped_race_wealth

# Graph ----

ggplot(grouped_race_wealth, aes(race, mean, fill = race)) + 
  geom_bar(stat = 'identity', color= 'black', position = position_dodge()) +
  geom_errorbar(aes(ymin= ymin, ymax= ymax), width = .2, 
                position = position_dodge(.9)) +
  labs(title = "Family wealth by Race", x= 'Race', y = 'Family wealth') +
  theme_bw()

ggsave('Family wealth by race.png')

ggplot(std_debt, aes(year, loan_debt)) + 
  geom_line(aes(color=race)) + xlab('Year') + ylab('Loan Debt') +
  ggtitle('Distribution of student loan debt by year') +
  theme_bw()

ggsave('Student loans by year.png')


