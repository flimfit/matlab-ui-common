function sp = CalculateSpectralPhasor(I)
    
    n = size(I,1);
    omega = linspace(0,2*pi,n+1);
    omega = omega(1:end-1);
    s = exp(omega'*1i);
    sp = squeeze(sum(I.*s,1) ./ sum(I,1));

end