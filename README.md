# Food alert

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

### Server side

- Provide an api that can handle GET request from client in following format:
  `url_root/food/<food_name>`

## Acknowledgement

- iOS app is based on [SeeFood](https://github.com/kingreza/SeeFood).
- Food recall data is from [OpenFDA](https://open.fda.gov/tools/downloads/).
