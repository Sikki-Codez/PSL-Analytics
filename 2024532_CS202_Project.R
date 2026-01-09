#Clear previous data in plots
# Clear any existing plots to prevent overlap from previous runs
if(!is.null(dev.list())) dev.off()
cat("\014") # Clears the console


# Raja Hamza Sikandar
# 2024532
# Section H
# BCS



setwd("D:\\3rd_Sem\\CS202\\R_Folder\\2024532_CS202_Project")

# ==========================================
# -----------Data Preprocessing-------------
# ==========================================

# 1. Loading the Dataset 
# We use stringsAsFactors = FALSE to keep text as characters initially
PSL_Data <- read.csv("PSL_2016- 2024.csv", stringsAsFactors = FALSE)

# Print the initial Data Structure
print("Initial Data Structure:")
str(PSL_Data)

# 2. Data Cleaning: Missing Values 
# In cricket data, if a team wins by Wickets, 'Win by Runs' is usually NA (and vice versa).
# Instead of removing these rows (which would delete valid match data), 
# we will add 0 wickets or 0 runs as this is impossible in real world scenario to obtain. 

# Check for missing values before cleaning
print(paste("Missing values before cleaning:", sum(is.na(PSL_Data))))

# Add NA in numerical margin columns with 0
if("Win.by.Runs" %in% colnames(PSL_Data)) {
  PSL_Data$Win.by.Runs[is.na(PSL_Data$Win.by.Runs)] <- 0
}
if("Win.by.Wickets" %in% colnames(PSL_Data)) {
  PSL_Data$Win.by.Wickets[is.na(PSL_Data$Win.by.Wickets)] <- 0
}

# For other columns, if NA's exist, we remove those specific rows
PSL_Data <- na.omit(PSL_Data)

# 3. Data Cleaning: Duplicate Rows 
# Check for duplicates
NumDuplicates <- sum(duplicated(PSL_Data))
print(paste("Number of duplicate rows found:", NumDuplicates))

# Remove duplicates
PSL_Data <- PSL_Data[!duplicated(PSL_Data), ]

# 4. Categorical Encoding 
# Convert categorical variables (Team names, Venues, Toss decisions) into Factors
Columns_to_Factor <- c("Team.1", "Team.2", "Winner", "Toss.Winner", 
                    "Toss.Decision", "Result", "Ground", "City")

# Loop through columns and convert them if they exist in the dataset
for (Col in Columns_to_Factor) {
  if (Col %in% colnames(PSL_Data)) {
    PSL_Data[[Col]] <- as.factor(PSL_Data[[Col]])
  }
}

# 5. Final Verification
print("Cleaned Data Summary:")
summary(PSL_Data)



# ===========================================
# ------Exploratory Data Analysis (EDA)------
# ===========================================


# --- 1. Summary Statistics ---
# Calculate mean, median, and standard deviation for numerical features 
print("--- Summary Statistics for Numerical Features ---")

# Win by Runs Statistics
print("Win by Runs:")
print(summary(PSL_Data$Win.by.Runs))
print(paste("Standard Deviation:", sd(PSL_Data$Win.by.Runs)))

# Win by Wickets Statistics
print("Win by Wickets:")
print(summary(PSL_Data$Win.by.Wickets))
print(paste("Standard Deviation:", sd(PSL_Data$Win.by.Wickets)))


# --- 2. Target Variable Analysis ---

# Target Variable: 'Winner' (Categorical)
# Visualize the count distribution of the Winner 
# We choose the Winner as target so we can see which team has most wins 

# Create a frequency table for the Target Variable
WinnerCounts <- table(PSL_Data$Winner)

# Plotting the Target Variable
par(mar=c(10, 4, 4, 2)) # Adjust margins to fit team names
barplot(WinnerCounts,
        main = "Distribution of Match Winners",
        ylab = "Number of Wins",
        las = 2,            # Rotate x-axis labels vertically to fit them completely with the label area per bar
        col = "lightblue",
        cex.names = 0.8)    # Shrink text size slightly if needed


