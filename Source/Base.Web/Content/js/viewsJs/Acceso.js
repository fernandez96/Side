var urlMantenimiento = baseUrl + 'Usuario/';
var dataTableRol = null;
var delRowID = 0;
var delRowPos = null;
var urlListar = baseUrl + 'Acceso/Listar';
var nombreRol = null;
$(document).ready(function () {
    $.extend($.fn.dataTable.defaults, {
        language: { url: baseUrl + 'Content/js/dataTables/Internationalisation/es.txt' },
        responsive: true,
        "lengthMenu": [[10, 25, 50, 100], [10, 25, 50, 100]],
        "bProcessing": true,
        "dom": 'fltip',
        "paging":   false,
        "ordering": false,
        "info":     false
    });
    checkSession(function () {
        VisualizarDataTableRol();
    });

    $('body').on('click', 'a.verPermiso', function () {
        var aPos = dataTableRol.fnGetPosition(this.parentNode.parentNode);
        var aData = dataTableRol.fnGetData(aPos[0]);
        var rowID = aData.Id;

        nombreRol = aData.Nombre;
        delRowPos = aPos[0];
        delRowID = rowID;

        
        checkSession(function () {
            AsignarRol();
        });
    });
});

function VisualizarDataTableRol() {
    dataTableRol = $('#RolDataTable').dataTable({
        "bFilter": false,
        "bProcessing": true,
        "serverSide": true,
        //"scrollY": "350px",              
        "ajax": {
            "url": urlListar,
            "type": "POST",
            "data": function (request) {
               
            },
            dataFilter: function (data) {
                if (data.substring(0, 9) == "<!DOCTYPE") {
                    redireccionarLogin("Sesión Terminada", "Se terminó la sesión");
                } else {
                    return data;
                    //var json = jQuery.parseJSON(data);
                    //return JSON.stringify(json); // return JSON string
                }
            }
        },
        "bAutoWidth": false,
        "columns": [
            
            { "data": "Id" },
            { "data": "Nombre" },
            
            {
                "data": function (obj) {
                    return '<div class="action-buttons">\
                       <a class="blue verPermiso" href="javascript:void(0)"><i class="ace-icon fa fa-eye bigger-130"></i></a>\
                    </div>';
                }
            }
        ],
        "aoColumnDefs": [
            { "className": "hidden-100", "aTargets": [0], "width": "20%" },
            { "className": "hidden-50", "aTargets": [1], "width": "10%" },
            { "bSortable": false, "sClass": "center", "aTargets": [2], "width": "10%" },
        ],
        "order": [[1, "desc"]],
        "initComplete": function (settings, json) {
           // AddSearchFilter();
        },
        "fnDrawCallback": function (oSettings) {

        }
    });
}

function AsignarRol() {
    
    $("#idrol").text(nombreRol);
}