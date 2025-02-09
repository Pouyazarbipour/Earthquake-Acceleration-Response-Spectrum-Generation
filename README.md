# Earthquake Acceleration Response Spectrum Generation GUI

This MATLAB GUI application generates an **Acceleration Response Spectrum** based on the **API RP 2WSD 2014** standard. The tool allows users to input soil type and coefficient values to compute and visualize the response spectrum. Visit this [link](https://drive.google.com/file/d/10ryFn7tB8vTP-ykpTG7pg3yg-AZlLyno/view?usp=sharing) to download.

## Features

- **Input parameters:**
    - Coefficient (G)
    - Soil Type (A, B, C)
- Plots the **Spectral Acceleration vs. Period** graph.
- Exports spectrum data to a `.txt` file.
- Simple and user-friendly interface.

---

## How to Use

1. **Launch the GUI:**
    Open MATLAB, navigate to the folder containing `Earthquake_acceleration_response_spectrum_GUI.m`, and run the script:
   
    ```matlab
    Earthquake_acceleration_response_spectrum_GUI
    ```
2.  **Enter Parameters:**
    - **Coefficient (G):** Enter a positive numerical value.
    - **Soil Type:** Select one of the options (A, B, or C) from the dropdown menu.
3.  **Generate the Spectrum:**
    - Click the "Generate Spectrum" button to compute and visualize the response spectrum.
4.  **Export the Data:**
    - After generating the spectrum, the data is saved as a `.txt` file. A dialog will prompt you to specify the file name and save location.

## Output

The application generates:

- A plot of the **Spectral Acceleration vs. Period**.
- A text file containing the following data:
    ```
    Period (s)   Spectral Acceleration (g)
    ```

## Example

**Inputs:**

- Coefficient (G): `1`
- Soil Type: `B`

**Output:**

- The response spectrum is plotted in the GUI.
-  The following data is saved in a `.txt` file (example):
Period (s) Spectral Acceleration (g)
0.01 0.20
0.02 0.40
0.03 0.60

## File Structure

- `Earthquake_acceleration_response_spectrum_GUI.m`: Main MATLAB script.
- `Export Earthquake acceleration response spectrum.txt`: Example output file (generated after running the script).

## Requirements

- MATLAB R2017b or later.
- Basic knowledge of response spectrum analysis.

## Known Issues

- **Input Validation:** Ensure that all inputs are valid (e.g., positive numerical values for G).
- **Plot Scaling:** Extreme values of G or T may require manual adjustment of axis limits.

---

## License  
This project is licensed under the MIT License. See the `LICENSE` file for details.  

---

## Contact  
For questions or feedback, please reach out to pouyazarbipour@gmail.com.
