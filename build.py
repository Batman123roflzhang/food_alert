import json
import pickle


with open('./data/food-enforcement-0001-of-0001.json') as f:
    all_strings = f.read()
    data = json.loads(all_strings)

num_of_reports = len(data['results'])
id_report_mapping = dict(zip(range(num_of_reports), data['results']))
# generate dictonary mapping word (should be a food) to report id
word_report_ids_mapping = {}
for i, report in enumerate(data['results']):
    words = report['product_description'].lower().split(' ')
    for w in words:
        if w in word_report_ids_mapping:
            word_report_ids_mapping[w].append(i)
        else:
            word_report_ids_mapping[w] = [i]

with open('./server/data.pkl', 'wb') as out_f:
    pickle.dump([id_report_mapping,  word_report_ids_mapping], out_f)


with open('./data/food.json') as g:
    all_strings2 = g.read()
    data2 = json.loads(all_strings2)

num_of_reports2 = len(data2['results2'])
id_report_mapping2 = dict(zip(range(num_of_reports2), data2['results2']))
# generate dictonary mapping word (should be a food) to report id
word_report_ids_mapping2 = {}
for j, report2 in enumerate(data2['results2']):
    s_words = report2['name'].lower().split(' ')
    for s in s_words:
        if s in word_report_ids_mapping2:
            word_report_ids_mapping2[s].append(j)
        else:
            word_report_ids_mapping2[s] = [j]


with open('./server/data2.pkl', 'wb') as out_g:
    pickle.dump([id_report_mapping2,  word_report_ids_mapping2], out_g)
