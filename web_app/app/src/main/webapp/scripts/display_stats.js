let currentChart = null;

function displayStats(data, granularity) {
    if (currentChart) {
        currentChart.destroy();
    }

    let xValues, yValues;
    if (granularity === 'day') {
        xValues = Array.from({ length: 31 }, (_, i) => i + 1);
        yValues = Array.from({ length: 31 }, () => 0);
        for (let i = 0; i < data.length; i++) {
            yValues[xValues.indexOf(data[i][0])] = data[i][1]/1000;
        }
    } else if (granularity === 'month') {
        xValues = months;
        yValues = Array.from({ length: 12 }, () => 0);
        for (let i = 0; i < data.length; i++) {
            yValues[data[i][0]-1] = data[i][1]/1000;
        }
    } else if (granularity === 'year') {
        var result = data.reduce(
            (acc, [firstField]) => {
                acc.min = Math.min(acc.min, firstField);
                acc.max = Math.max(acc.max, firstField);
                return acc;
            },
            { min: Infinity, max: -Infinity }
        );
        console.log(`Min: ${result.min}, Max: ${result.max}`);
        xValues = Array.from({ length: result.max - result.min + 1 }, (_, i) => i + result.min);
        yValues = Array.from({ length: result.max - result.min + 1 }, () => 0);
        for (let i = 0; i < data.length; i++) {
            yValues[xValues.indexOf(data[i][0])] = data[i][1]/1000;
        }
    }

    var barColors = ["green"];

    currentChart = new Chart('distanceChart', {
        type: 'bar',
        data: {
            labels: xValues,
            datasets: [{
                label: 'Distance covered',
                data: yValues,
                backgroundColor: barColors
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}