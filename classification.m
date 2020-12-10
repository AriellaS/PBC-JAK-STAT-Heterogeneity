% peak, peak loc, min, min loc, peak-min slope, min-6hr slope
characteristics = zeros(1E4,6);
nanrows = [];

recovertime = 361; % 6 hours

output = 4;

for i = 1 : 1E4
	[peaks,	peak_locs] = findpeaks(outputs(i,:,output));
	[mins, min_locs] = findpeaks(-outputs(i,:,output));
	mins = -mins;

	numpeaks(i) = length(peaks);

	if (length(mins) > 0)

		slopes = zeros(length(peaks),1);
		for pk = 1 : length(peaks)
			mn = find(min_locs > peak_locs(pk),1); % finds next min to peak
			if (length(mn) > 0)
				slope = (mins(mn) - peaks(pk)) / (min_locs(mn) - peak_locs(pk));
				slopes(pk) = slope;
			end
		end
		[slope,peak_index] = min(slopes); % most negative slope

		peak = peaks(peak_index);
		peak_loc = peak_locs(peak_index);

		min_index = find(min_locs > peak_loc,1);
		minimum = mins(min_index);
		min_loc = min_locs(min_index);

		recover = outputs(i,recovertime,output);

		characteristics(i,1) = peak;
		characteristics(i,2) = peak_loc;
		characteristics(i,3) = minimum;
		characteristics(i,4) = min_loc;
		characteristics(i,5) = slope;
		characteristics(i,6) = (recover - minimum) / (recovertime - min_loc);
	else
		characteristics(i,:) = repelem(NaN,6);
		nanrows(end+1) = i;
	end
end

