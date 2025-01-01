import random
from datetime import datetime, timedelta
import requests
from tqdm import tqdm

API_URL = "http://localhost:8080/server/api/activity/add"


def generate_random_date(start_year=2022, end_year=2024):
    """Generates a random date between January 1st of start_year and December 31st of end_year."""
    start_date = datetime(start_year, 1, 1)
    end_date = datetime(end_year, 12, 31)
    random_date = start_date + timedelta(
        days=random.randint(0, (end_date - start_date).days)
    )
    return random_date.strftime("%Y-%m-%d")


def generate_random_activity():
    """Generates a single random activity."""
    activity_types = ["running", "cycling", "swimming"]
    activity = {
        "name": f"Activity {random.randint(1, 1000)}",
        "type": random.choice(activity_types),
        "date": generate_random_date(),
        "time": random.randint(300, 14400),  # 5 minutes to 4 hours in seconds
        "distance": random.randint(500, 50000),  # 500 meters to 50 kilometers
    }
    return activity


def send_activity_to_api(activity):
    """Sends a single activity to the REST API."""
    try:
        response = requests.post(
            API_URL,
            data={
                "name": activity["name"],
                "type": activity["type"],
                "date": activity["date"],
                "time": activity["time"],
                "distance": activity["distance"],
            },
        )
        if (
            response.status_code == 200
        ):
            tqdm.write(f"Successfully added activity: {activity['name']}")
        else:
            tqdm.write(
                f"Failed to add activity: {activity['name']} - Status Code: {response.status_code}"
            )
    except Exception as e:
        tqdm.write(f"Error sending activity {activity['name']}: {e}")


def generate_and_send_activities(sample_size=10):
    """Generates random activities and sends them to the REST API."""
    activities = [generate_random_activity() for _ in range(sample_size)]
    for activity in tqdm(activities):
        send_activity_to_api(activity)


generate_and_send_activities(2000)
