function [est] = simulReconstruct2cat(mus,sigs,sigm,stim,modelopt)

% Calculate category posterior
p_C_given_M = zeros(length(stim),2);
for i = 1:2
    p_C_given_M(:,i) = normpdf(stim,mus(i),sigs(i).^2);
end
% Normalize to sum to 1
p_C_given_M = p_C_given_M ./ repmat(sum(p_C_given_M,2),1,2);


if modelopt == 1 %max
    
    % Denominators
    sigSumSqr = sigs.^2 + sigm^2;
    
    [dum,cinds] = (max(p_C_given_M'));
    
    est = ((sigs(cinds).^2).* stim + sigm^2*mus(cinds)) ./ ...
        sigSumSqr(cinds);
    
else %int
    
    
    Pi1 = p_C_given_M(:,1)'; Pi2 = p_C_given_M(:,2)';
    npt = length(stim);
    
    for cc = 1:2
        
        cinds = cc * ones(npt,1);
        
        % Denominators
        sigSumSqr = sigs(cinds).^2 + sigm^2;
        
        SigVec{cc} = ( (sigs(cinds).^2) * (sigm^2) ) ./ sigSumSqr;%(cinds);
        MUvec{cc} = ( (sigs(cinds).^2).*stim + sigm^2 * mus(cinds) ) ./ ...
            sigSumSqr;
        
    end
    
    
    est = MUvec{1}.* Pi1 + MUvec{2} .* Pi2;
    
    
    
end

end