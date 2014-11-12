/**
 * Created by alexey on 12.11.14.
 */

function LineChart(data, container) {
    this.data = data;
    this.container = container;
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(jQuery.proxy(this.render, this));
}

LineChart.prototype.render = function() {
    var options = {
        title: 'Company Performance',
        vAxis: {title: 'Year',  titleTextStyle: {color: '#333'}},
        hAxis: { ticks: [0,25,50,75,100,125,150,175] }
    };

    var chart = new google.visualization.AreaChart(document.getElementById(this.container));
    chart.draw(google.visualization.arrayToDataTable(this.data), options);
};