# --- 3. Feature Distribution ---
# Numerical Feature: Histogram for 'Win by Runs' 
# We filter out 0 values to see the distribution of actual run-margin victories
runs_data <- PSL_Data$Win.by.Runs[PSL_Data$Win.by.Runs > 0]

par(mar=c(5, 4, 4, 2)) # Reset margins
hist(runs_data,
     main = "Win by Runs",
     xlab = "Runs Margin",
     col = "lightgreen",
     breaks = 10)

# Numerical Feature: Box plot for 'Win by Wickets' 
# We again remove the values wit 0 so we get accurate measurement
wickets_data <- PSL_Data$Win.by.Wickets[PSL_Data$Win.by.Wickets > 0]
boxplot(wickets_data,
        main = "Win by Wickets",
        ylab = "Wickets Margin",
        col = "orange")

# Categorical Feature: Bar plot for 'Toss Decision' 
TossCounts <- table(PSL_Data$Toss.Decision)

barplot(TossCounts,
        main = "Toss Decision",
        ylab = "Frequency",
        col = "salmon",
        ylim = c(0, max(TossCounts) + 10)) # Addign enough headroom for labels





# ===========================================
# ------------Data Visualization-------------
# ===========================================

# --- 1. Correlation Matrix ---
# Requirement: "Plot a correlation matrix to understand relationships" [cite: 43]

# Select numerical columns
# We use 'complete.obs' to ignore any remaining missing values for the calculation
NumericalCols <- PSL_Data[, c("Win.by.Runs", "Win.by.Wickets", "Season")]

# Calculate correlation
CoreelationMatrix <- cor(NumericalCols, use = "complete.obs")

# Print the values to the console 
print("Correlation Coefficients:")
print(CoreelationMatrix)

# Visualize using the standard heatmap function
heatmap(CoreelationMatrix, 
        main = "Correlation Matrix",
        Rowv = NA, Colv = NA,       
        col = heat.colors(10),      # using the standard built-in color palette
        scale = "none")


# This step is taken because the graphs kept multiplying. As the heat map 
# kept the previous layout
# Reset the layout to a single pane. 
# Without this, the heatmap's internal grid remains active, 
# causing the "figure margins too large" error for the next plots.
par(mfrow = c(1, 1))

# Reset margins to default before the next plot
par(mar = c(5, 4, 4, 2) + 0.1)

# --- 2. Scatter Plots ---

# Plot A: Season vs Win by Runs
# Shows how run margins have changed over the seasons
plot(PSL_Data$Season, PSL_Data$Win.by.Runs,
     main = "Season vs Win by Runs",
     xlab = "Season Year",
     ylab = "Win by Runs Margin",
     col = "green",          # Standard color
     pch = 19)              # Solid circles for visibility

# Plot B: Win by Runs vs Win by Wickets
# Shows the relationship between the two types of victory margins
plot(PSL_Data$Win.by.Runs, PSL_Data$Win.by.Wickets,
     main = "Win by Runs vs Win by Wickets",
     xlab = "Win by Runs Margin",
     ylab = "Win by Wickets Margin",
     col = "brown",
     pch = 19)


# --- 3. Boxplots for Target vs. Feature ---

# Boxplot A: Win by Runs by Winner
# Adjusting margins to fit long team names
par(mar=c(10, 4, 4, 2)) 

boxplot(Win.by.Runs ~ Winner, 
        data = PSL_Data,
        main = "Win by Runs per Team",
        xlab = "",          # Labels are on the axis itself
        ylab = "Runs Margin",
        las = 2,            # Rotate x-axis labels vertically
        col = "lightblue")

# Boxplot B: Win by Wickets by Winner
par(mar=c(10, 4, 4, 2))

