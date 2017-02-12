function DrawPhasor(p,I,h)

    I = ones(size(I));

    n = [];
    for i=1:size(p,1)
        pc = [imag(p(i,:)); real(p(i,:))]';        
        ni = histwv2(pc,I(i,:),0,1,256);
        ni = ni(2:255,2:255);
        n(:,:,i) = ni; % / prctile(ni(:),99.9);
    end
    
    n = flip(n,3); % BGR -> RGB
    
    n = n / prctile(n(:),99.9);
    n(n>1) = 1;
    set(h,'CData',n);
    
end