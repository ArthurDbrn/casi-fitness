let date = new Date().toJSON().split('T')[0];
let from = date.split('-')[0] + '-' + date.split('-')[1] + '-01';
let to = date;
fetch('/server/api/activity/distanceCovered', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        from: from,
        to: to,
        granularity: 'month',
    })
}).then(response => {
    if (!response.ok) {
        throw new Error('Network response was not ok');
    }
    return response.json();
}).then(data => {
    console.log(data);
    const distanceCovered = document.getElementById('total-distance');
    if(data && data.length === 0) {
        distanceCovered.innerHTML = "0km";
    } else {
        distanceCovered.innerHTML = convertDistance(data[0][1]);
    }
}).catch(error => {
    console.error('There was an error fetching the distance covered:', error);
    document.getElementById('total-distance').innerHTML = "There was an error loading the distance covered. Please try again later.";
});

fetch('/server/api/activity/timeSpent', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        from: from,
        to: to,
        granularity: 'month',
    })
}).then(response => {
    if (!response.ok) {
        throw new Error('Network response was not ok');
    }
    return response.json();
}).then(data => {
    console.log(data);
    const timeSpent = document.getElementById('total-time');
    if(data && data.length === 0) {
        timeSpent.innerHTML = "0s";
    } else {
        timeSpent.innerHTML = convertTime(data[0][1]);
    }
}).catch(error => {
    console.error('There was an error fetching the distance covered:', error);
    document.getElementById('total-time').innerHTML = "There was an error loading the distance covered. Please try again later.";
});