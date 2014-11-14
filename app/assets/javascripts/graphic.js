/**
 * Created by alexey on 12.11.14.
 */
function LineChart(data,range,container) {
    this.x_lable = data['x_labels']
    this.data = data;
    this.range=range;
    this.container = container;
    google.load("visualization", "1", {packages:["corechart"]});
    $(document).ready(function() {
        var options = {
            hAxis: {
                title: 'dates of visits',
                titleTextStyle: {
                    color: '#333'
                },
                gridlines: {
                    color: '#f3f3f3',
                }
            },
            vAxis: {
                title: 'sum of visits per date',
                minValue: 1,
                maxValue:7,
                gridlines: {
                    color: '#f3f3f3',
                    count: 7
                },
                format: '#'
            }
        };

        var chart = new google.visualization.AreaChart(document.getElementById(container));
        chart.draw(google.visualization.arrayToDataTable(data), options);
    });
}
