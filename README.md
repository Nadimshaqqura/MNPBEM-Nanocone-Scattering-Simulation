# MNPBEM Nanocone Scattering Simulation 

A MATLAB simulation script based on the **MNPBEM (Boundary Element Method) Toolbox** to model and evaluate the optical scattering cross-section of gold nanocone structures on a layered substrate ($50\text{ nm}$ ITO on dielectric substrate).

## Overview <img width="400" height="525" alt="cone shape" src="https://github.com/user-attachments/assets/77e158c4-96d1-4ac2-957c-19e591edc9fc" />


This script configures anumerical simulation by combining MNPBEM core modules with specialized geometry functions:

* **Substrate & Layer Configuration:** Defined a multi-layer system consisting of Air / ITO ($50\text{ nm}$, `ito3.dat`) / Substrate ($\epsilon = 2.25$).
* **Geometry Integration & Positioning:** Integrated a 3D nanocone mesh (`gen_cone`) into the MNPBEM compartment system and automated its spatial alignment directly above the ITO interface.
* **Excitation & Spectrum Parameterization:** Configured oblique TM-polarized plane-wave excitation ($\theta = 89^\circ$) across a $500\text{ nm} - 800\text{ nm}$ wavelength range.
* **Solver Execution & Caching:** Set up the retarded BEM solver using tabulated Green's functions (`compgreentablayer`) to efficiently handle substrate reflections.
* **Data Extraction:** Automated the export of computed scattering cross-sections (`sca`) and wavelength vectors (`enei`) to data files.

## Prerequisites

* **MATLAB** (R2020b or newer recommended)
* **MNPBEM Toolbox** (Must be added to MATLAB search path, including `gen_cone` helper functions)

## Usage

