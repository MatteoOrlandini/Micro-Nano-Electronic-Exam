  # Design of a sixth order elliptical low pass filter in cascade design with Switched Capacitor second stages order of type biquad

  # Introduction

  I can't publish the Cadence files so the following README shows how to project a sixth order filter with Switched Capacitor in Cadence. For more information please see the italian language [report](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Relazione.pdf) or the [presentation](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Presentazione/Presentazione.pdf).

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

  # Ideal filter

  ## Matlab Filter Designer
  To create a digital filter you can use the Matlab Filter Designer tool that allows you to quickly design FIR or IIR digital filters by setting filter performance.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Presentazione/Matlab/Filter_designer1.png)

  The result is a sixth order filter with three sections (or stage) of the second order, as shown in figure below.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Presentazione/Matlab/Filter_response_individual_log.png)

  Two section are high Q (quality factor) and one section is low Q.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Immagini/schema_high_q_zero_dentro.png)

  High Q schematic

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Immagini/schema_low_q_zero_dentro.png)

  Low Q schematic

  | Section | Quality factor |
  |---------|----------------|
  | 1       | 0.43889        |
  | 2       | 2.13921        |
  | 3       | 10.5363        |

  | Capacitance | Stage 1 | Stage 2 | Stage 3   |
  |-------------|---------|---------|-----------|
  |             |Q = 0.439|Q = 2.139|Q = 10.5363|
  | A, C        | 0.13058 | 0.17038 | 0.19238   |
  | B, D        | 1       | 1       | 1         |
  | F           | 0.21033 | 0       | 0         |
  | G           | 1.4654  | 0.30709 | 0.0093486 |
  | J, L        | 0       | 0       | 0         |
  | K           | 0.48419 | 0.69455 | 0.035118  |
  | E           | 0       | 0.45531 | 0.094951  |

  ## Cadence design

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Schematici/ideal_filter_first_stage_schematic.png)

  First stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Schematici/ideal_filter_second_stage_schematic.png)

  Second stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Schematici/ideal_filter_third_stage_schematic.png)

  Third stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_first_stage.png)

  First stage frequency response 

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_second_stage.png)

  Second stage frequency response 

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_third_stage.png)

  Third stage frequency response 

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_filter.png)

  Total filter frequency response

  ## Dynamic range scaling

  Dynamic Range Scaling scales the output voltage amplitude of each perational amplifier to ensure that each operational goes into saturation for the same input level. Scaling does not change the final output of the filter. The capacitance are changed as shown in the following table.

  | Capacitance | Stage 1 | Stage 2 | Stage 3   |
  |-------------|---------|---------|-----------|
  |             |Q = 0.439|Q=10.5363|Q = 2.139  |
  | A           | 2.3656  | 0.10094 | 0.21812   |
  | B           | 11.2222 | 0.5467  | 1.0002    |
  | C           | 1.4654  | 0.10517 | 0.17041   |
  | D           | 18.1162 | 0.5247  | 1.2802    |
  | E           | 0       | 0.05191 | 0.45531   |
  | F           | 2.36036 | 0       | 0         |
  | G           | 1.4654  | 0.10491 | 0.16789   |
  | J, L        | 0       | 0       | 0         |
  | K           | 0.48419 | 0.3941  | 0.3941    |

  The results are shown below.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_first_stage_dynamic_range_scaling.png)

  First stage frequency response 

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_second_stage_dynamic_range_scaling.png)

  Second stage frequency response 

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_third_stage_dynamic_range_scaling.png)

  Third stage frequency response 

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_filter_dynamic_range_scaling.png)

  Total filter frequency response

  # Real filter

  ## Transmission gate

  The first step to perform to desing the real filter is to project a real switch, in order to replace ideal switches with CMOS Transmission Gates. The scheme of the transmission gate and the R_ON resistance it exhibits when the switch is turned on are shown below.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Immagini/transmission_gate.png)

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Immagini/transmission_gate_ron.png)

  The transmission gate scheme in Cadence is shown in the figure below, where it can be seen that the bulk of the N and P channel MOSFETs are connected to their respective sources.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Schematici/transmission_gate_schematic.png)

  The geometry of the MOSFETs is shown below.

  |      | Aspect ratio |
  |------|--------------|
  | NMOS | 3/1          |
  | PMOS | 12/1         |

  The transmission gate test bench is shown below with an input clock source of 2 MHz.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Schematici/transmission_gate_schematic_testbench.png)

  It can be seen that the input signal reaches VDD = 3.3V and VSS = 0V in about 150 ns. This time is in line with expectations, as the capacitor has to charge e
  discharge in less time than the clock period T = 250 ns.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/transmission_gate.png)

  The results are shown below

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_opamp_real_switch_first_stage.png)

  First stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_opamp_real_switch_second_stage.png)

  Second stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_opamp_real_switch_third_stage.png)

  Third stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/ideal_opamp_real_switch.png)

  Total filter

  ## Real opamp

  In the final part of the project it is necessary to replace the ideal op-amps with real op-amps. The schematic of a two-stage operational amplifier is shown in the following figure.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Immagini/op_amp.png)

  The design of the operation amplifier in Cadence is shown below. The ideal current source is replaced by a MOSFET-only bias current mirror.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Schematici/real_opamp.png)

  The geometry of the MOSFETs that constitute the op-amp is summarised in the table below.

  | MOSFET      | Aspect ratio |
  |-------------|--------------|
  | M1, M2      | 125/1        |
  | M3, M4      | 55/1         |
  | M5, M8, MN7 | 29/1         |
  | M6          | 1600/2       |
  | M7          | 210/1        |
  | MP0, MP1    | 3/3          |

  The scheme used to test the real open-loop operation is shown in the figure. A common mode DC generator of 1.65 V amplitude is used, while a sine wave generator of 2 MHz frequency and 10 mV amplitude is connected to the non-inverting input. 

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Schematici/real_opamp_testbench.png)

  With the previously calculated aspect ratio values, we find a DC gain greater than 60 dB and a gain-bandwith equals to 10 MHz.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/op_amp_gain_phase.png)

  To test the specifications on the slew-rate of the op-amp the circuit in the figure was used, in which it can be seen that there is a feedback between the output and the inverting input. The non-inverting input has been connected a square wave generator of frequency f = 2 MHz.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Schematici/slew_rate_testbench.png)

  The result of the test bench is shown in the following graph. To calculate the slew rate, the formula SR = ΔV/Δt must be used and the result is 7.81 V/μs greather that 6 V/μs calculated from the specification.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/slew_rate.png)

  ## Capacitance Minimization Scaling

  The last step to be taken to complete the project is the capacitance minimization scaling to minimize the capacities in the real filter. Through this static scaling procedure, each group of capacities connected or switched at the input of an operational is modified.

  | Capacitance | Stage 1 | Stage 2 | Stage 3   |
  |-------------|---------|---------|-----------|
  |             |Q = 0.439|Q=10.5363|Q = 2.139  |
  | A           | 111.396 | 22.8    | 22.8      |
  | B           | 528.453 | 123.488 | 104.53    |
  | C           | 22.801  | 46.193  | 23.141    |
  | D           | 281.888 | 230.458 | 173.851   |
  | E           | 0       | 22.8    | 61.831    |
  | F           | 111.149 | 0       | 0         |
  | G           | 22.801  | 46.078  | 22.8      |
  | J, L        | 0       | 0       | 0         |
  | K           | 22.8    | 89.019  | 39.691    |

  # Prereqs

  * Matlab, Matlab Filter Designer
  * Virtuoso Cadence 6

  # Results

  The following graphs show the frequency analysis of each stage of the real filter and the overall filter, after carrying out the static scaling. You can see how the initial specifications are also met in the real filter.

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/real_first_stage.png)

  First stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/real_second_stage.png)

  Second stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/real_third_stage.png)

  Third stage

  ![](https://github.com/MatteoOrlandini/Micro-Nano-Electronic-Exam/blob/master/Relazione/Plot/real_filter.png)

  Total filter
