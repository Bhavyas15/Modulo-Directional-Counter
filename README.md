# Modulo-Directional-Counter

A Verilog RTL implementation of a **12-bit modulo counter** with:

- Up/Down counting
- Selectable step size (±1 or ±2)
- Enable control
- Active-low asynchronous reset
- Wrap-around detection

The design wraps around the valid 12-bit range (`0` to `4095`) and asserts a `wrapped` signal whenever a wrap event occurs.

---

## Features

✔ 12-bit counter (`0` to `4095`)

✔ Count Up / Count Down

✔ Step size selection:
- `1` (`two = 0`)
- `2` (`two = 1`)

✔ Enable-controlled operation

✔ Active-low asynchronous reset

✔ Wrap detection output

✔ Included testbench for simulation

---

## Module Interface

```verilog
module counter_case(
    input clk,
    input rst_n,
    input enable,
    input up,
    input two,
    output reg [11:0] val,
    output reg wrapped
);
```

---

## Inputs

| Signal | Width | Description |
|----------|----------|----------|
| `clk` | 1 | System clock |
| `rst_n` | 1 | Active-low asynchronous reset |
| `enable` | 1 | Enables counter operation |
| `up` | 1 | Count direction (`1` = up, `0` = down) |
| `two` | 1 | Step size (`0` = 1, `1` = 2) |

---

## Outputs

| Signal | Width | Description |
|----------|----------|----------|
| `val` | 12 | Current counter value |
| `wrapped` | 1 | Asserted for one clock cycle when wrap occurs |

---

## Counting Modes

| `up` | `two` | Operation |
|--------|--------|-----------|
| 0 | 0 | Count down by 1 |
| 0 | 1 | Count down by 2 |
| 1 | 0 | Count up by 1 |
| 1 | 1 | Count up by 2 |

---

## Wrap-Around Behavior

### Count Up by 1

```text
4094 → 4095
4095 → 0      (wrapped = 1)
```

### Count Up by 2

```text
4093 → 4095
4094 → 0      (wrapped = 1)

4095 → 1      (wrapped = 1)
```

### Count Down by 1

```text
1 → 0
0 → 4095      (wrapped = 1)
```

### Count Down by 2

```text
2 → 0
1 → 4095      (wrapped = 1)

0 → 4094      (wrapped = 1)
```

---

## Design Approach

The design follows a common RTL structure:

### Combinational Logic

Computes:

- Next counter value (`val_next`)
- Wrap status (`wrapped_next`)

### Sequential Logic

Updates:

- `val`
- `wrapped`

on the rising edge of the clock.

This separation improves readability, maintainability, and scalability compared to mixing all logic inside a single clocked process.

---

## Simulation

Using XSim (Xilinx Simulator)

## Future Improvements

- Parameterizable counter width
- SystemVerilog assertions
- Self-checking testbench
- Constrained-random verification
- Functional coverage
- FPGA synthesis reports

---

## Learning Objectives

This project demonstrates:

- Sequential RTL design
- Combinational next-state logic
- Counter implementation
- Modulo arithmetic
- Wrap-around detection
- Testbench creation
- Simulation and waveform analysis
