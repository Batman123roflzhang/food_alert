from flask import Flask, jsonify
import pickle
from os.path import abspath, dirname, join

here = dirname(abspath(__file__))
app = Flask(__name__)

with open(join(here, 'data.pkl'), 'rb') as f:
    id_report_mapping,  word_report_ids_mapping = pickle.load(f)

with open(join(here, 'data2.pkl'), 'rb') as g:
    id_report_mapping2,  word_report_ids_mapping2 = pickle.load(g)

@app.route('/food/<food_name>')
def get_food_info(food_name):
    if food_name in word_report_ids_mapping:
        ids = word_report_ids_mapping[food_name]
        num_of_report = len(ids)
        report_classes = []
        for i in ids:
            report_classes.append(id_report_mapping[i]['classification'])
        num_class_1 = report_classes.count('Class I')
        num_class_2 = report_classes.count('Class II')
        num_class_3 = report_classes.count('Class III')
        ratings_recall = 100 - num_class_3 - 0.6 * num_class_2 - 0.3 * num_class_1

        if food_name in word_report_ids_mapping2:
            ids2 = word_report_ids_mapping2[food_name]
            protein = []
            sugars = []
            carbohydrate = []
            fat = []
            for j in ids2:
                if 'nutrition-per-100g' in id_report_mapping2[j]:
                    key = 'nutrition-per-100g'
                else:
                    key = 'nutrition-per-100ml'
                energy = id_report_mapping2[j][key]['energy']
                protein = id_report_mapping2[j][key]['protein']
                sugars = id_report_mapping2[j][key]['sugars']
                carbohydrate = id_report_mapping2[j][key]['carbohydrate']
                fat = id_report_mapping2[j][key]['fat']
                trans_fat = id_report_mapping2[j][key]['trans-fat']
                if trans_fat >= 1:
                    much_trans_fat = True
                else:
                    much_trans_fat = False
                nutrition_ratings = 100 - 0.05*energy + 1 * protein - 0.5 * sugars - 0.05 * fat - 0.1*trans_fat

        return jsonify({
            'num_of_report': num_of_report,
            'food_name': food_name,
            'num_class_1': num_class_1,
            'num_class_2': num_class_2,
            'num_class_3': num_class_3,
            'return_ratings': ratings_recall,
            'energy': energy,
            'protein': protein,
            'sugars': sugars,
            'carbohydrate': carbohydrate,
            'fat': fat,
            'much_trans_fat': much_trans_fat,
            'nutrition_ratings': nutrition_ratings
        })
    else:
        return jsonify({
            'food_name': food_name,
        })
