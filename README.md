# Multi-Year Production & Facility Optimization (MIP with CPLEX)

**Optimization-driven capacity planning and network design using mixed-integer programming**

## Overview
This project implements a multi-year optimization model to support strategic decisions around **facility location, capacity expansion, and production planning** for a multi-region manufacturing network. The model integrates long-term investment decisions with operational flows to identify profit-maximizing strategies under real-world constraints.

## Problem Context
Manufacturers face trade-offs between expanding capacity versus opening new facilities, serving distant markets versus minimizing logistics costs, and investing in new products under capital constraints. This project models these trade-offs jointly to support data-driven network design and capacity planning decisions.

## Approach
- Designed a **multi-period MIP** capturing facility investments, production flows, and market demand  
- Incorporated **capacity constraints, fixed investment costs, and unit economics**  
- Solved using **CPLEX** and evaluated strategies using **what-if scenario analysis**  
- Compared baseline vs. optimized strategies to quantify financial and operational impact  

## Results
- Increased total profit over the planning horizon by **~88%** compared to baseline  
- Identified **assembly capacity as the primary bottleneck**, guiding targeted capacity expansion  
- Demonstrated that opening a new regional facility reduced logistics costs and improved service levels  
- Informed product investment decisions by screening out unprofitable launches  

## Tech Stack
- Python (optimization modeling)  
- CPLEX (MIP solver)  
- Operations Research (network design, capacity planning)  

## Key Takeaway
This project shows how combining strategic investment decisions with operational constraints in a single optimization framework enables **high-impact, data-driven decisions** for manufacturing network design and capacity planning.

## Why This Matters

This project mirrors real-world network design, capacity planning, and strategic investment modeling used by manufacturing and supply chain teams. It demonstrates how optimization under constraints can guide facility siting, capacity expansion, and product investment decisions with material profit impact under uncertainty.

## How to Run 
	1.	Install dependencies and ensure CPLEX is available in your environment
	2.	Configure input data for plants, markets, costs, and capacities
	3.	Run the Python model to solve baseline and scenario cases
	4.	Compare profit, capacity utilization, and logistics costs across scenarios

⸻

📫 Contact

Yash Shah
For questions or collaboration, connect on [LinkedIn](https://www.linkedin.com/in/yashshah033).
