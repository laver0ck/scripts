import requests
import config
import json
import sys
import datetime

KEY = config.weather_api_key
API_LINK = "http://dataservice.accuweather.com"
CELSIUS = "°C"
TODAY = datetime.datetime.now().date()


def main():
    if len(sys.argv) == 2 and sys.argv[1].lower() in ['day', 'daily']:
        today()
    else:
        current()


def today():
    resp = requests.get((
        f"{API_LINK}/forecasts/v1/daily/1day/294021?"
        f"apikey={KEY}&metric=true"))
    json_data = resp.json()['DailyForecasts'][0]
    temp_min = json_data['Temperature']['Minimum']['Value']
    temp_max = json_data['Temperature']['Maximum']['Value']
    current_weather = f"Today's weather in Moscow {TODAY.day}.{TODAY.month}\n"
    current_weather += f"Temperature: {temp_min}{CELSIUS} min, "
    current_weather += f"{temp_max}{CELSIUS} max."

    print(current_weather)


def current():
    resp = requests.get((
        f"{API_LINK}/currentconditions/v1/294021?"
        f"apikey={KEY}&details=false"))
    json_data = resp.json()[0]

    current_weather = "Current weather in Moscow:\n"
    temperature = json_data['Temperature']['Metric']
    degrees = temperature['Value']
    current_weather += f"{degrees}{CELSIUS}\n"
    current_weather += json_data['WeatherText']
    current_weather += f"\n\nMore info:\n{json_data['Link']}"

    print(current_weather)


if __name__ == '__main__':
    main()
