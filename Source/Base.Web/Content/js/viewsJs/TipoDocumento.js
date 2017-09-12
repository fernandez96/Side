var dataTableTipoDocumento = null;
var formularioMantenimiento = "UsuarioForm";
var delRowPos = null;
var delRowID = 0;
var urlListar = baseUrl + 'TipoDocumento/Listar';
var urlMantenimiento = baseUrl + 'TipoDocumento/';
var urlListaCargo = baseUrl + 'TipoDocumento/';
var rowUsuario = null;

$(document).ready(function () {
    $.extend($.fn.dataTable.defaults, {
        language: { url: baseUrl + 'Content/js/dataTables/Internationalisation/es.txt' },
        responsive: true,
        "lengthMenu": [[10, 25, 50, 100], [10, 25, 50, 100]],
        "bProcessing": true,
        "dom": 'fltip'
    });

    checkSession(function () {
        VisualizarDataTableUsuario();
    });

    $('#btnAgregarTipodocumento').on('click', function () {
        //LimpiarFormulario();

        $("#UsuarioId").val(0);
        $("#accionTitle").text('Nuevo');
        $("#NuevoUsuario").modal("show");
    });

    $('body').on('click', 'a.editarUsuario', function () {
        rowUsuario = this;
        checkSession(function () {
            GetUsuarioById();
        });
    });

    $('body').on('click', 'a.eliminarUsuario', function () {
        var aPos = dataTableTipoDocumento.fnGetPosition(this.parentNode.parentNode);
        var aData = dataTableTipoDocumento.fnGetData(aPos[0]);
        var rowID = aData.Id;

        delRowPos = aPos[0];
        delRowID = rowID;

        webApp.showDeleteConfirmDialog(function () {
            checkSession(function () {
                EliminarUsuario();
            });
        }, 'Se eliminará el registro. ¿Está seguro que desea continuar?');
    });

    $('body').on('click', 'a.btnBuscarUsuario', function () {

        $("#searchFilterUsuario").modal("show");
    });

    $("#btnSearchTipoDocumento").on("click", function (e) {
        if ($('#TipoDocumentoSearchForm').valid()) {
            checkSession(function () {
                var aData = $("#TipoDocumentoDataTable  >tbody >tr").length;
                dataTableTipoDocumento.fnReloadAjax();
                
                 $("#idresult").text(aData);
            });
        }
        e.preventDefault();
    });

    $("#btnGuardarUsuario").on("click", function (e) {

        if ($('#' + formularioMantenimiento).valid()) {

            webApp.showReConfirmDialog(function () {
                checkSession(function () {
                    GuardarUsuario();
                });
            });
        }

        e.preventDefault();
    });

    webApp.validarLetrasEspacio(['Username', 'Nombre', 'Apellido']);
    $('#Correo').validCampoFranz('@abcdefghijklmnÃ±opqrstuvwxyz_1234567890.');

    webApp.InicializarValidacion(formularioMantenimiento,
        {
            Username: {
                required: true,
                noPasteAllowLetterAndSpace: true,
                firstCharacterBeLetter: true
            },
            Nombre: {
                required: true,
                noPasteAllowLetterAndSpace: true,
                firstCharacterBeLetter: true
            },
            Apellido: {
                required: true,
                noPasteAllowLetterAndSpace: true,
                firstCharacterBeLetter: true
            },
            Correo: {
                required: true,
                correoElectronico: true,
                firstCharacterBeLetter: true
            },
            CargoId: {
                required: true
            },
            RolId: {
                required: true
            }
        },
        {
            Username: {
                required: "Por favor ingrese Usuario",

            },
            Nombre: {
                required: "Por favor ingrese Nombre"
            },
            Apellido: {
                required: "Por favor ingrese Apellido"
            },
            Correo: {
                required: "Por favor ingrese Correo",
                correoElectronico: "Por favor ingrese Correo valido"
            },
            CargoId: {
                required: "Por favor seleccione Cargo"
            },
            RolId: {
                required: "Por favor seleccione Rol"
            }
        });

});

function VisualizarDataTableUsuario() {
    dataTableTipoDocumento = $('#TipoDocumentoDataTable').dataTable({
        "bFilter": false,
        "bProcessing": true,
        "serverSide": true,
        //"scrollY": "350px",              
        "ajax": {
            "url": urlListar,
            "type": "POST",
            "data": function (request) {
                request.filter = new Object();

                request.filter = {
                    codigoSearch: $("#Codigosearch").val(),
                    descripcionSearch: $("#Descripcionsearch").val()
                }
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
            {
                "data": function (obj) {

                    return '<div class="action-buttons">\
                    <a class="green editarUsuario" href="javascript:void(0)"><i class="ace-icon fa fa-pencil bigger-130"></i></a>\
                    <a class="red eliminarUsuario" href="javascript:void(0)"><i class="ace-icon fa fa-trash-o bigger-130"></i></a>\
                    </div>';
                }
            },
            { "data": "Id" },
            { "data": "tdocc_vabreviatura_tipo_doc" },
            { "data": "tdocc_vdescripcion" },
            {
                "data": function (obj) {
                    if (obj.Estado == "1")
                        return '<span class="label label-info label-sm arrowed-in arrowed-in-right">Activo</span>';
                    else
                        return '<span class="label label-sm arrowed-in arrowed-in-right">Inactivo</span>';
                }
            }
        ],
        "aoColumnDefs": [
            { "bSortable": false, "sClass": "center", "aTargets": [0], "width": "10%" },
            { "bVisible": false, "aTargets": [1] },
            { "aTargets": [2], "width": "10%" },
            { "className": "hidden-1200", "aTargets": [3], "width": "18%" },
            { "className": "hidden-1200", "aTargets": [0], "width": "4%" },
    
            { "bSortable": false, "className": "hidden-480", "aTargets": [4], "width": "10%" }

        ],
        "order": [[1, "desc"]],
        "initComplete": function (settings, json) {
            //AddSearchFilter();
        },
        "fnDrawCallback": function (oSettings) {

        }
    });
}