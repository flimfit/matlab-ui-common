function [p,I] = CalculatePhasor(t, data, irf_phasor, background)

    data = double(data);
    sz = size(data);

    if length(sz) > 3
        data = reshape(data,[sz(1:2) prod(sz(3:end))]);
    else
        sz = [sz 1];
    end
    
    t = reshape(t,[length(t), 1]);
    
    if nargin < 3
        irf_phasor = 1;
    end
    if nargin == 4
        data = data - background; %repmat(background,[1 1 sz(3:4)]);
    end

    data(data<0) = 0;
    
    n_channel = size(data,2);

    T = 12500;
    omega = 2*pi/T;
    
    t_offset = 0; % t(2)/2
    
    n = prod(sz(2:end));
    d = reshape(data, [sz(1), n]);
    c = repmat(exp(1i * omega * (t+t_offset)),[1 n]);

    I = sum(d,1);

    p = sum(d.*c,1) ./ I;

    p(I==0) = 0;
    
    p = reshape(p,n_channel,n/n_channel);
    I = reshape(I,n_channel,n/n_channel);

    % Subtract IRF
    pir = repmat(irf_phasor, [1, size(p,2)]);
    p = p ./ pir;
    
    p = reshape(p,sz(2:end));
    I = reshape(I,sz(2:end));
    
end