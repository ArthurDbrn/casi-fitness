import random
from datetime import datetime, timedelta
import requests
from tqdm import tqdm

API_URL = "http://localhost:8080/server/api/timeGoals/add"


def generate_random_date(start_year=2022, end_year=2025):
    """Generates a random date between January 1st of start_year and December 31st of end_year."""
    start_date = datetime(start_year, 1, 1)
    end_date = datetime(end_year, 12, 31)
    random_date = start_date + timedelta(
        days=random.randint(0, (end_date - start_date).days)
    )
    return random_date


def generate_random_goal():
    """Generates a single random goal."""
    start_date = generate_random_date()
    end_date = start_date + timedelta(days=random.randint(1, 365))
    target = random.randint(1000, 50000)  # Random target value for the goal

    goal = {
        "name": f"Goal {random.randint(1, 1000)}",
        "startDate": start_date.strftime("%Y-%m-%d"),
        "endDate": end_date.strftime("%Y-%m-%d"),
        "target": target,
    }
    return goal


def send_goal_to_api(goal):
    """Sends a single goal to the REST API."""
    try:
        response = requests.post(
            API_URL,
            data={
                "name": goal["name"],
                "startDate": goal["startDate"],
                "endDate": goal["endDate"],
                "target": goal["target"],
            },
        )
        if response.status_code == 200:
            tqdm.write(f"Successfully added goal: {goal['name']}")
        else:
            tqdm.write(
                f"Failed to add goal: {goal['name']} - Status Code: {response.status_code} - {response.reason}"
            )
    except Exception as e:
        tqdm.write(f"Error sending goal {goal['name']}: {e}")


def generate_and_send_goals(sample_size=10):
    """Generates random goals and sends them to the REST API."""
    goals = [generate_random_goal() for _ in range(sample_size)]
    for goal in tqdm(goals):
        send_goal_to_api(goal)


generate_and_send_goals(20)
