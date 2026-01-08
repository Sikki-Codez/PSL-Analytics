# PSL-Analytics
A statistical analysis of 9 years of Pakistan Super League (PSL) cricket data (2016-2024) using R. Includes data cleaning, EDA, feature engineering, and visualization of victory patterns.


# PSL Analytics: Deciphering 9 Years of Cricket Match Data

## 📌 Project Overview
[cite_start]This project presents a comprehensive statistical analysis of the **Pakistan Super League (PSL)** matches played from **2016 to 2024**[cite: 6, 15]. [cite_start]Developed as part of the **ICT (CS202)** course at **Ghulam Ishaq Khan Institute (GIKI)** [cite: 2, 7][cite_start], this analysis utilizes **R** to uncover victory patterns, strategic trends, and team performance hierarchies[cite: 13].

[cite_start]The primary goal was to process raw match data to understand how factors like **Toss Decisions** and **Venue** influence match outcomes[cite: 24].

## 📂 Dataset
[cite_start]The dataset encompasses comprehensive records of all HBL PSL matches from 2016 to 2024[cite: 16].
* [cite_start]**Source:** Kaggle (PSL 2016-2024 Dataset)[cite: 110].
* **Key Features:**
    * [cite_start]**Numerical:** `Win by Runs`, `Win by Wickets`[cite: 21].
    * [cite_start]**Categorical:** `Team 1`, `Team 2`, `Toss Decision`, `Winner`[cite: 22].
    * [cite_start]**Target Variable:** `Winner`[cite: 23].

## ⚙️ Methodology
The project follows a structured data science pipeline implemented in R:

### 1. Data Preprocessing & Cleaning
* [cite_start]**Handling Missing Values:** Imputed `0` for missing values in "Win by Runs" and "Win by Wickets" columns to preserve valid match data (as winning by wickets implies 0 run margin and vice versa)[cite: 27, 29].
* [cite_start]**Duplicate Removal:** Identified and removed duplicate rows to ensure statistical accuracy[cite: 30].
* [cite_start]**Encoding:** Converted string variables (Teams, Venues, Toss Decisions) into Factors[cite: 31].

### 2. Exploratory Data Analysis (EDA)
* [cite_start]**Summary Statistics:** Calculated means, medians, and standard deviations to analyze victory margins[cite: 33, 35].
* [cite_start]**Distributions:** Visualized the "Win by Runs" (Histogram) and "Win by Wickets" (Boxplot) to understand scoring trends[cite: 37].
* [cite_start]**Target Analysis:** Analyzed the frequency of wins per team to determine the dominance hierarchy[cite: 38].

### 3. Feature Engineering
To prepare the data for potential predictive modeling, the following transformations were applied:
* [cite_start]**Scaling:** Applied Z-score standardization (`scale()`) to "Win by Runs" and "Win by Wickets" to normalize scales[cite: 97].
* **New Features:**
    * [cite_start]`Win_Type`: Categorized victories into **"Defending"** (Runs) or **"Chasing"** (Wickets)[cite: 100].
    * [cite_start]`Toss_Win_Match_Win`: A binary feature indicating if the toss winner also won the match[cite: 101].

### 4. Data Split
* The data was split into **Training (70%)** and **Testing (30%)** sets using a fixed seed (`323436`) to ensure reproducibility.

## 📊 Key Insights & Visualizations
* [cite_start]**Toss Strategy:** Teams overwhelmingly choose to **Field First (Bowl)**, reflecting a modern T20 trend of preferring to chase targets[cite: 43, 44].
* [cite_start]**Victory Patterns:** A scatter plot of "Win by Runs" vs. "Win by Wickets" revealed a distinct "L-shape," confirming the mutual exclusivity of the two victory types[cite: 47, 62].
* [cite_start]**Team Dominance:** Historical data indicates that **Islamabad United** and **Peshawar Zalmi** have shown the most consistent performance over the 9-year period[cite: 39, 42].

## 🚀 Future Scope
* [cite_start]**Predictive Modeling:** Implementing Random Forest or Logistic Regression on the prepared training set to predict match winners[cite: 105].
* [cite_start]**Hypothesis Testing:** Conducting T-tests to statistically confirm if chasing teams have a higher win rate[cite: 107].
* [cite_start]**External Data:** Integrating "Player of the Match" or venue scoring rates for deeper insights[cite: 108].

## 🛠️ Technologies Used
* **Language:** R
* **Libraries:** Base R (for plotting and statistics)
* **IDE:** RStudio

## 👤 Author
[cite_start]**Raja Hamza Sikandar** [cite: 9]
* [cite_start]Registration: 2024532 [cite: 10]
* [cite_start]Section: H (BCS) [cite: 10]
