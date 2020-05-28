function confusion = majConf(confusion, individu, individu_reconnu, ListeClass)
    
ind = find(ListeClass==individu);
ind2 = find(ListeClass==individu_reconnu);

if ~isempty(ind)
    L = ind;
else
    L = 5;
end

if ~isempty(ind2)
    C = ind2;
else
    C = 5;
end

confusion(L, C) = confusion(L, C) + 1;

end