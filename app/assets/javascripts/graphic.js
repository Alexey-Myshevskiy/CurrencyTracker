/**
 * Created by alexey on 12.11.14.
 */
function LineChart(data,container) {

    this.data = data;
    //this.range=range;
    this.container = container;
    google.load("visualization", "1", {packages:["corechart"]});
    $(document).ready(function() {
        var options = {
            title: 'Company Performance',
            vAxis: {title: 'total visits',titleTextStyle: {color: '#333'}},
            hAxis: { title: "date"}
        };
        var chart = new google.visualization.AreaChart(document.getElementById(container));
        chart.draw(google.visualization.arrayToDataTable(data), options);
    });
}
