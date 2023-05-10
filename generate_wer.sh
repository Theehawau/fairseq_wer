# Their kmeans
# S2UT (reduced)
echo "Their kmeans S2UT (reduced)"
fairseq-generate /home/hawau.toyin/Documents/s2sdata/exp6  \
  --config-yaml config.yaml  \
  --task speech_to_speech --target-is-code --target-code-size 100 --vocoder code_hifigan \
  --path /home/hawau.toyin/Documents/s2sdata/exp6/models/checkpoint_best.pt  --gen-subset dev \
  --max-tokens 50000 \
  --beam 10 --max-len-a 1 \
  --results-path /home/hawau.toyin/Documents/s2sdata/exp6/preds

 grep "^W\-" /home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-dev.txt | \
  sed 's/^W-//ig' | cut -f2,3 \
  > /home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-dev.tsv

python /home/hawau.toyin/Documents/nlp/score.py \
 --exp_name 'Pt. kmeans S2UT (reduced)' --dev_path '/home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-dev.tsv'


fairseq-generate /home/hawau.toyin/Documents/s2sdata/exp6  \
  --config-yaml config.yaml  \
  --task speech_to_speech --target-is-code --target-code-size 100 --vocoder code_hifigan \
  --path /home/hawau.toyin/Documents/s2sdata/exp6/models/checkpoint_best.pt  --gen-subset test \
  --max-tokens 50000 \
  --beam 10 --max-len-a 1 \
  --results-path /home/hawau.toyin/Documents/s2sdata/exp6/preds

 grep "^W\-" /home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-test.txt | \
  sed 's/^W-//ig' | cut -f2,3 \
  > /home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-test.tsv

python /home/hawau.toyin/Documents/nlp/score.py \
 --exp_name 'Pt. kmeans S2UT (reduced)' --test_path '/home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-test.tsv'


echo 'Generating audio starts for test'

grep "^D\-" /home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-test.txt | \
  sed 's/^D-//ig' | sort -nk1 | cut -f3 \
  > /home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-test.unit

python examples/speech_to_speech/generate_waveform_from_code.py \
  --in-code-file /home/hawau.toyin/Documents/s2sdata/exp6/preds/generate-test.unit \
  --vocoder /home/hawau.toyin/Documents/s2sdata/code_hifigan --vocoder-cfg /home/hawau.toyin/Documents/s2sdata/config.json \
  --results-path /home/hawau.toyin/Documents/s2sdata/exp6/audios --dur-prediction


# S2UT (r=5)
echo "Their kmeans S2UT (r=5)"
fairseq-generate /home/hawau.toyin/Documents/exp4  \
  --config-yaml config.yaml  \
  --task speech_to_speech --target-is-code --target-code-size 100 --vocoder code_hifigan \
  --path /home/hawau.toyin/Documents/exp4/models/checkpoint_best.pt  --gen-subset dev \
  --max-tokens 50000 \
  --beam 1 --max-len-a 1 --n-frames-per-step 5\
  --results-path /home/hawau.toyin/Documents/exp4/preds

fairseq-generate /home/hawau.toyin/Documents/exp4  \
  --config-yaml config.yaml  \
  --task speech_to_speech --target-is-code --target-code-size 100 --vocoder code_hifigan \
  --path /home/hawau.toyin/Documents/exp4/models/checkpoint_best.pt  --gen-subset test \
  --max-tokens 50000 \
  --max-len-a 1 \
  --beam 1  --n-frames-per-step 5\
  --results-path /home/hawau.toyin/Documents/exp4/preds

   grep "^W\-" /home/hawau.toyin/Documents/exp4/preds/generate-test.txt | \
  sed 's/^W-//ig' | cut -f2,3 \
  > /home/hawau.toyin/Documents/exp4/preds/generate-test.tsv

 grep "^W\-" /home/hawau.toyin/Documents/exp4/preds/generate-dev.txt | \
  sed 's/^W-//ig' | cut -f2,3 \
  > /home/hawau.toyin/Documents/exp4/preds/generate-dev.tsv

python /home/hawau.toyin/Documents/nlp/score.py --test_path '/home/hawau.toyin/Documents/exp4/preds/generate-test.tsv' \
 --exp_name 'Pt. kmeans S2UT (r=5)' --dev_path '/home/hawau.toyin/Documents/exp4/preds/generate-dev.tsv'





# S2UT (r=1)
echo "Their kmeans S2UT (r=1)"
fairseq-generate /home/hawau.toyin/Documents/s2sdata \
  --config-yaml config.yaml  \
  --task speech_to_speech --target-is-code --target-code-size 100 --vocoder code_hifigan \
  --path /home/hawau.toyin/Documents/exp3/checkpoint_best.pt  --gen-subset dev \
  --max-tokens 50000 \
  --beam 10 --max-len-a 1 \
  --results-path /home/hawau.toyin/Documents/exp3/results


fairseq-generate /home/hawau.toyin/Documents/s2sdata \
  --config-yaml config.yaml  \
  --task speech_to_speech --target-is-code --target-code-size 100 --vocoder code_hifigan \
  --path /home/hawau.toyin/Documents/exp3/checkpoint_best.pt  --gen-subset test \
  --max-tokens 50000 \
  --beam 10 --max-len-a 1 \
  --results-path /home/hawau.toyin/Documents/exp3/results

   grep "^W\-" /home/hawau.toyin/Documents/exp3/results/generate-test.txt | \
  sed 's/^W-//ig' | cut -f2,3 \
  > /home/hawau.toyin/Documents/exp3/results/generate-test.tsv

 grep "^W\-" /home/hawau.toyin/Documents/exp3/results/generate-dev.txt | \
  sed 's/^W-//ig' | cut -f2,3 \
  > /home/hawau.toyin/Documents/exp3/results/generate-dev.tsv

python /home/hawau.toyin/Documents/nlp/score.py --test_path '/home/hawau.toyin/Documents/exp3/results/generate-test.tsv' \
 --exp_name 'Pt. kmeans S2UT (r=1)' --dev_path '/home/hawau.toyin/Documents/exp3/results/generate-dev.tsv'

