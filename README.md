<div align="center">

# 4-Bit Ripple Carry Adder (RCA) - Complete RTL-to-GDSII ASIC Flow 🚀
### A Silicon Journey: From Behavioral Verilog to Sky130 Manufacturing-Ready Layout

[![OpenLane](https://img.shields.io/badge/OpenLane-Automated%20Flow-blue.svg)](https://github.com/The-OpenROAD-Project/OpenLane)
[![PDK](https://img.shields.io/badge/PDK-Sky130-red.svg)](https://github.com/google/skywater-pdk)
[![Language](https://img.shields.io/badge/Language-Verilog-blueviolet.svg)](#)
[![Status](https://img.shields.io/badge/Status-DRC%20%26%20LVS%20Clean-success.svg)](#)

*Documenting the complete physical design realization of a 4-bit Ripple Carry Adder using the open-source OpenLane toolchain and SkyWater 130nm standard cell library.*

<img src="rca%20ss/klayout.png" alt="Final KLayout GDSII Layout" width="800px">

---

**[Explore the Visual Journey](#-the-rtl-to-gdsii-visual-journey) • [Reproduce the Flow](#-how-to-reproduce) • [Repository Structure](#-repository-structure)**

</div>

---

## 💡 Project Overview & Physical Constraints

A **Ripple Carry Adder (RCA)** serves as a fundamental combinational building block where the carry bit propagates sequentially through each full adder stage ($C_0 \to C_1 \to C_2 \to C_3$). While architecturally straightforward, executing its physical implementation through an ASIC backend highlights key design trade-offs regarding carry propagation delay, power rail distribution, and standard cell area optimization.

This project drives a behavioral Verilog model of a 4-bit RCA completely through the automated **OpenLane** flow to achieve a tapeout-ready macro layout targeting the **SkyWater 130nm (`sky130A`)** open PDK.

---

## 🛠️ Tools & Technology Stack

| Flow Stage | Open-Source Tool / PDK | Function |
| :--- | :--- | :--- |
| **Process Node** | SkyWater 130nm (`sky130A`) | Target silicon manufacturing technology (`sky130_fd_sc_hd`) |
| **Functional Verification** | Icarus Verilog (`iverilog`) & GTKWave | RTL simulation and waveform debugging |
| **Logic Synthesis** | Yosys & abc | Gate-level netlist generation & tech-mapping |
| **Floorplan & Placement** | OpenROAD | Core/die initialization, PDN, and cell placement |
| **Clock Tree & Routing** | OpenROAD (TritonRoute) | Global and detailed interconnect routing |
| **Physical Verification** | Magic & Netgen | Signoff DRC checks and LVS netlist comparison |
| **GDSII Layout Viewer** | KLayout | Final layout viewer and stream file verification |

---

## 📊 Summary Results & Design Metrics

* **Module Chip Area:** `183.926 μm²`
* **Total Standard Cells:** 20 instances (`sky130_fd_sc_hd` high-density library)
* **Total Power Consumption:** `14.5 µW` ($1.45 \times 10^{-5}\text{ W}$)
  * **Internal Power:** `5.20 µW` (35.9%)
  * **Switching Power:** `9.28 µW` (64.1%)
  * **Leakage Power:** `7.71 pW` (~0.0%)
* **Physical Verification:** **0 DRC Violations** | **LVS Clean (45 Nets matched)** | **0 Antenna Violations**

---

## 📖 The RTL-to-GDSII Visual Journey

Follow the automated physical design pipeline execution step-by-step with verified visual checkpoints from our runtime workspace:

### 1️⃣ RTL Design & Functional Verification
The behavioral logic of the 4-bit adder was validated using a comprehensive testbench. Waveform inspection in GTKWave confirms correct 4-bit addition (`A + B + Cin = Sum, Cout`) across varied test vectors.

<p align="center">
  <img src="rca%20ss/waveforms.png" width="90%" alt="GTKWave Verification Waveforms">
</p>

### 2️⃣ Logic Synthesis (Yosys)
The Verilog source description is mapped into structural gates using 20 standard cells from the `sky130_fd_sc_hd` library (including `xnor2`, `nand2`, `nor2`, `or2`, `a21bo`, and `and2` gates) to optimize total module area (`183.926 μm²`).

<p align="center">
  <img src="rca%20ss/area.png" width="70%" alt="Synthesis Area and Cell Report">
</p>

### 3️⃣ Floorplanning & Power Delivery Network (PDN)
The core boundary is initialized and I/O pins (`A[3:0]`, `B[3:0]`, `cin`, `sum[3:0]`, `cout`) are arranged along the periphery. Power rings and vertical/horizontal power stripes (`VDD`/`GND`) are inserted to ensure IR drop integrity.

> 💡 **Pro-Tip for Interactive Workspace Viewing:**
> To explore the layout database interactively using OpenROAD GUI:
> 1. Start the container: `make mount`
> 2. Open the interface: `openroad -gui`
> 3. Source the layout database file: `read_db runs/<run_name>/results/floorplan/rca.odb`

<p align="center">
  <img src="rca%20ss/floorplan.png" width="80%" alt="OpenROAD Floorplan Window">
</p>

### 4️⃣ Global & Detailed Placement
Standard cells are legally placed into core rows. The placement tool balances local density and wirelength to minimize routing congestion.

<p align="center">
  <img src="rca%20ss/placement.png" width="80%" alt="Global and Detailed Cell Placement">
</p>

### 5️⃣ Interconnect Routing
Signal interconnects are routed across multi-layer metal grids (`met1`–`met5`) using TritonRoute, preserving minimum manufacturing rules and resolving wire track overlaps.

<p align="center">
  <img src="rca%20ss/routing.png" width="80%" alt="Routed Netlist OpenROAD View">
</p>

### 6️⃣ Physical Signoff & Power Analysis
The finished layout was exported for signoff verification. Power analysis indicates a lean total consumption of `14.5 µW`. Magic DRC confirms **0 violations**, Netgen LVS confirms a clean **45-net match**, and antenna checks pass clean with **0 violations**.

<p align="center">
  <img src="rca%20ss/power.png" width="48%" alt="Power Consumption Summary">
  <img src="rca%20ss/drc.png" width="48%" alt="DRC, LVS, and Antenna Signoff Summary">
</p>

---

## 📂 Repository Structure

```text
4-bit-rca-from-RTL-to-GDSII-using-opensource-VLSI-tool/
├── rca ss/                 # Visual logs, simulation waveforms, and layout screenshots
│   ├── area.png
│   ├── drc.png
│   ├── floorplan.png
│   ├── klayout.png
│   ├── placement.png
│   ├── power.png
│   ├── routing.png
│   └── waveforms.png
├── src/                    # Behavioral Verilog source files (*.v) and testbench
├── config.json             # OpenLane floorplan constraints and design configurations
├── rca.gds                 # Exported binary stream file for fabrication
└── README.md               # Project documentation
