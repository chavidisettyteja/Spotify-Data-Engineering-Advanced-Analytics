# 🎵 Spotify Data Engineering & Advanced Analytics
> **End-to-End SQL Pipeline: Normalization, Complex Querying, and Performance Tuning**
<img width="1365" height="595" alt="Gemini_Generated_Image_xpkplfxpkplfxpkp" src="https://github.com/user-attachments/assets/05e1cb61-0f50-47d7-9e31-970aa4f9864e" />


## 📝 Executive Summary
Transformed a denormalized Spotify dataset into a structured analytical environment. This project demonstrates the ability to handle large-scale audio metadata, perform multi-level analysis using **Window Functions** and **CTEs**, and implement database optimization techniques like **Indexing** to reduce query latency.

---

## 🛠️ Technical Stack
* **Database:** PostgreSQL / MySQL
* **Advanced SQL:** Common Table Expressions (CTEs), Window Functions (`RANK`, `SUM OVER`), Subqueries.
* **Optimization:** Query Execution Plans (`EXPLAIN ANALYZE`), B-Tree Indexing.

---

## 🗺️ The Analytical Roadmap

### 1. Data Architecture & Integrity
* **Schema Design:** Defined a robust schema for audio features (danceability, energy, valence) and engagement metrics (streams, views, likes).
* **Validation:** Cleaned and validated boolean attributes like `licensed` and `official_video` to ensure accuracy in cross-platform (Spotify vs. YouTube) comparisons.

### 2. Advanced Analytical Framework
#### **A. Engagement & Popularity Metrics**
* **Cross-Platform Analysis:** Engineered queries to compare streaming dominance between Spotify and YouTube, identifying tracks with "viral" video presence versus "pure" audio popularity.
* **Aggregated Insights:** Calculated total engagement (comments/likes) filtered by licensing status to determine the impact of official rights on user interaction.

#### **B. Audio Feature Engineering**
* **Energy Variance:** Leveraged **CTEs** to calculate the "Energy Spread" (difference between Max/Min energy) per album, identifying which artists experiment most with musical range.
* **Dynamic Benchmarking:** Used **Subqueries** to isolate tracks with above-average "Liveness" scores.

#### **C. Competitive Ranking (Window Functions)**
* **Artist Leaderboards:** Implemented `DENSE_RANK()` and `PARTITION BY` to extract the top 3 most-viewed tracks for every artist.
* **Cumulative Growth:** Applied `SUM() OVER()` to track the cumulative sum of likes ordered by views.

---

## 🔍 Technical Deep Dive: Query Optimization
*The core of this project was moving beyond simple retrieval to efficient execution:*

* **Performance Bottleneck Identification:** Used `EXPLAIN ANALYZE` to pinpoint slow-performing scans in the 15-question practice suite.
* **Strategic Indexing:** Implemented targeted indexes on high-frequency filter columns (e.g., `artist`, `track`, `streams`) to minimize full-table scans.
* **Result:** Successfully optimized complex window functions, significantly reducing execution time for "Advanced Level" queries.

---

## 💡 Key Insights Delivered

| Analysis Type | Technical Implementation | Business/User Value |
| :--- | :--- | :--- |
| **Market Dominance** | `CASE` & Filtering | Identified "Single" vs. "Album" performance trends. |
| **Top-Tier Performance** | `RANK()` Window Function | Automated the identification of artist "Power Tracks." |
| **Audio Profiling** | `WITH` Clause (CTEs) | Analyzed album consistency through energy-to-liveness ratios. |

---

## 🚀 Project Outcomes
* **Scalable Codebase:** Organized SQL scripts by complexity (Easy, Medium, Advanced).
* **Measurable Efficiency:** Demonstrated a significant reduction in query execution time through strategic indexing.
* **Data-Driven Discovery:** Provided a blueprint for analyzing how audio attributes correlate with global streaming success.
