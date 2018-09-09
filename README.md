# Food alert

Food alert is a hackathon project developed by [Yi Hsiao](https://github.com/hsiaoyi0504/), [Robert Zhang](https://github.com/Batman123roflzhang), [Andy Chien](https://github.com/hellosirandy), and [Angela Ho](https://github.com/angelaho0504) together at [2018 MedHacks](https://medhacks.org/2018/index.html). Devpost project is available at [https://devpost.com/software/food-alert-20gn58](https://devpost.com/software/food-alert-20gn58).

## Prerequisite

### Server

- Python 3

### iOS app

- [COCOAPODS](https://cocoapods.org/)

## Installation

``` shell
git clone https://github.com/hsiaoyi0504/food_alert
cd food_alert
```

### Flask server

``` shell
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python build.py  # build the data that will be used by server
```

### iOS app dependencies

``` shell
cd app
pod install
```

## Usage

### Start the server

`FLASK_APP=server/main.py flask run`

## Notes

- Keynote report of this project is included in [food_alert_presentation.key](food_alert_presentation.key).
- A list of all 101 categories of food of Food-101 dataset is available [here](https://github.com/alpapado/food-101/blob/master/data/meta/classes.txt).

### Server side

- Provide an api that can handle GET request from client in following format:
  `url_root/food/<food_name>`

## Acknowledgement

- iOS app is based on [SeeFood](https://github.com/kingreza/SeeFood).
- Food recall data is from [OpenFDA](https://open.fda.gov/tools/downloads/).
