//= require jquery
//= require jquery_ujs
//=require jquery.tablesorter.js
//= require_self
//= require_tree .
$(document).ready(function() {
    $(".check_all").click(function () {
        $('input[type="checkbox"]', $(this.form)).prop("checked", $(this).prop('checked'));
    });
    // (function(document) {
    'use strict';
    var LightTableFilter = (function (Arr) {

        var _input;

        function _onInputEvent(e) {
            _input = e.target;
            var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
            Arr.forEach.call(tables, function (table) {
                Arr.forEach.call(table.tBodies, function (tbody) {
                    Arr.forEach.call(tbody.rows, _filter);
                });
            });
        }

        function _filter(row) {
            var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
            row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
        }

        return {
            init: function () {
                var inputs = document.getElementsByClassName('light-table-filter');
                Arr.forEach.call(inputs, function (input) {
                    input.oninput = _onInputEvent;
                });
            }
        };
    })(Array.prototype);
    document.addEventListener('readystatechange', function () {
        if (document.readyState === 'complete') {
            LightTableFilter.init();
        }
    });
    $(".order-table").tablesorter(
        {
            sortList: [[0,0],[2,0]],
            headers: {
                // работаем со второй колонкой (подсчет идет с нуля)
                1: {
                    // запрет сортировки указанием свойства
                    sorter: false
                },
                // работаем со третьей колонкой (подсчет идет с нуля)
                3: {
                    // запрещаем, использовав свойство
                    sorter: false
                },
                4: {
                    // запрещаем, использовав свойство
                    sorter: false
                },
                5: {
                    // запрещаем, использовав свойство
                    sorter: false
                }
            }
        }
    );
    $('.light-table-filter').on('click', function(e) {
        e.stopPropagation();
        this.focus();

    })

});