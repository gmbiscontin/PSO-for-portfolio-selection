# **PSO for Portfolio Selection**  

## **Overview**  

Particle Swarm Optimization (PSO) is a **nature-inspired, iterative, population-based, evolutionary, derivative-free metaheuristic** designed for solving **global unconstrained optimization problems**.  

PSO is an **efficient computational method** that optimizes a problem by iteratively improving a **swarm of candidate solutions**. Each candidate, referred to as a **particle**, moves within the search space according to a set of mathematical rules. The movement of each particle is influenced by:  

- Its **own best-known position** (personal best).  
- The **best-known position** discovered by any particle in the swarm (global best).  

PSO enables efficient exploration of complex, high-dimensional search spaces, making it well-suited for **computationally expensive optimization problems** across various domains.  

---

## **Mathematical Foundation**  

The behavior of PSO is inspired by the movement of a **flock of birds** or **a school of fish** searching for food. This analogy can be translated into a mathematical framework for **minimization or maximization problems**:  

- Each **particle** represents a **potential solution** to the optimization problem.  
- Each particle is **randomly initialized** within the feasible solution space.  
- Each particle is assigned an **initial velocity**, determining its direction and speed of movement.  

At each iteration, particles adjust their positions based on their own experience and the experience of the swarm, gradually converging toward the optimal solution.  

---

## **Application to Portfolio Optimization**  

This project applies **Particle Swarm Optimization (PSO)** to construct an **efficient investment portfolio** by:  

1. **Minimizing portfolio variance** (reducing risk).  
2. **Maximizing expected return** (improving performance).  

To achieve this, **10 financial assets** were selected based on their **historical daily stock prices**:  

- **Tesla (TSLA)**  
- **Coca-Cola (KO)**  
- **Procter & Gamble (PG)**  
- **Bank of America (BAC)**  
- **Boeing (BA)**  
- **Meta (META)**  
- **Chevron (CVX)**  
- **FedEx (FDX)**  
- **Amazon (AMZN)**  
- **Walmart (WMT)**  

These assets form the basis of the portfolio optimization problem, where PSO is employed to **find the optimal allocation of weights** for maximizing the portfolio's performance.  

---

## **Computational Setup**  

The PSO algorithm was executed under the following configuration:  

- **Number of iterations per run**: **5000**  
- **Number of independent runs**: **3**  
- **Target return values (π)**: `[0.049149, 0.05, 0.06, 0.07, 0.08]`  

The algorithm performs **3 runs for each of the 5 return thresholds**, resulting in a **total of 15 optimizations**. The results are consolidated into a table summarizing the optimal portfolio weights and corresponding risk-return characteristics.  

---

## **Conclusion**  

This implementation of **Particle Swarm Optimization (PSO)** demonstrates its ability to effectively **navigate complex financial landscapes**, optimizing asset allocation by balancing **return and risk**. The algorithm's **adaptive nature** allows for **dynamic portfolio construction**, making it a powerful tool for financial decision-making.  
