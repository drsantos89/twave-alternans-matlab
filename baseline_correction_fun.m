function beat_vector_corr = baseline_correction(beat_vector)

beat_vector_corr = beat_vector;

for i = 1:size(beat_vector,2)
    for j = 1:size(beat_vector,3)
        baseline = mean(beat_vector(:,i,j));
        beat_vector_corr(:,i,j) = beat_vector(:,i,j) - baseline;
    end
end

end

