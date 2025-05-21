📡 Communications Systems Project 
👨‍💻 By Mahmoud Saad Mostafa Abozid Farag
Final year project – Communications and Computers, Faculty of Engineering, Benha University

🔍 Overview
This project implements and analyzes several analog modulation and demodulation techniques using MATLAB, as part of the "Communication Systems I" course. The goal is to explore the effect of different modulation schemes on audio signals, and examine their behavior in the presence of bandwidth limitations and noise.

📁 Project Structure
Part I: Signal Acquisition and Preprocessing

Record voice sample

Plot time/frequency domain

Apply low-pass filtering (e.g., 3.4 kHz)

Test intelligibility at different cutoffs

Identify fricatives, plosives, and nasals

Part II: Amplitude Modulation

DSB-LC and DSB-SC Modulation

Coherent & envelope detection

Energy normalization and comparison

SSB-SC with Hilbert transform

Part III: Frequency Modulation (FM)

FM modulation using β = 3 and β = 5

Demodulation using direct method

FM of sinusoidal tone at 3 kHz

Part IV: FM in Presence of Noise

Additive White Gaussian Noise (AWGN)

Explore SNR and threshold effect

Report β at which demodulation breaks

🛠 Technologies
MATLAB (signal processing, plotting, modulation)

Sampling Frequency: 48 kHz

Filters: FIR, Butterworth, etc.

Signal types: DSB-LC, DSB-SC, SSB-SC, FM

📷 Sample Output
The project includes time-domain and frequency-domain plots, intelligibility analysis, modulation/demodulation comparisons, and SNR studies with different modulation indices.

📌 How to Run
Open MATLAB

Navigate to the project directory

Run each script (part1.m, part2.m, etc.)

Ensure audio input/output works for playback

Use subplot() to visualize plots per part

📄 Report & Files
📝 PDF Report: Includes theory, plots, and analysis

💻 MATLAB Code: Clean, commented scripts

🎧 Voice Samples: Recorded and filtered audio clips

🏆 Acknowledgments
This project was completed as part of the coursework under supervision of the Communications Department – Faculty of Engineering, Benha University, Spring 2024.
