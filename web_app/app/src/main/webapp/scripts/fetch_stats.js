const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const nbDays = [31,28,31,30,31,30,31,31,30,31,30,31]; // This script doesn't handle leap years. I made this choice to simplmify implementation.
let date = new Date().toJSON().split('T')[0];
let period = "month";
const periodContainer = document.getElementById('period-container');

function fetchStats(){
    let granularity = document.getElementById('granularity').value;
    let type = document.getElementById('type').value;
    if (type === 'all'){
        type = null;
    }

    switch (period){
        case 'month':
            from = date.split('-')[0] + '-' + date.split('-')[1] + '-01';
            to = date;
            break;
        case 'year':
            from = date.split('-')[0] + '-01-01';
            to = date;
            break;
        case 'all':
            from = "2000-01-01";
            to = date;
            break;
    }
    fetch('/server/api/activity/distanceCovered', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            from: from,
            to: to,
            granularity: granularity,
            type: type
        })
    }).then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    }).then(data => {
        displayStats(data, granularity);
    }).catch(error => {
        console.error('There was an error fetching the distance covered:', error);
        document.getElementById('total-distance').innerHTML = "There was an error loading the distance covered. Please try again later.";
    });
}

function previousPeriod(){
    let periodValue = document.getElementById('period');
    switch (period) {
        case 'month':
            if (parseInt(date.split('-')[1]) === 1){
                date = (parseInt(date.split('-')[0]) - 1) + '-12-' + nbDays[11];
            } else {
                let newMonth = (parseInt(date.split('-')[1]) - 1).toString().padStart(2, '0');
                date = date.split('-')[0] + '-' + newMonth + '-' + nbDays[parseInt(newMonth) - 1];
            }
            periodValue.innerHTML = months[parseInt(date.split('-')[1]) - 1] + ' ' + date.split('-')[0];
            break;
        case 'year':
            date = (parseInt(date.split('-')[0]) - 1) + '-' + date.split('-')[1] + '-' + date.split('-')[2];
            periodValue.innerHTML = date.split('-')[0];
            break;
    }

    fetchStats();
}

function nextPeriod(){
    let periodValue = document.getElementById('period');
    switch (period) {
        case 'month':
            if (parseInt(date.split('-')[1]) === 12){
                date = (parseInt(date.split('-')[0]) + 1) + '-01-' + nbDays[0];
            } else {
                let newMonth = (parseInt(date.split('-')[1]) + 1).toString().padStart(2, '0');
                date = date.split('-')[0] + '-' + newMonth + '-' + nbDays[parseInt(newMonth) - 1];
            }
            periodValue.innerHTML = months[parseInt(date.split('-')[1]) - 1] + ' ' + date.split('-')[0];
            break;
        case 'year':
            date = (parseInt(date.split('-')[0]) + 1) + '-' + date.split('-')[1] + '-' + date.split('-')[2];
            periodValue.innerHTML = date.split('-')[0];
            break;
    }

    fetchStats();
}

function changePeriod(){
    date = new Date().toJSON().split('T')[0];
    let granularity = document.getElementById('granularity').value;
    switch (granularity) {
        case 'day':
            console.log("ok");
            period = "month";
            periodContainer.innerHTML = `
                <button onclick="previousPeriod()">-</button>
                <p id="period">${months[parseInt(date.split('-')[1]) - 1]} ${date.split('-')[0]}</p>
                <button onclick="nextPeriod()">+</button>
            `
            date = date.split('-')[0] + '-' + date.split('-')[1] + '-' + nbDays[parseInt(date.split('-')[1]) - 1];
            break;
        case 'month':
            period = "year";
            periodContainer.innerHTML = `
                <button onclick="previousPeriod()">-</button>
                <p id="period">${date.split('-')[0]}</p>
                <button onclick="nextPeriod()">+</button>
            `
            date = date.split('-')[0] + '-12-31';
            break;
        case 'year':
            period = "all";
            periodContainer.innerHTML = `
            <p>All Time</p>
            `
            date = date.split('-')[0] + '-12-31';
            break;
    }

    fetchStats();
}