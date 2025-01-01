const goalContainer = document.getElementsByClassName('goal-container')[0];
function changeChoice(choice){
    let choiceButton;
    let to_fetch = [];
    reset_buttons();
    switch (choice){
        case 'Active':
            choiceButton = document.getElementById('activeChoice');
            goalContainer.innerHTML = `
                <div id="active">
                    <p>Loading...</p>
                </div>
            `;
            to_fetch = ['getActive'];
            break;
        case 'Past':
            choiceButton = document.getElementById('pastChoice');
            goalContainer.innerHTML = `
                <div style="display: inline-block; width: 48%" id="failed">
                    <p>Loading...</p>
                </div>
                <div style="display: inline-block; width: 48%" id="completed">
                    <p>Loading...</p>
                </div>
            `;
            to_fetch = ['getFailed', 'getCompleted'];
            break;
        case 'Future':
            choiceButton = document.getElementById('futureChoice');
            goalContainer.innerHTML = `
                <div style="diplsay: inline" id="future">
                    <p>Loading...</p>
                </div>
            `;
            to_fetch = ['getFuture'];
            break;
        case 'All':
            choiceButton = document.getElementById('allChoice');
            goalContainer.innerHTML = `
                <div style="display: inline-block; width: 24%;" id="failed">
                    <p>Loading...</p>
                </div>
                <div style="display: inline-block; width: 24%;" id="completed">
                    <p>Loading...</p>
                </div>
                <div style="display: inline-block; width: 24%;" id="active">
                    <p>Loading...</p>
                </div>
                <div style="display: inline-block; width: 24%;" id="future">
                    <p>Loading...</p>
                </div>
            `;
            to_fetch = ['getFailed', 'getActive', 'getCompleted', 'getFuture'];
            break;
    }
    let fetchPromises = to_fetch.map(ressource => {
        return fetch('/server/api/timeGoals/' + ressource)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            }).then(data => {
                displayGoals(data, ressource);
            }).catch(error => {
                console.error('There was an error fetching the goals:', error);
                goalContainer.innerHTML = `
                    <p>There was an error loading goals. Please try again later.</p>
                `;
            });
    });

    Promise.all(fetchPromises).then(() => {
        choiceButton.disabled = true;
    });
}

function displayGoals(data, ressource){
    let container;
    switch (ressource){
        case 'getActive':
            container = document.getElementById('active');
            break;
        case 'getFailed':
            container = document.getElementById('failed');
            break;
        case 'getCompleted':
            container = document.getElementById('completed');
            break;
        case 'getFuture':
            container = document.getElementById('future');
            break;
    }
    if (data && data.length === 0) {
        container.innerHTML = `
            <p>No goals found :(</p>
        `;
    } else {
        container.innerHTML = '<h1>' + ressource.split('get')[1] + ' goals</h1>';
        data.forEach(goal => {
            const goalSection = document.createElement('section');
            goalSection.classList.add('goal');
            goalSection.innerHTML = `
                <h2>${goal.name}</h2>
                <p><strong>Start date:</strong> ${goal.startDate}</p>
                <p><strong>End date:</strong> ${goal.endDate}</p>
                <p><strong>Target:</strong> ${convertTime(goal.target)}</p>
                <p><strong>Progress:</strong> ${goal.completion}%</p>
            `;
            container.appendChild(goalSection);
        });
    }
}

function reset_buttons(){
    let buttons = document.getElementsByClassName('choice-button');
    for (let button of buttons){
        button.disabled = false;
    }
}

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