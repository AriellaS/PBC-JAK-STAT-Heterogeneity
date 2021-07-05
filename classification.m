clear all;

load('holly_results/lowest_error_responses.mat')
sample_size = size(responses,1);

% peak, peak loc, min, min loc, peak-min slope, min-6hr slope
features = [];

recovertime = 361; % 6 hours

for res = 1 : 4

	response = responses(:,:,res);

	for i = 1 : sample_size
		[peaks,	peak_locs] = findpeaks(response(i,:));
		[mins, min_locs] = findpeaks(-response(i,:));
		mins = -mins;

		numpeaks = length(peaks);

		if (length(mins) > 0 & length(peaks) > 0) % shape 1 must have atleast one min and one max

			heightdiffs = zeros(numpeaks,1);
			slopes = zeros(numpeaks,1);
			for pk = 1 : numpeaks
				mn = find(min_locs > peak_locs(pk),1); % finds next min to peak
				if (length(mn) > 0) % shape 1 must have min after peak
					heightdiff = peaks(pk) - mins(mn);
					slope = heightdiff / (min_locs(mn) - peak_locs(pk));
					heightdiffs(pk) = heightdiff;
					slopes(pk) = slope;
				end
			end
			[heightdiff, peak_index] = max(heightdiffs);

			if (heightdiff > 0) % max heightdiff will be 0 only if no min after peak
				slope = slopes(peak_index);

				peak = peaks(peak_index);
				peak_loc = peak_locs(peak_index);

				min_index = find(min_locs > peak_loc,1);
				minimum = mins(min_index);
				min_loc = min_locs(min_index);

				recover = response(i,recovertime);
				recover_slope = (recover - minimum) / (recovertime - min_loc);

				if (recover_slope > 0) % shape 1 must have positive slope btwn min and end
					features(i,1,res) = peak;
					features(i,2,res) = minimum;
					features(i,3,res) = peak_loc;
					features(i,4,res) = min_loc;
					features(i,5,res) = slope;
					features(i,6,res) = recover_slope;

					shape1_indicies(i,res) = 1;
				else
					shape1_indicies(i,res) = 0;
				end
			else
				shape1_indicies(i,res) = 0;
			end
		else
			shape1_indicies(i,res) = 0;
		end
	end
end

shape1_indicies = logical(shape1_indicies);
