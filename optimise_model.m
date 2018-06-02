function [model,R] = optimise_model(model, params, fcn)
    
    vars0 = [];
    entry = [];
    name = {};
    group = {};
    constraint = [];
    
    for j=1:size(params,1)
        for k=1:size(params,2)
            entry(end+1) = j;
            name{end+1} = params(j,k).name;
            group{end+1} = params(j,k).group;
            constraint(end+1,:) = params(j,k).constraint;
            vars0(end+1) = model.(group{end}).(name{end});
        end
    end
    
    for j=1:length(vars0)
        vars0(j) = map(vars0(j),constraint(j,:));
    end
    
    opts = optimset('MaxIter',5000);
    [vars] = fminsearch(@evalmodel,vars0,opts);
      
    [R,model] = evalmodel(vars);

    function [R,m] = evalmodel(vars)
        
        for i=1:length(vars)
            vars(i) = unmap(vars(i),constraint(i,:));
        end
        
        m = model;
        for i=1:length(vars)
            m(entry(i)).(group{i}).(name{i}) = vars(i);
        end
        
        R = fcn(m);
                
    end

end

function x = map(p,constraint)
    if all(isfinite(constraint))
        x = (p - constraint(1)) / (constraint(2) - constraint(1));
        x = (x - 0.5) * pi;
        x = tan(x);
    elseif isfinite(constraint(1))
        x = p - constraint(1);
        x = log(x);
    else
        x = p;
    end
end

function p = unmap(x,constraint)
    if all(isfinite(constraint))
        p = atan(x);
        p = (p / pi) + 0.5;
        p = p * (constraint(2) - constraint(1)) + constraint(1);
    elseif isfinite(constraint(1))
        p = exp(x);
        p = p + constraint(1);
    else
        p = x;
    end
end