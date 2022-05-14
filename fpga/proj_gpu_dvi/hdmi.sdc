create_clock -name pclk -period 13.33 -waveform {0 6.66}
derive_pll_clocks -gen_basic_clock
