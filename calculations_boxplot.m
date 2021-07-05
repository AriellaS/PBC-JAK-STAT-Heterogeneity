function response = calculations_boxplot(predConc,totalSTAT,Vratio)

	cytosolic_pStatA = predConc(:,13) + 2.*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + predConc(:,24) + predConc(:,27);
	cytosolic_pStatB = predConc(:,14) + 2.*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + predConc(:,25) + predConc(:,26);

	nuclear_pStatA = 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + 2*predConc(:,37) + predConc(:,38) + predConc(:,40) + predConc(:,43);
	nuclear_pStatB = 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + 2*predConc(:,39) + predConc(:,38) + predConc(:,41) + predConc(:,42);

	npA_ratio_cpA = nuclear_pStatA./cytosolic_pStatA;
	npB_ratio_cpB = nuclear_pStatB./cytosolic_pStatB;

	total_pStatA = predConc(:,13) +2.*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + predConc(:,24) + predConc(:,27) + 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + 2*predConc(:,37) + predConc(:,38) + predConc(:,40) + predConc(:,43);
	total_pStatB = predConc(:,14) +2.*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + predConc(:,25) + predConc(:,26) + 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + 2*predConc(:,39) + predConc(:,38) + predConc(:,41) + predConc(:,42);

	cytosolic_statA = predConc(:,3) + predConc(:,11) + predConc(:,13) + 2*predConc(:,15) + predConc(:,16) + predConc(:,19) + 2*predConc(:,21) + predConc(:,23) + 2*predConc(:,24) + predConc(:,26) + predConc(:,27) + predConc(:,48);
	cytosolic_statB = predConc(:,4) + predConc(:,12) + predConc(:,14) + 2*predConc(:,17) + predConc(:,16) + predConc(:,20) + 2*predConc(:,22) + predConc(:,23) + 2*predConc(:,25) + predConc(:,26) + predConc(:,27) + predConc(:,49);

	nuclear_statA = 2*predConc(:,28) + predConc(:,29) + predConc(:,31) + predConc(:,33) + predConc(:,35) + 2*predConc(:,37) + predConc(:,38) + 2*predConc(:,40) + predConc(:,42) + predConc(:,43);
	nuclear_statB = 2*predConc(:,30) + predConc(:,29) + predConc(:,32) + predConc(:,34) + predConc(:,36) + 2*predConc(:,39) + predConc(:,38) + 2*predConc(:,41) + predConc(:,42) + predConc(:,43);

	total_statA = nuclear_statA*Vratio + cytosolic_statA;
	total_statB = nuclear_statB*Vratio + cytosolic_statB;

	totpA_ratio_totA = (nuclear_pStatA*Vratio + cytosolic_pStatA)./totalSTAT;
	totpB_ratio_totB = (nuclear_pStatB*Vratio + cytosolic_pStatB)./totalSTAT;

	response(:,1) = squeeze(npA_ratio_cpA);
	response(:,2) = squeeze(npB_ratio_cpB);
	response(:,3) = squeeze(totpA_ratio_totA);
	response(:,4) = squeeze(totpB_ratio_totB);

	response(isnan(response)) = 0;
end
