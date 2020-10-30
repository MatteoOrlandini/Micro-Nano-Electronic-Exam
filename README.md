  # Design of a sixth order elliptical low pass filter in cascade design with Switched Capacitor second stages order of type biquad

  # Introduction

  I can't publish the Cadence files so the following README shows how to project a sixth order filter with Switched Capacitor in Cadence. For more information please see [wiki](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/wiki/Design-of-a-sixth-order-elliptical-low-pass-filter-in-cascade-design-with-Switched-Capacitor-second-stages-order-of-type-biquad), the italian language [report](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Relazione.pdf) or the [presentation](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Presentazione/Presentazione.pdf).

  ## Switched capacitor filter

  Filters generally consist of resistors, capacitors and inductors. Since the
  resistive elements are difficult to implement in integrated form and occupy large areas, these are replaced by switched capacitors. You can see
  that the switched capacitor behaves like a resistor of value R = 1/(f_clk*C). The switched capacitor filter to be designed must meet the following specifications.

  | Specification            | Value      |
  |--------------------------|------------|
  | Sampling frequency       | 2MHz       |
  | Pass band gain           | 0 dB       |
  | Bandwidth                | 0 - 60 kHz |
  | Pass band ripple         | < 0.15 dB  |
  | Fstop                    | 72 kHz     |
  | Attenuation in stopband  | 40 dB      |
  | Power supply voltage     | 3.3V       |
 
  # Getting started 

  ## Prerequisites

  * Matlab, Matlab Filter Designer
  * Virtuoso Cadence 6

  # How to use the Matlab code
  1. Open Matlab
  2. Open [filter_design.m](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Matlab/filter_design.m)
  3. Run the parts of the code to calculate the quality factor, the capacitances and the aspect ratio of the MOSFETs that constitute the real op-amp.

  # Results

  Following the steps in [wiki](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/wiki/Design-of-a-sixth-order-elliptical-low-pass-filter-in-cascade-design-with-Switched-Capacitor-second-stages-order-of-type-biquad) it's possible to design a sixth order filter in Cadence with second order sections. The AC responses are shown below.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/real_first_stage.png)

  First stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/real_second_stage.png)

  Second stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/real_third_stage.png)

  Third stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/real_filter.png)

  Total filter
