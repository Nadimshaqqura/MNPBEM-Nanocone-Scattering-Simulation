# MNPBEM Nanocone Scattering Simulation

A MATLAB simulation script based on the **MNPBEM (Boundary Element Method) Toolbox** to compute the electromagnetic scattering cross-section of gold nanocones on a layered substrate ($50\text{ nm}$ ITO on dielectric substrate).

## Physics & Simulation Setup

* **Nanostructure Geometry:** Parametric 3D gold nanocone generated via `gen_cone` and converted into a boundary-element compartment.
* **Layered Substrate:** Multi-layer system consisting of air, a $50\text{ nm}$ Indium Tin Oxide (ITO) thin film (`ito3.dat`), gold material data (`gold.dat`), and a dielectric substrate ($\epsilon = 2.25$).
* **Electromagnetic Solver:** 
  * Retarded BEM solver utilizing precomputed Green's function tables (`compgreentablayer`) to handle reflection at dielectric interfaces efficiently.
  * Plane-wave excitation from above ($\theta = 89^\circ$, TM polarization) across a wavelength spectrum of $500\text{ nm} - 800\text{ nm}$.

## Features

* **Substrate Interfacing:** Automatically positions the 3D nanocone mesh directly above the ITO interface.
* **Green's Function Caching:** Reuses existing tabulated Green's functions (`greentab`) to accelerate iterative execution.
* **Interactive Feedback:** Real-time progress monitoring using `multiWaitbar`.
* **Data Export:** Outputs computed scattering cross-sections (`sca`) and wavelength vectors (`enei`) to formatted CSV files.

## Prerequisites

* **MATLAB** (R2020b or newer recommended)
* **MNPBEM Toolbox** (Must be added to MATLAB search path)

