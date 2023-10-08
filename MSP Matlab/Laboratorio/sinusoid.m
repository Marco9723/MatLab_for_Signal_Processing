function sinusoidal = sinusoid(time_axis, A, f, phase)
% generate a sinusoidal signal

sinusoidal = A*cos(2*pi*f*time_axis + phase);

end