boxplot(Win.by.Wickets ~ Winner, 
        data = PSL_Data,
        main = "Win by Wickets per Team",
        xlab = "",
        ylab = "Wickets Margin",
        las = 2,
        col = "darkgreen")










# ===========================================
# -----------Feature Engineering-------------
# ===========================================


# --- 1. Feature Scaling ---
# 'Win by Runs' (0-100+) and 'Win by Wickets' (0-10) have very different scales.
# This causes bias towards runs when training a model
# We will use Standardization (Z-score normalization) using the scale() function. 

# We create new columns for the scaled versions so we don't lose the original data
PSL_Data$Scaled.Wins.By.Runs <- scale(PSL_Data$Win.by.Runs)
PSL_Data$Scaled.Wins.By.Wickets <- scale(PSL_Data$Win.by.Wickets)

# Verify the scaling (Mean should be close to 0)
print("--- Scaling Verification ---")
print(summary(PSL_Data$Scaled.Wins.By.Runs))
print(summary(PSL_Data$Scaled.Wins.By.Wickets))


# --- 2. Create New Features ---

# New Feature: 'Win_Type'
# This simplifies the two numerical margin columns into a single category: 
# Did the team win by "Defending" (Runs) or "Chasing" (Wickets)?
# This is much better than using 0's as we did before.

PSL_Data$Win_Type <- ifelse(PSL_Data$Win.by.Runs > 0, "Defending", "Chasing")
PSL_Data$Win_Type <- as.factor(PSL_Data$Win_Type)

# New Feature: 'Toss_Win_Match_Win'
# A binary feature to check if winning the toss leads to winning the match.
# This is a really important feature in real life as well. This is because the toss affects outcome due to
# a number of factors (eg. Dew, Pitch, etc)
# Of course, it is not a sure-fire way because there are exceptions. 
# Returns TRUE if the Toss Winner is the same as the Match Winner.
# We use as.character() to compare text directly
PSL_Data$Toss_Win_Match_Win <- as.numeric(as.character(PSL_Data$Toss.Winner) == as.character(PSL_Data$Winner))
# --- 3. View Updated Data Structure ---
# Check the first few rows to see the new columns
print("--- Updated Data with New Features ---")
head(PSL_Data[, c("Winner", "Win.by.Runs", "Scaled.Wins.By.Runs", "Win_Type", "Toss_Win_Match_Win")])





# ===========================================
# -----------Model Preparation---------------
# ===========================================

# --- 1. Set Seed for Reproducibility ---
# We set a seed so that every time code is run, the random split is the same.
set.seed(323436) 

# --- 2. Calculate Split Size ---
# We will use 70% for training and 30% for testing.
TrainingSize <- floor(0.70 * nrow(PSL_Data))

# --- 3. Generate Random Indices ---
# We randomly select row numbers to be part of the training set.This ensure fair and proper modeling
TrainingIndices <- sample(seq_len(nrow(PSL_Data)), size = TrainingSize)

# --- 4. Split the Data ---
# Create the Training Set using the random indices
TrainingData <- PSL_Data[TrainingIndices, ]

# Create the Testing Set using everything EXCEPT (-) the training indices
TestingData <- PSL_Data[-TrainingIndices, ]

# --- 5. Verification ---
# Check the dimensions to ensure no data was lost and the split is correct.
print("--- Data Split Verification ---")
print(paste("Total Rows:", nrow(PSL_Data)))
print(paste("Training Rows (80%):", nrow(TrainingData)))
print(paste("Testing Rows (20%):", nrow(TestingData)))

# We check the target variable distribution in both sets to ensure they are balanced. 
# This helps confirm that the random split didn't accidentally put all winners of one team in a single set.
# If that were to happen, our model would not work well
print("--- Target Distribution in Training Set ---")
print(table(TrainingData$Winner))

print("--- Target Distribution in Testing Set ---")
print(table(TestingData$Winner))