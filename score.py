from evaluate import load
import argparse
import csv
wer = load("wer")
tsv_file_path = "/home/hawau.toyin/Documents/nlp/werResults.tsv"
parser = argparse.ArgumentParser(description="Process two file paths")
parser.add_argument("--test_path", type=str, help="path to first file")
parser.add_argument("--dev_path", type=str, help="path to second file")
parser.add_argument("--exp_name", type=str, help="name of experiment")
args = parser.parse_args()

if args.test_path:
    pred = []
    target = [] 
    with open(args.test_path, "r") as f:
        for line in f:
            line = line.strip().split("\t")
            target.append(line[0])
            pred.append(line[1])

    test_score = wer.compute(predictions=pred, references= target)
else:
    test_score = None

if args.dev_path:
    pred = []
    target = [] 
    with open(args.dev_path, "r") as f:
        for line in f:
            line = line.strip().split("\t")
            target.append(line[0])
            pred.append(line[1])

    dev_score = wer.compute(predictions=pred, references= target)
else:
    dev_score = None


new_row = [args.exp_name,test_score, dev_score]

with open(tsv_file_path, "a", newline="\n") as f:
    writer = csv.writer(f, delimiter="\t")
    writer.writerow(new_row)


