# ==========================================================
# SCH-MGMT 752 - Team Challenge
# Multi-year, multi-plant, multi-product production model
# - Existing plant: Chicago (CHI), always open
# - Optional new plant: Sunnyvale, CA (NEW), open in at most one year
# - Optional expansion of CHI, at most once (any year)
# - Optional Delta development at at most one plant (CHI or NEW)
# - 3 years, 3 markets, 4 products
# Objective: maximize total 3-year profit
# ==========================================================

############################
# 1. SETS
############################

set P;                   # Products: Alpha, Beta, Gamma, Delta
set M;                   # Markets: CHI, CA, SEA
set K;                   # Plants: CHI (existing), NEW (Sunnyvale)
set Y;                   # Years: 1,2,3
set L;                   # Test lines: A-line, C-line

############################
# 2. PARAMETERS
############################

# Demand upper bounds: max sales per product, market, year
param D{P,M,Y} >= 0;

# Revenue per unit for each product (same across markets/years in the PDF)
param R{P} >= 0;

# Manufacturing cost per unit at plant k
param C_mfg{P,K} >= 0;

# Shipping cost per unit from plant k to market m
param C_ship{P,M,K} >= 0;

# --- Testing time per unit on each line ---
# A-line: Alpha & Beta need 1 hour, others 0
# C-line: Gamma & Delta need 1 hour, others 0
param a_test{P,L} >= 0;

# Assembly hours per unit of each product
param a_assy{P,K} >= 0;

# --- Chicago capacities (base + extra if expanded) ---
# Base test capacity per line at CHI (same each year)
param Tbase_CHI{L} >= 0;          # e.g., A:6000, C:2400
param Texp_CHI{L}  >= 0;          # extra after expansion (e.g., A:+2000, C:+800)

# Base assembly capacity at CHI and extra after expansion
param Sbase_CHI >= 0;             # e.g., 100000
param Sexp_CHI  >= 0;             # e.g., 33000

# --- New plant capacities (only if open) ---
# These are per year when the NEW plant is open
param T_NEW{L} >= 0;              # e.g., A:5000, C:2000
param S_NEW    >= 0;              # e.g., 80000

# --- Fixed costs ---
param F_open_NEW   >= 0;          # fixed cost to open NEW plant (once)
param F_exp_CHI    >= 0;          # fixed cost for CHI expansion (once)
param F_dev_Delta{K} >= 0;        # fixed cost to develop Delta at plant k

############################
# 3. DECISION VARIABLES
############################

# Shipments: units of product p to market m in year y from plant k
var x{P,M,Y,K} >= 0;

# Plant open status: 1 if plant k is open in year y
var o{K,Y} binary;

# New-plant opening event: 1 if NEW is opened in year y (at most one y)
var u_open_NEW{Y} binary;

# Chicago expansion event: 1 if CHI is expanded in year y (at most one y)
var e_CHI{Y} binary;

# Cumulative expansion indicator: 1 if CHI is expanded in or before year y
var E_CHI{Y} binary;

# Delta development decision: 1 if Delta is developed at plant k
var dDelta{K} binary;

############################
# 4. DERIVED PARAMETERS
############################

# Per-unit net margin (revenue - mfg - shipping) at market m from plant k
param margin{p in P, m in M, k in K} :=
    R[p] - C_mfg[p,k] - C_ship[p,m,k];

############################
# 5. OBJECTIVE: MAX PROFIT
############################

maximize Profit:
    # Variable margin from all shipments
    sum{p in P, m in M, y in Y, k in K} margin[p,m,k] * x[p,m,y,k]
    # Fixed costs: open NEW, expand CHI, develop Delta
    - sum{y in Y} F_open_NEW    * u_open_NEW[y]
    - sum{y in Y} F_exp_CHI     * e_CHI[y]
    - sum{k in K} F_dev_Delta[k]* dDelta[k];

############################
# 6. CONSTRAINTS
############################

# 6.1 Chicago is always open
s.t. CHIAlwaysOpen{y in Y}:
    o["CHI",y] = 1;

# 6.2 New plant open status propagation (open at most once)
s.t. NEW_OpenOnce:
    sum{y in Y} u_open_NEW[y] <= 1;

s.t. NEW_OpenStatus{y in Y}:
    o["NEW",y] = sum{t in Y: t <= y} u_open_NEW[t];

# 6.3 Chicago expansion cumulative (expand at most once)
s.t. CHI_AtMostOneExp:
    sum{y in Y} e_CHI[y] <= 1;

s.t. CHI_CumExp{y in Y}:
    E_CHI[y] = sum{t in Y: t <= y} e_CHI[t];

# 6.4 At most one plant can develop Delta
s.t. Delta_OnePlant:
    sum{k in K} dDelta[k] <= 1;

# 6.5 Testing capacity constraints

# A-line at CHI and NEW:
s.t. TestCap_A{y in Y, k in K}:
    sum{p in P, m in M} a_test[p,"A"] * x[p,m,y,k]
    <= (
        if k = "CHI" then
            (Tbase_CHI["A"] + Texp_CHI["A"] * E_CHI[y])
        else
            T_NEW["A"]
       ) * o[k,y];

# C-line at CHI and NEW:
s.t. TestCap_C{y in Y, k in K}:
    sum{p in P, m in M} a_test[p,"C"] * x[p,m,y,k]
    <= (
        if k = "CHI" then
            (Tbase_CHI["C"] + Texp_CHI["C"] * E_CHI[y])
        else
            T_NEW["C"]
       ) * o[k,y];

# 6.6 Assembly capacity constraints

s.t. AssyCap{y in Y, k in K}:
    sum{p in P, m in M} a_assy[p,k] * x[p,m,y,k]
    <= (
        if k = "CHI" then
            (Sbase_CHI + Sexp_CHI * E_CHI[y])
        else
            S_NEW
       ) * o[k,y];

# 6.7 Demand / sales upper bounds

s.t. SalesCap{p in P, m in M, y in Y}:
    sum{k in K} x[p,m,y,k] <= D[p,m,y];

# 6.8 Ship only if plant is open (big-M using D as upper bound)

s.t. ShipIfOpen{p in P, m in M, y in Y, k in K}:
    x[p,m,y,k] <= D[p,m,y] * o[k,y];

# 6.9 Delta gating: only if developed at that plant, and plant is open

s.t. DeltaGate{m in M, y in Y, k in K}:
    x["Delta",m,y,k] <= D["Delta",m,y] * dDelta[k] * o[k,y];

# (Optional: if you want to explicitly enforce "decision in year 1" for Delta dev,
# you could add a comment or constraint linking dDelta to year 1 status, but
# economically it's not necessary since dDelta has no year index.)