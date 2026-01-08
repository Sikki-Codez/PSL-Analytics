# PSL-Analytics
A statistical analysis of 9 years of Pakistan Super League (PSL) cricket data (2016-2024) using R. Includes data cleaning, EDA, feature engineering, and visualization of victory patterns.


# PSL Analytics: Deciphering 9 Years of Cricket Match Data

## 📌 Project Overview
This project presents a comprehensive statistical analysis of the **Pakistan Super League (PSL)** matches played from **2016 to 2024**. Developed as part of the **ICT (CS202)** course at **Ghulam Ishaq Khan Institute (GIKI)**, this analysis utilizes **R** to uncover victory patterns, strategic trends, and team performance hierarchies.

The primary goal was to process raw match data to understand how factors like **Toss Decisions** and **Venue** influence match outcomes.

## 📂 Dataset
The dataset encompasses comprehensive records of all HBL PSL matches from 2016 to 2024.
* **Source:** Kaggle (PSL 2016-2024 Dataset).
* **Key Features:**
    * **Numerical:** `Win by Runs`, `Win by Wickets`.
    * **Categorical:** `Team 1`, `Team 2`, `Toss Decision`, `Winner`.
    * **Target Variable:** `Winner`.

## ⚙️ Methodology
The project follows a structured data science pipeline implemented in R:

### 1. Data Preprocessing & Cleaning
* **Handling Missing Values:** Imputed `0` for missing values in "Win by Runs" and "Win by Wickets" columns to preserve valid match data (as winning by wickets implies 0 run margin and vice versa).
* **Duplicate Removal:** Identified and removed duplicate rows to ensure statistical accuracy.
* **Encoding:** Converted string variables (Teams, Venues, Toss Decisions) into Factors.

### 2. Exploratory Data Analysis (EDA)
* **Summary Statistics:** Calculated means, medians, and standard deviations to analyze victory margins.
* **Distributions:** Visualized the "Win by Runs" (Histogram) and "Win by Wickets" (Boxplot) to understand scoring trends.
* **Target Analysis:** Analyzed the frequency of wins per team to determine the dominance hierarchy.

### 3. Feature Engineering
To prepare the data for potential predictive modeling, the following transformations were applied:
* **Scaling:** Applied Z-score standardization (`scale()`) to "Win by Runs" and "Win by Wickets" to normalize scales.
* **New Features:**
    * `Win_Type`: Categorized victories into **"Defending"** (Runs) or **"Chasing"** (Wickets).
    * `Toss_Win_Match_Win`: A binary feature indicating if the toss winner also won the match.

### 4. Data Split
* The data was split into **Training (70%)** and **Testing (30%)** sets using a fixed seed (`323436`) to ensure reproducibility.

## 📊 Key Insights & Visualizations
* **Toss Strategy:** Teams overwhelmingly choose to **Field First (Bowl)**, reflecting a modern T20 trend of preferring to chase targets.
* **Victory Patterns:** A scatter plot of "Win by Runs" vs. "Win by Wickets" revealed a distinct "L-shape," confirming the mutual exclusivity of the two victory types.
* **Team Dominance:** Historical data indicates that **Islamabad United** and **Peshawar Zalmi** have shown the most consistent performance over the 9-year period.

## 🚀 Future Scope
* **Predictive Modeling:** Implementing Random Forest or Logistic Regression on the prepared training set to predict match winners.
* **Hypothesis Testing:** Conducting T-tests to statistically confirm if chasing teams have a higher win rate.
* **External Data:** Integrating "Player of the Match" or venue scoring rates for deeper insights.

## 🛠️ Technologies Used
* **Language:** R
* **Libraries:** Base R (for plotting and statistics)
* **IDE:** RStudio

## 👤 Author
**Raja Hamza Sikandar**
* Registration: 2024532
* Section: H (BCS)
