
End-to-End Optimization & Scenario Analysis for Capacity Planning and Network Design

🔍 Overview

This project develops a multi-year mixed-integer programming (MIP) model to optimize production planning, facility opening/expansion decisions, and market allocation for a manufacturing firm operating across multiple regions. The model jointly determines:
	•	When to open a new plant and expand existing capacity
	•	Whether to launch a new product under fixed investment constraints
	•	How to allocate production and shipments across plants, markets, and years

The objective is to maximize total profit while satisfying detailed capacity, demand, shipping cost, and fixed investment constraints.

⸻

🧠 Business Questions Solved
	•	When should a new facility be opened to minimize logistics cost and capacity bottlenecks?
	•	When should existing capacity be expanded to unlock profitable growth?
	•	Which products should be prioritized given constrained assembly capacity?
	•	How do different what-if scenarios (no expansion, no new plant, forced product launch) impact profit and feasibility?

⸻

🧩 Methodology
	•	Formulated a multi-period, multi-plant, multi-product MIP in Python
	•	Solved using CPLEX
	•	Modeled:
	•	Facility opening & expansion (binary investment decisions)
	•	Production and shipment flows
	•	Assembly & testing capacity constraints
	•	Fixed investment costs and unit margins
	•	Performed scenario analysis across multiple strategic policies:
	•	Baseline (single plant, no expansion)
	•	Optimal strategy (new plant + expansion)
	•	No expansion
	•	No new plant
	•	Forced new product development

⸻

📈 Key Results
	•	Increased 3-year total profit by ~88% vs. baseline through optimal facility and capacity decisions
	•	Identified assembly capacity as the binding bottleneck (not testing lines)
	•	Recommended:
	•	Opening a West Coast facility in Year 1
	•	Expanding the existing plant in Year 1
	•	Rejecting unprofitable new product launch under current cost structure
	•	Reduced logistics costs by serving West Coast markets locally

⸻

🛠 Tech Stack
	•	Python – optimization modeling
	•	CPLEX – MIP solver
	•	Operations Research – network design, capacity planning
	•	Scenario analysis / what-if simulations

⸻

📌 Why This Matters

This project mirrors real-world network design, capacity planning, and strategic investment modeling used by manufacturing and supply chain teams. It demonstrates how optimization under constraints can guide facility siting, capacity expansion, and product investment decisions with material profit impact under uncertainty.

⸻

▶️ How to Run (Optional)
	1.	Install dependencies and ensure CPLEX is available in your environment
	2.	Configure input data for plants, markets, costs, and capacities
	3.	Run the Python model to solve baseline and scenario cases
	4.	Compare profit, capacity utilization, and logistics costs across scenarios

⸻

📫 Contact

Yash Shah
For questions or collaboration, connect on [LinkedIn](https://www.linkedin.com/in/yashshah033).
