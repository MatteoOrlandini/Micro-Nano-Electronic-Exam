# Design of a sixth order elliptical low pass filter in cascade design with Switched Capacitor second stages order of type biquad

# Introduction

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

## Cadence design

## Dynamic range scaling

# Real filter

## Transmission gate

## Real opamp

# Prereqs

Virtuoso Cadence 6

# Results
