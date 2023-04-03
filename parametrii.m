function [val_med,P] = parametrii(x, N_es, Tmax, T)
%PARAMETRII - functia returneaza valoarea medie si numarul de perioade T din Tmax
% val_med returneaza valoarea medie a semnalului folosind functia de mediere
% P returneaza numarul de perioade T din Tmax
val_med = mean(x);
disp(['Valoarea medie este: ' num2str(val_med)]);
%disp(val_med);
P = Tmax/T;
disp(['Numarul de perioade in Tmax este: ' num2str(P)]);
%disp(P);
end
