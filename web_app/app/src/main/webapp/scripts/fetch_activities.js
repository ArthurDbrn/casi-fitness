fetch('/server/api/activity')
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        const activityListDiv = document.getElementById('activity-list');
        if (data && data.length === 0) {
            activityListDiv.innerHTML = `
                <p>You haven't added any activities :( Start getting fit <a href="addActivity.jsp">here</a> !</p>
            `;
        } else {
            activityListDiv.innerHTML = '';
            data.forEach(activity => {
                console.log(activity);
                console.log(activity.name);
                const activitySection = document.createElement('section');
                activitySection.classList.add('activity');

                let time = convertTime(activity.time);

                let distance = convertDistance(activity.distance);

                activitySection.innerHTML = `
                    <h2>${activity.name}</h2>
                    <p><strong style="color: grey;">${activity.type}</strong></p>
                    <p><strong>Distance:</strong> ${distance}</p>
                    <p><strong>Time:</strong> ${time}</p>
                    <p><strong>Date:</strong> ${activity.date}</p>
                `;
                activityListDiv.appendChild(activitySection);
            });
        }
    })
    .catch(error => {
        console.error('There was an error fetching the activities:', error);
        document.getElementById('activity-list').innerHTML = `
            <p>There was an error loading activities. Please try again later.</p>
        `;
    });

function convertTime(time) {
    if (time > 3599){
        let hours = Math.floor(time / 3600);
        let minutes = Math.floor((time % 3600) / 60);
        let seconds = time % 60;
        time = hours + "h " + minutes + "min " + seconds + "s";
    } else if (time > 59){
        let minutes = Math.floor(time / 60);
        let seconds = time % 60;
        time = minutes + "min " + seconds + "s";
    } else {
        time = time + "s";
    }
    return time;
}

function convertDistance(distance){
    if (distance > 999){
        let km = distance / 1000;
        distance = km + "km ";
    } else {
        distance = distance + "m";
    }
    return distance;
}